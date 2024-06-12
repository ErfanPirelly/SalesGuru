//
//  ConversationVC.swift
//  SalesGuru
//
//  Created by mmdMoovic on 4/29/24.
//

import UIKit
import Toast_Swift

class ConversationVC: UIViewController {
    // MARK: - properties
    private let customView = SingleChatView()
    private let viewModel: ConversationVM
    private var searchTxt: String?
    private var searchResultsIndices: [IndexPath] = []
    private var currentResultIndex: Int = -1
    
    // MARK: - init
    init(viewModel: ConversationVM) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
        if viewModel.chat == nil {
            self.viewModel.getChat { [weak self] chat in
                guard let self = self else { return }
                if chat == nil {
                    self.showError(message: "There is no conversation with this information", duration: 2)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {[weak self] in
                        guard let self = self else { return }
                        self.backButtonDidTouched()
                    }
                }
                self.configView()
            }
        }
        viewModel.getMessages { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success:
                self.configView()
                
            case .failure(let failure):
                Logger.log(.error, failure.localizedDescription)
                self.showError(message: failure.localizedDescription)
            }
        }
    }
    
    func configView() {
        guard let messages = viewModel.messageList, let chat = viewModel.chat else {return}
        self.customView.configView(with: messages, for: chat)
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
    
    override func showError(message: String, duration: TimeInterval = ToastManager.shared.duration) {
        var style = ToastStyle()
        style.backgroundColor = .ui.cancel
        style.titleFont = .Fonts.bold(17)
        style.messageFont = .Fonts.normal(14)
        style.titleAlignment = .center
        style.messageAlignment = .center
        style.messageColor = .ui.white
        style.titleColor = .ui.white
        style.maxWidthPercentage = 0.94
        style.verticalPadding = 24
        
        self.customView.makeToast(message,
                            duration: duration,
                            position: .bottom,
                            title: "Error",
                            style: style, completion: nil)
    }
}


// MARK: - search result delegate
extension ConversationVC: SearchResultViewDelegate {
    func searchForPreviousResult() {
        guard !searchResultsIndices.isEmpty, currentResultIndex > 0 else { return }
        let previousIndex = currentResultIndex
        currentResultIndex -= 1
        highlightSearchResult(at: currentResultIndex, previousIndex: previousIndex)
    }
    
    func searchForNextResult() {
        guard !searchResultsIndices.isEmpty else {
            return }
        
        let previousIndex = currentResultIndex
        currentResultIndex += 1
        
        if currentResultIndex >= self.searchResultsIndices.count {
            return
        }
        
        highlightSearchResult(at: currentResultIndex, previousIndex: previousIndex)
    }
    
    func didFindResult() -> Bool {
        true
    }
    
    func setupSearchData() {
        guard let searchTxt = searchTxt, let messageList = viewModel.messageList else { return }
        var messages: [IndexPath] = []
        for (sectionIndex, section) in messageList.enumerated() {
            for (messageIndex, message) in section.messages.enumerated() {
                if message.contains(txt: searchTxt) {
                    messages.append(IndexPath(row: messageIndex, section: sectionIndex))
                }
            }
        }
        self.searchResultsIndices = messages.reversed()
        currentResultIndex = -1
        searchForNextResult()
    }
    
    func highlightSearchResult(at index: Int, previousIndex: Int = -1) {
        var previousIndexPath: IndexPath?
        if previousIndex >= 0 {
            previousIndexPath = searchResultsIndices[previousIndex]
        }
        customView.highlightResult(at: searchResultsIndices[currentResultIndex], previousIndexPath: previousIndexPath)
    }
}

// MARK: - nav bar delegate
extension ConversationVC: ConversationNavigationBarViewDelegate {
    func moreButtonDidTouched() {}
    
    func didEndSearching() {
        self.searchTxt = nil
        customView.clearSearchResult(hide: true)
    }
    
    func didSearch(with text: String?) {
        searchTxt = text
        setupSearchData()
        if text == nil {
            customView.clearSearchResult(hide: false)
        } else {
            customView.configSearchResult(all: searchResultsIndices.count)
        }
    }
    
    func backButtonDidTouched() {
        navigationController?.popViewController(animated: true)
    }
    
    func aiButtonDidTouched() {
        guard let chat = viewModel.chat else {return}
        let vc = AISettingVC(settings: chat.getAISetting(), chatId:  chat.id ?? "")
        view.window?.rootViewController?.presentWithSheetPresentation(vc, isDismissable: true)
    }
}

// MARK: - input bar delegate
extension ConversationVC: ChatInputBarViewDelegate {
    func sendMessage(with text: String) {
        let id = UUID().uuidString
        let tempMessage = RMMessage(id: id, content: text, receive: false, timestamp: Date().timeIntervalSince1970 * 1000)
        if let index = self.viewModel.replaceMessage(message: tempMessage).findMessageIndex(with: id) {
            self.customView.insertMessage(to: viewModel.messageList ?? [], index: index)
        }
        
        viewModel.sendMessage(with: text) { [weak self] message in
            guard let self = self else { return }
            if var newMessage = message {
                newMessage.id = id
                let datSource = self.viewModel.replaceMessage(message: newMessage).messageList ?? []
                self.customView.updateDataSource(with: datSource)
            } else {
                self.showError(message: "Something went wrong!")
                if let index = viewModel.findMessageIndex(with: id) {
                    let dataSource = self.viewModel.deleteMessage(with: id).messageList ?? []
                    self.customView.removeMessage(for: dataSource, index: index)
                }
            }
        }
    }
    
    func aiTimerDidTap() {
        let vc = DisableAIVC()
        view.window?.rootViewController?.presentWithCenterPresentation(vc, isDismissable: true)
    }
}

// MARK: - more view delegate
extension ConversationVC: ChatMoreViewDelegate {
    func copyLinkDidTouched() {
        
    }
    
    func deleteChatDidTouched() {
        
    }
}
// MARK: - view delegate
extension ConversationVC: SingleChatViewDelegate {
    func isPreviousMessageSameSender(at indexPath: IndexPath) -> Bool {
        viewModel.isPreviousMessageSameSender(at: indexPath)
    }
    
    func isNextMessageSameSender(at indexPath: IndexPath) -> Bool {
        viewModel.isNextMessageSameSender(at: indexPath)
    }
    
    func isDateChanges(at index: IndexPath) -> Bool {
        viewModel.isDateChanges(at: index)
    }
    
    func isFromCurrentUser(at index: IndexPath) -> Bool {
        viewModel.isFromCurrentUser(at: index)
    }
    
    func getPositionForMessage(at index: IndexPath) -> MessagePosition {
        var position: MessagePosition = .first
        if isDateChanges(at: index) {
            if isNextMessageSameSender(at: index) {
                position = .first
            } else {
                position = .single
            }
            return position
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
