//
//  SettingsView.swift
//  SalesGuru
//
//  Created by mmdMoovic on 4/29/24.
//

import UIKit

protocol SettingsViewDelegate: AnyObject {
    func didSelect(setting item: SettingItem)
}

class SettingsView: UIView {
    // MARK: - properties
    private let cardView = UIView()
    private let tableView = UITableView()
    private let title = UILabel(text: "Settings", font: .Fonts.bold(24), textColor: .ui.darkColor1, alignment: .center)
    private let dataSource = SettingItem.dataSource
    weak var delegate: SettingsViewDelegate?
    
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - setup ui
    private func setupUI() {
        backgroundColor = .white
        setupCardView()
        setupTableView()
        setupTitle()
        setupConstraints()
    }
    
    private func setupTableView() {
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(SettingsTVC.self, forCellReuseIdentifier: SettingsTVC.CellID)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .ui.backgroundColor4
        cardView.addSubview(tableView)
        tableView.isScrollEnabled = false
    }
    
    private func setupTitle() {
        cardView.addSubview(title)
    }
    
    private func setupCardView() {
        cardView.translatesAutoresizingMaskIntoConstraints = false
        cardView.applyCorners(to: .all, with: 25)
        cardView.backgroundColor = .ui.backgroundColor4
        addSubview(cardView)
    }
    
    private func setupConstraints() {
        cardView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(40)
            make.leading.trailing.equalToSuperview().inset(24)
        }
        
        title.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(16)
            make.centerX.equalToSuperview()
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(title.snp.bottom).offset(40)
            make.height.equalTo((75 * dataSource.count))
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}

extension SettingsView: tableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingsTVC.CellID, for: indexPath) as! SettingsTVC
        cell.fill(cell: dataSource[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelect(setting: dataSource[indexPath.row])
    }
}
