//
//  SingleChatView.swift
//  SalesGuru
//
//  Created by Erfan mac mini on 5/18/24.
//

import UIKit

protocol SingleChatViewDelegate: ConversationNavigationBarViewDelegate,
                                 ChatInputBarViewDelegate,
                                 ChatMoreViewDelegate {
    func isFromCurrentUser(at index: IndexPath) -> Bool
    func isDateChanges(at index: IndexPath) -> Bool
    func isPreviousMessageSameSender(at indexPath: IndexPath) -> Bool
    func getPositionForMessage(at index: IndexPath) -> MessagePosition
}

class SingleChatView: UIView {
    // MARK: - properties
    private let moreView = ChatMoreView()
    private let tableView = UITableView(frame: .zero, style: .grouped)
    private var dataSource: [MessageSections] = []
    private let navBar = ConversationNavigationBarView()
    private let inputBar = ChatInputBarView()
    private let keyboardManager = KeyboardManager()
    private var chatKeyboardObserver: ChatKeyboardObserver!
    private var chat: RMChat?
    weak var delegate: SingleChatViewDelegate? {
        didSet {
            inputBar.delegate = delegate
        }
    }
    
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupGesture()
        setupKeyboardManager()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - setupUI
    private func setupUI() {
        backgroundColor = .ui.backgroundColor4
        setupFilterView()
        setupTableView()
        setupInputBar()
        setupMoreView()
        setupConstraints()
    }
    
    private func setupGesture() {
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapGestureAction)))
    }
    
    private func setupFilterView() {
        navBar.translatesAutoresizingMaskIntoConstraints = false
        navBar.delegate = self
        addSubview(navBar)
    }
    
    private func setupMoreView() {
        moreView.translatesAutoresizingMaskIntoConstraints = false
        moreView.alpha = 0
        moreView.delegate = self
        addSubview(moreView)
    }
    
    private func setupInputBar() {
        addSubview(inputBar)
    }
    
    private func setupTableView() {
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ReceivedConversationMessageTVC.self, forCellReuseIdentifier: ReceivedConversationMessageTVC.CellID)
        tableView.register(SentConversationMessageTVC.self, forCellReuseIdentifier: SentConversationMessageTVC.CellID)
        tableView.register(ChatHeaderTVH.self, forHeaderFooterViewReuseIdentifier: ChatHeaderTVH.ViewID)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.contentInset.bottom = 24
        addSubview(tableView)
    }

    private func setupConstraints() {
        navBar.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalToSuperview()
        }

        tableView.snp.makeConstraints { make in
            make.top.equalTo(navBar.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        inputBar.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        moreView.snp.makeConstraints { make in
            make.top.equalTo(navBar.moreButton.snp.bottom).offset(12)
            make.trailing.equalToSuperview().inset(9)
        }
    }
    
    private func setupKeyboardManager() {
        keyboardManager.inputAccessoryView = inputBar
        keyboardManager.bind(to: tableView)
        keyboardManager.bind(inputAccessoryView: inputBar)
     
        chatKeyboardObserver = .init(textView: inputBar.textView, scrollView: tableView, textViewContainer: inputBar)
        chatKeyboardObserver.setupObserver()
    }
    
    func configView(with data: [MessageSections], for chat: RMChat) {
        self.dataSource = data
        self.chat = chat
        navBar.config(with: chat)
        self.tableView.reloadData()
        self.tableView.scrollToLastItem()
    }
}

extension SingleChatView: tableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        dataSource.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource[section].messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = dataSource[indexPath.section].messages[indexPath.row]
        let isMe = delegate?.isFromCurrentUser(at: indexPath) ?? false
        let position = delegate?.getPositionForMessage(at: indexPath) ?? .first
        var cell: UITableViewCell
        
        if !isMe {
            cell = tableView.dequeueReusableCell(withIdentifier: ReceivedConversationMessageTVC.CellID, for: indexPath) as! ReceivedConversationMessageTVC
        } else {
            cell = tableView.dequeueReusableCell(withIdentifier: SentConversationMessageTVC.CellID, for: indexPath) as! SentConversationMessageTVC
        }
        
        if let cell = cell as? ConversationMessageCell {
            cell.fill(cell: data, leadState: chat?.leadState ?? .cold, position: position)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: ChatHeaderTVH.ViewID) as! ChatHeaderTVH
        let dateChanges = (delegate?.isDateChanges(at: IndexPath(row: 0, section: section)) ?? false)
        let date = self.dataSource[section].date.dayChangeDateFormatter()
        view.fillView(with: date)
        
        if dateChanges {
            return view
        } else {
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let dateChanges = (delegate?.isDateChanges(at: IndexPath(row: 0, section: section)) ?? false)
        if dateChanges {
            return 74
        } else {
            return 8
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
}

// MARK: - gesture
private extension SingleChatView {
    @objc func tapGestureAction() {
        if moreView.alpha == 1 {
            moreView.fade(duration: 0.35, delay: 0, isIn: false)
            navBar.moreButton.isSelected = false
        }
    }
}
// MARK: - nav delegate
extension SingleChatView: ConversationNavigationBarViewDelegate {
    func backButtonDidTouched() {
        delegate?.backButtonDidTouched()
    }
    
    func moreButtonDidTouched() {
        moreView.fade(duration: 0.35, delay: 0, isIn: moreView.alpha == 0)
        navBar.moreButton.isSelected = moreView.alpha == 1
    }
    
    func aiButtonDidTouched() {
        delegate?.aiButtonDidTouched()
    }
}

// MARK: - more view delegate
extension SingleChatView: ChatMoreViewDelegate {
    func copyLinkDidTouched() {
        moreView.fade(duration: 0.35, delay: 0, isIn: false)
        navBar.moreButton.isSelected = false
        delegate?.copyLinkDidTouched()
    }
    
    func deleteChatDidTouched() {
        moreView.fade(duration: 0.35, delay: 0, isIn: false)
        navBar.moreButton.isSelected = false
        delegate?.deleteChatDidTouched()
    }
}
