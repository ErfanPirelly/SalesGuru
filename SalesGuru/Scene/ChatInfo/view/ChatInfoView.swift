//
//  ChatInfoView.swift
//  SalesGuru
//
//  Created by Erfan mac mini on 6/13/24.
//

import UIKit

protocol ChatInfoViewDelegate: ChatInfoHeaderViewDelegate {
    func didSelectCarInfo()
    func didSelectChatLead()
}

final class ChatInfoView: UIView {
    // MARK: - properties
    private let header = ChatInfoHeaderView()
    private let tableView = UITableView()
    private var dataSource: [UIModelChatSection] = []
    weak var delegate: ChatInfoViewDelegate? {
        didSet {
            header.delegate = delegate
        }
    }
    
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
        backgroundColor = .ui.backgroundColor2
        setupHeaderView()
        setupTableView()
        setupConstraints()
    }
    
    private func setupHeaderView() {
        header.translatesAutoresizingMaskIntoConstraints = false
        addSubview(header)
    }
    
    private func setupTableView() {
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ChatLeadTVC.self, forCellReuseIdentifier: ChatLeadTVC.CellID)
        tableView.register(ChatEmptyTVC.self, forCellReuseIdentifier: ChatEmptyTVC.CellID)
        tableView.register(ChatSingleRightIconTVC.self, forCellReuseIdentifier: ChatSingleRightIconTVC.CellID)
        tableView.register(ChatTextButtonTVC.self, forCellReuseIdentifier: ChatTextButtonTVC.CellID)
        tableView.register(ChatTextRightIconTVC.self, forCellReuseIdentifier: ChatTextRightIconTVC.CellID)
        tableView.register(ChatSingleButtonTVC.self, forCellReuseIdentifier: ChatSingleButtonTVC.CellID)
        tableView.register(ChatSolidTVC.self, forCellReuseIdentifier: ChatSolidTVC.CellID)
        tableView.register(ChatInfoTVH.self, forHeaderFooterViewReuseIdentifier: ChatInfoTVH.ViewID)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .white
        tableView.contentInset.bottom = UIView.safeArea.bottom + 12
        tableView.backgroundView?.applyCorners(to: .all, with: 16)
        addSubview(tableView)
    }
    
    private func setupConstraints() {
        header.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(header.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    func config(view with: [UIModelChatSection], headerInfo: UIMChatInfo, loading: Bool) {
        self.header.config(view: headerInfo)
        self.dataSource = with
        self.tableView.reloadData()
        header.loading(is: loading)
    }
}

extension ChatInfoView: tableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        dataSource.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSource[section].rows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell
        let model = dataSource[indexPath.section].rows[indexPath.row]
        switch model.type {
        case .lead:
            cell = tableView.dequeueReusableCell(withIdentifier: ChatLeadTVC.CellID, for: indexPath)
        case .singleRightIcon:
            cell = tableView.dequeueReusableCell(withIdentifier: ChatSingleRightIconTVC.CellID, for: indexPath)
        case .solid:
            cell = tableView.dequeueReusableCell(withIdentifier: ChatSolidTVC.CellID, for: indexPath)
        case .singleButton:
            cell = tableView.dequeueReusableCell(withIdentifier: ChatSingleButtonTVC.CellID, for: indexPath)
        case .textButton:
            cell = tableView.dequeueReusableCell(withIdentifier: ChatTextButtonTVC.CellID, for: indexPath)
        case .textRightIcon:
            cell = tableView.dequeueReusableCell(withIdentifier: ChatTextRightIconTVC.CellID, for: indexPath)
        case .empty:
            cell = tableView.dequeueReusableCell(withIdentifier: ChatEmptyTVC.CellID, for: indexPath)
        }
        
        if let cell = cell as? BaseProfileInfoCell {
            cell.fill(cell: model)
        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: ChatInfoTVH.ViewID) as! ChatInfoTVH
        let title = dataSource[section].title.uppercased()
        view.title.text = title
        return view
    }
 
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 24
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = dataSource[indexPath.section].rows[indexPath.row]
        
        if model.type == .lead {
            delegate?.didSelectChatLead()
        } else if model.title.lowercased() == "car information" {
            delegate?.didSelectCarInfo()
        }
    }
}
