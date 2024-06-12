//
//  InboxView.swift
//  SalesGuru
//
//  Created by mmdMoovic on 4/28/24.
//

import UIKit

protocol ChatViewDelegate: ConversationFilterViewDelegate,
                           EmptyConversationViewDelegate,
                           HeaderViewDelegate {
    func didSelect(chat with: RMChat)
    func refreshData()
}

class ChatsView: UIView {
    // MARK: - table view
    private typealias Snapshot = NSDiffableDataSourceSnapshot<Section, RMChat>
    private typealias DataSource = UITableViewDiffableDataSource<Section, RMChat>
    private enum Section {
         case main
     }
    
    // MARK: - properties
    private let refreshController = UIRefreshControl()
    private let filterView = ConversationFilterView()
    private let tableView = UITableView()
    private let header = HeaderView()
    weak var delegate: ChatViewDelegate? {
        didSet {
            header.delegate = delegate
            filterView.delegate = delegate
            emptyView.delegate = delegate
        }
    }
    private var chats: [RMChat] = []
    private let emptyView = EmptyConversationView()
    private var dataSource: DataSource!
    private let plusButton = UIButton(title: "+", titleColor: .white, font: .Fonts.medium(30))
    
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
        setupRefreshControl()
        setupFilterView()
        setupAddButton()
        setupConstraints()
    }
    
    private func setupHeaderView() {
        header.translatesAutoresizingMaskIntoConstraints = false
        addSubview(header)
    }
    
    private func setupFilterView() {
        filterView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(filterView)
    }
    
    private func setupTableView() {
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ConversationTVC.self, forCellReuseIdentifier: ConversationTVC.CellID)
        tableView.delegate = self
        configureDataSource()
        tableView.backgroundColor = .white
        addSubview(tableView)
    }

    private func setupRefreshControl() {
        refreshController.beginRefreshing()
        refreshController.tintColor = .ui.primaryBlue
        refreshController.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        tableView.addSubview(refreshController)
    }
    
    private func setupEmptyView() {
        emptyView.alpha = 0
        addSubview(emptyView)
    }
    
    private func setupAddButton() {
        plusButton.applyCorners(to: .all, with: 29)
        plusButton.backgroundColor = .ui.primaryBlue
        plusButton.addTarget(self, action: #selector(plusButtonDidTouched), for: .touchUpInside)
        addSubview(plusButton)
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
        
        plusButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(24)
            make.size.equalTo(58)
            make.bottom.equalToSuperview().inset(32)
        }
    }
    
    func setData(data: [RMChat]) {
        emptyView.fade(duration: 0.2, delay: 0, isIn: data.isEmpty)
        tableView.fade(duration: 0.2, delay: 0, isIn: !data.isEmpty)
        self.chats = data
        refreshController.endRefreshing()
        header.stopIndicator()
        applyInitialSnapshot(items: data)
    }
    
   private func configureDataSource() {
        dataSource = UITableViewDiffableDataSource<Section, RMChat>(tableView: tableView) { (tableView, indexPath, item) -> UITableViewCell? in
            let cell = tableView.dequeueReusableCell(withIdentifier: ConversationTVC.CellID, for: indexPath) as! ConversationTVC
            cell.fill(cell: item)
            return cell
        }
    }
    
    private func applyInitialSnapshot(items: [RMChat]) {
        var snapshot = Snapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(items, toSection: .main)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    @objc private func refreshData() {
        self.delegate?.refreshData()
    }
    
    @objc private func plusButtonDidTouched() {
        self.delegate?.addLeadDidTouched()
    }
}

extension ChatsView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let chat = dataSource.itemIdentifier(for: indexPath) else { return }
        delegate?.didSelect(chat: chat)
    }
}
