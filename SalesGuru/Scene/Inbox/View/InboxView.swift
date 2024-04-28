//
//  InboxView.swift
//  SalesGuru
//
//  Created by mmdMoovic on 4/28/24.
//

import UIKit

class InboxView: UIView {
    // MARK: - properties
    private let tableView = UITableView()
    
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
        setupConstraints()
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
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension InboxView: tableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        MockData.conversations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ConversationTVC.CellID, for: indexPath) as! ConversationTVC
        cell.fill(cell: MockData.conversations[indexPath.row])
        return cell
    }
    
}
