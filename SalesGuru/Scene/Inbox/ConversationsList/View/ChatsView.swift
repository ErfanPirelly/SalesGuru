//
//  InboxView.swift
//  SalesGuru
//
//  Created by mmdMoovic on 4/28/24.
//

import UIKit

protocol ChatViewDelegate: ConversationFilterViewDelegate, EmptyConversationViewDelegate {
    func didSelectConversation()
}

class ChatsView: UIView {
    // MARK: - properties
    private let filterView = ConversationFilterView()
    private let tableView = UITableView()
    private let header = HeaderView()
    weak var delegate: ChatViewDelegate?
    private var chats: [RMChat] = []
    private let emptyView = EmptyConversationView()
    
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - setupUI
    private func setupUI() {
        setupHeaderView()
        setupEmptyView()
        setupTableView()
        setupFilterView()
        setupConstraints()
    }
    
    private func setupHeaderView() {
        header.translatesAutoresizingMaskIntoConstraints = false
        addSubview(header)
    }
    
    private func setupFilterView() {
        filterView.translatesAutoresizingMaskIntoConstraints = false
        filterView.delegate = self
        addSubview(filterView)
    }
    
    private func setupTableView() {
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ConversationTVC.self, forCellReuseIdentifier: ConversationTVC.CellID)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .white
        addSubview(tableView)
    }

    private func setupEmptyView() {
        emptyView.delegate = self
        emptyView.alpha = 0
        addSubview(emptyView)
    }
    
    private func setupConstraints() {
        header.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
        }
        
        filterView.snp.makeConstraints { make in
            make.top.equalTo(header.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview()
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(filterView.snp.bottom).offset(24)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        emptyView.snp.makeConstraints { make in
            make.center.equalTo(tableView)
            make.width.equalTo(262)
        }
    }
    
    func setData(data: [RMChat]) {
        emptyView.fade(duration: 0.2, delay: 0, isIn: data.isEmpty)
        tableView.fade(duration: 0.2, delay: 0, isIn: !data.isEmpty)
        self.chats = data
        self.tableView.reloadData()
    }
}

extension ChatsView: tableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        chats.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ConversationTVC.CellID, for: indexPath) as! ConversationTVC
        let chat = chats[indexPath.row]
        cell.fill(cell: chat)
        return cell
    }
 
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelectConversation()
    }
}

extension ChatsView: ConversationFilterViewDelegate {
    func didSelectFilter(with: IMConversationFilter) {
        delegate?.didSelectFilter(with: with)
    }
    
    func deSelectFilter(with: IMConversationFilter) {
        delegate?.deSelectFilter(with: with)
    }
    
    
}
