//
//  AISettingView.swift
//  SalesGuru
//
//  Created by Erfan mac mini on 6/3/24.
//

import UIKit
protocol AISettingViewDelegate: AISettingCellDelegate {
    
}

class AISettingView: UIView {
    // MARK: - properties
    private let panView = PanView()
    private let title = UILabel(text: "AI Settings", font: .Quicksand.bold(27.3), textColor: .ui.darkColor, alignment: .left)
    private let tableView = UITableView()
    private var stack: UIStackView!
    private var dataSource: [IMAISetting] = []
    weak var delegate: AISettingViewDelegate?
    
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
        setupStack()
        setupTableView()
        setupConstraints()
    }
    
    
    private func setupTableView() {
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(AISettingCell.self, forCellReuseIdentifier: AISettingCell.CellID)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        addSubview(tableView)
    }
    
    private func setupStack() {
        stack = .init(axis: .vertical, spacing: 24, arrangedSubviews: [panView, title])
        addSubview(stack)
    }
    
    private func setupConstraints() {
        stack.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(16)
            make.centerX.equalToSuperview()
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(stack.snp.bottom).offset(32)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        snp.makeConstraints { make in
            make.height.equalTo(K.size.portrait.height * 0.7)
        }
    }
    
    func setData(data: [IMAISetting]) {
        self.dataSource = data
        self.tableView.reloadData()
    }
}

extension AISettingView: tableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AISettingCell.CellID, for: indexPath) as! AISettingCell
        cell.fill(cell: dataSource[indexPath.row])
        cell.delegate = delegate
        return cell
    }
}
