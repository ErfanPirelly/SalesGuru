//
//  KeyboardManager.swift
//  SalesGuru
//
//  Created by Erfan mac mini on 5/24/24.
//

import UIKit
import Combine

class ChatKeyboardObserver: NSObject {
  // MARK: Internal
    var disposeBag = Set<AnyCancellable>()
    let textView: UITextView
    let scrollView: UIScrollView
    let textViewContainer: UIView
    
    init(textView: UITextView, scrollView: UIScrollView, textViewContainer: UIView) {
        self.textView = textView
        self.scrollView = scrollView
        self.textViewContainer = textViewContainer
    }
    
    public func setupObserver() {
        addKeyboardObservers()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
  // MARK: - Register Observers
  internal func addKeyboardObservers() {
    /// Observe didBeginEditing to scroll content to last item if necessary
    NotificationCenter.default
      .publisher(for: UITextView.textDidBeginEditingNotification)
      .subscribe(on: DispatchQueue.global())
      /// Wait for inputBar frame change animation to end
      .delay(for: .milliseconds(200), scheduler: DispatchQueue.main)
      .receive(on: DispatchQueue.main)
      .sink { [weak self] notification in
        self?.handleTextViewDidBeginEditing(notification)
      }
      .store(in: &disposeBag)

    NotificationCenter.default
      .publisher(for: UITextView.textDidChangeNotification)
      .subscribe(on: DispatchQueue.global())
      .receive(on: DispatchQueue.main)
      .compactMap { $0.object as? UITextView }
      .filter { [weak self] textView in
        textView == self?.textView
      }
      .map(\.text)
      .removeDuplicates()
      .delay(for: .milliseconds(50), scheduler: DispatchQueue.main) /// Wait for next runloop to lay out inputView properly
      .sink { [weak self] _ in
        self?.updateMessageCollectionViewBottomInset()
//
//        if !(self?.maintainPositionOnInputBarHeightChanged ?? false) {
//          self?.messagesCollectionView.scrollToLastItem()
//        }
      }
      .store(in: &disposeBag)

    /// Observe frame change of the input bar container to update collectioView bottom inset
      textViewContainer.publisher(for: \.center)
      .receive(on: DispatchQueue.main)
      .removeDuplicates()
      .sink(receiveValue: { [weak self] _ in
        self?.updateMessageCollectionViewBottomInset()
      })
      .store(in: &disposeBag)
  }

  // MARK: - Updating insets

  /// Updates bottom messagesCollectionView inset based on the position of inputContainerView
  internal func updateMessageCollectionViewBottomInset() {
    let viewHeight = scrollView.frame.maxY
    let newBottomInset = viewHeight - (textViewContainer.frame.minY - 12) -
      automaticallyAddedBottomInset
//      print("insets for table:", messageInputBar.frame.minY, bottomStack.frame.minY)
    let normalizedNewBottomInset = max(0, newBottomInset)
    let differenceOfBottomInset = newBottomInset - messageCollectionViewBottomInset

    UIView.performWithoutAnimation {
      guard differenceOfBottomInset != 0 else { return }
        scrollView.contentInset.bottom = normalizedNewBottomInset
        scrollView.verticalScrollIndicatorInsets.bottom = newBottomInset
    }
  }

  // MARK: Private

  /// UIScrollView can automatically add safe area insets to its contentInset,
  /// which needs to be accounted for when setting the contentInset based on screen coordinates.
  ///
  /// - Returns: The distance automatically added to contentInset.bottom, if any.
  private var automaticallyAddedBottomInset: CGFloat {
      scrollView.adjustedContentInset.bottom - messageCollectionViewBottomInset
  }

  private var messageCollectionViewBottomInset: CGFloat {
      scrollView.contentInset.bottom
  }

  /// UIScrollView can automatically add safe area insets to its contentInset,
  /// which needs to be accounted for when setting the contentInset based on screen coordinates.
  ///
  /// - Returns: The distance automatically added to contentInset.top, if any.
  private var automaticallyAddedTopInset: CGFloat {
      scrollView.adjustedContentInset.top - messageCollectionViewTopInset
  }

  private var messageCollectionViewTopInset: CGFloat {
      scrollView.contentInset.top
  }

  // MARK: - Private methods
  private func handleTextViewDidBeginEditing(_ notification: Notification) {
      guard let inputTextView = notification.object as? UITextView,
        inputTextView === inputTextView
      else {
        return
      }
      
      (scrollView as? UITableView)?.scrollToLastItem()
  }
}
