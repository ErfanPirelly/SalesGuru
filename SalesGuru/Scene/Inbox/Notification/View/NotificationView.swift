//
//  NotificationView.swift
//  SalesGuru
//
//  Created by Erfan mac mini on 6/1/24.
//

import UIKit

protocol NotificationViewDelegate: AnyObject {
    
}

class NotificationView: UIView {
    // MARK: - properties
    private let panView = PanView()
    private let title = UILabel(text: "Notification", font: .Quicksand.bold(27.3), textColor: .ui.darkColor, alignment: .left)
    private let readButton = UIButton(title: "Mark as read",
                                      titleColor: .ui.darkColor,
                                      font: .Quicksand.bold(13))
    private let tableView = UITableView()
    private var dataSource: [RMNotification] = []
    private var stack: UIStackView!
    weak var delegate: NotificationViewDelegate?
    
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - setup UI
    private func setupUI() {
        backgroundColor = .white
        applyCorners(to: .top, with: 45)
        addSubview(panView)
        setupStack()
        setupTableView()
        setupConstraints()
    }
    
    private func setupStack() {
        stack = .init(spacing: 8, arrangedSubviews: [title, readButton])
        addSubview(stack)
    }
    
    private func setupTableView() {
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(NotificationCell.self, forCellReuseIdentifier: NotificationCell.CellID)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        addSubview(tableView)
    }
    
    private func setupConstraints() {
        panView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(16)
            make.centerX.equalToSuperview()
        }
        
        stack.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(24)
            make.top.equalTo(panView.snp.bottom).offset(36)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(stack.snp.bottom).offset(32)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        snp.makeConstraints { make in
            make.height.equalTo(K.size.portrait.height * 0.86)
        }
    }
    
    func configView(with data: [RMNotification]) {
        self.dataSource = data
        self.tableView.reloadData()
    }
}

// MARK: - table view delegate
extension NotificationView: tableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NotificationCell.CellID) as! NotificationCell
        cell.fill(cell: dataSource[indexPath.row])
        return cell
    }
}
