//
//  TableBasedViewController.swift
//  Pirelly
//
//  Created by shndrs on 6/17/23.
//

import UIKit

class TableBasedViewController: BaseViewController {
    
    var largeTitle: Bool = false {
        willSet(newVal) {
            self.navigationController?.navigationBar.prefersLargeTitles = newVal
        }
    }
    var enableRefreshControl = false
    
    lazy var refreshControl: UIRefreshControl = {
        let temp = UIRefreshControl()
        temp.tintColor = .ui.primaryBlue
        temp.backgroundColor = .ui.primaryBack
        return temp
    }()
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableSetup()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @objc func tableSetup() {
        tableView.separatorStyle = .none
        tableView.backgroundColor = .ui.secondaryBack
        if #available(iOS 15.0, *) {
            self.tableView.sectionHeaderTopPadding = 0
        }
        if enableRefreshControl {
            refreshControl.addTarget(self,
                                     action: #selector(self.refresh(_:)),
                                     for: .valueChanged)
            tableView.addSubview(refreshControl)
        }
    }
    
    @objc func refresh(_ sender: AnyObject) {}
    
    func register(reuseIds: Array<String>) {
        for id in reuseIds {
            Register.in(component: tableView, id: id)
        }
    }

}
