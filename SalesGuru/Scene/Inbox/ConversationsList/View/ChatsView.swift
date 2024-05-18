//
//  InboxView.swift
//  SalesGuru
//
//  Created by mmdMoovic on 4/28/24.
//

import UIKit

protocol ChatViewDelegate: ConversationFilterViewDelegate {
    func didSelectConversation()
}

class ChatsView: UIView {
    // MARK: - properties
    private let filterView = ConversationFilterView()
    private let tableView = UITableView()
    weak var delegate: ChatViewDelegate?
    
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
        setupTableView()
        setupFilterView()
        setupConstraints()
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

    private func setupConstraints() {
        
        filterView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(20)
            make.leading.trailing.equalToSuperview()
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(filterView.snp.bottom).offset(24)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}

extension ChatsView: tableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        MockData.conversations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ConversationTVC.CellID, for: indexPath) as! ConversationTVC
        cell.fill(cell: MockData.conversations[indexPath.row])
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
