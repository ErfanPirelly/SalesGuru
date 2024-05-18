//
//  SingleChatView.swift
//  SalesGuru
//
//  Created by Erfan mac mini on 5/18/24.
//

import UIKit

protocol SingleChatViewDelegate: ConversationFilterViewDelegate {}

class SingleChatView: UIView {
    // MARK: - properties
    private let tableView = UITableView()
    private let dataSource = MockData.conversationMessages
    private let filterView = ConversationFilterView()
    weak var delegate: SingleChatView?
    
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
        backgroundColor = .white
        setupFilterView()
        setupTableView()
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
        tableView.register(RecivedConversationMessageTVC.self, forCellReuseIdentifier: RecivedConversationMessageTVC.CellID)
        tableView.register(SentConversationMessageTVC.self, forCellReuseIdentifier: SentConversationMessageTVC.CellID)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.contentInset.bottom = 24
        addSubview(tableView)
    }

    private func setupConstraints() {
        filterView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalToSuperview().inset(20)
        }

        tableView.snp.makeConstraints { make in
            make.top.equalTo(filterView.snp.bottom).offset(32)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}

extension SingleChatView: tableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = dataSource[indexPath.row]
        var position: MessagePosition = .first
        let previousData = dataSource[safe: indexPath.row - 1]
        let nextData = dataSource[safe: indexPath.row + 1]
        
        if !data.isMe {
            if let previousData = previousData {
                position = !previousData.isMe ? .middle : .first
            } else {
                position = .first
            }
            
            if let nextData = nextData {
                position = !nextData.isMe ? position : .last
            } else {
                position = .last
            }
            let cell = tableView.dequeueReusableCell(withIdentifier: RecivedConversationMessageTVC.CellID, for: indexPath) as! RecivedConversationMessageTVC
            cell.fill(cell: data, position: position)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: SentConversationMessageTVC.CellID, for: indexPath) as! SentConversationMessageTVC
            
            if let previousData = previousData {
                position = previousData.isMe ? .middle : .first
            } else {
                position = .first
            }
            
            if let nextData = nextData {
                position = nextData.isMe ? position : .last
            } else {
                position = .last
            }
            
            cell.fill(cell: data, position: position)
            return cell
        }
    }
}

// MARK: - user view delegate
extension SingleChatView: ConversationFilterViewDelegate {
    func didSelectFilter(with: IMConversationFilter) {
        delegate?.didSelectFilter(with: with)
    }
    
    func deSelectFilter(with: IMConversationFilter) {
        delegate?.deSelectFilter(with: with)
    }
    
 
}
