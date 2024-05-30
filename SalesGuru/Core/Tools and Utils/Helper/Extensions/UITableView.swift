//
//  UITableView.swift
//  Pirelly
//
//  Created by shndrs on 6/18/23.
//

import UIKit

protocol ListView {
    func asyncReload()
    func deleteItem(at: IndexPath)
    func cellFor(item at: IndexPath) -> UIView?
    func reload(item at: IndexPath)
}

extension UITableView: ListView {
    func reload(item at: IndexPath) {
        reloadRows(at: [at], with: .automatic)
    }
    
    func deleteItem(at: IndexPath) {
        deleteRows(at: [at], with: .left)
    }
    
    func cellFor(item at: IndexPath) -> UIView? {
        return cellForRow(at: at)
    }
    
    public func asyncReload() {
        DispatchQueue.main.async { [weak self] in
            guard self != nil else { return }
            self?.reloadData()
        }
    }
    
    public func cleanFooterView() {
        DispatchQueue.main.async { [weak self] in
            guard self != nil else { return }
            self?.tableFooterView?.backgroundColor = .clear
            self?.tableFooterView = UIView(frame: CGRect(x: 0,
                                                         y: 0,
                                                         width: self?.frame.size.width ?? 0,
                                                         height: 1))
        }
    }
    
    public func asyncReload(in section: Int, rowAnimation: UITableView.RowAnimation = .fade) {
        DispatchQueue.main.async { [weak self] in
            guard self != nil else { return }
            self?.beginUpdates()
            self?.reloadSections(IndexSet(integer: section), with: rowAnimation)
            self?.endUpdates()
        }
    }
    
    public func regularReload(in section: Int) {
        self.beginUpdates()
        self.reloadSections(IndexSet(integer: section), with: .fade)
        self.endUpdates()
    }
    
}

extension UITableView {
    var indexPathForLastItem: IndexPath? {
      guard numberOfSections > 0 else { return nil }
      for offset in 1 ... numberOfSections {
        let section = numberOfSections - offset
        let lastItem = numberOfRows(inSection: section) - 1
        if lastItem >= 0 {
          return IndexPath(item: lastItem, section: section)
        }
      }
      return nil
    }
    
    public func scrollToLastItem(at pos: UITableView.ScrollPosition = .bottom, animated: Bool = true) {
      guard let indexPath = indexPathForLastItem else { return }
        scrollToRow(at: indexPath, at: pos, animated: animated)
    }
}

