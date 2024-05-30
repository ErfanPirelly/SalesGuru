//
//  ConversationVC.swift
//  SalesGuru
//
//  Created by mmdMoovic on 4/29/24.
//

import UIKit

class ConversationVC: UIViewController {
    // MARK: - properties
    private let customView = SingleChatView()
    private let data = MockData.conversationMessages
    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
        
    }
    
    // MARK: - prepare UI
    private func prepareUI() {
        view.backgroundColor = .white
        customView.delegate = self
        view.addSubview(customView)
        customView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(CustomTabBarView.Height)
        }
    }
}

// MARK: - view delegate
extension ConversationVC: SingleChatViewDelegate {
    func isPreviousMessageSameSender(at indexPath: IndexPath) -> Bool {
        guard indexPath.section - 1 >= 0 else { return false }
        return data[indexPath.section].user.id == data[indexPath.section - 1].user.id
    }
    
    func isNextMessageSameSender(at indexPath: IndexPath) -> Bool {
        guard indexPath.section + 1 < data.count else { return false }
        return data[indexPath.section].user.id == data[indexPath.section + 1].user.id
    }
    
    func isDateChanges(at index: IndexPath) -> Bool {
        return index.section == 3
    }
    
    func backButtonDidTouched() {
        
    }
    
    func moreButtonDidTouched() {
        
    }
    
    func aiButtonDidTouched() {
        
    }
    
    func isFromCurrentUser(at index: IndexPath) -> Bool {
        return data[index.section].user.id == 0
    }
    
    func getPositionForMessage(at index: IndexPath) -> MessagePosition {
        var position: MessagePosition = .first
        if isDateChanges(at: index) {
            return .first
        }
        
        if !isPreviousMessageSameSender(at: index) {
            position = isNextMessageSameSender(at: index) ? .first : .single
        } else if isNextMessageSameSender(at: index) {
            position = .middle
        } else {
            position = .last
        }
        
        return position
    }
}
