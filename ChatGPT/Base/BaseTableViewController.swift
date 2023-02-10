//
//  ViewController.swift
//  Pet
//
//  Created by Kai on 2022/7/10.
//

import UIKit

extension UITableView {
    
    func hasRowAtIndexPath(indexPath: IndexPath) -> Bool {
        return indexPath.section < self.numberOfSections && indexPath.row < self.numberOfRows(inSection: indexPath.section)
    }
    
    func scrollToBottom(){
        
        DispatchQueue.main.async {
            let indexPath = IndexPath(
                row: self.numberOfRows(inSection:  self.numberOfSections-1) - 1,
                section: self.numberOfSections - 1)
            
            if indexPath.row >= 0 && self.hasRowAtIndexPath(indexPath: indexPath) {
                self.scrollToRow(at: indexPath, at: .bottom, animated: true)
            }
            
        }
    }
}

open class BaseTableViewController: BaseViewController {
    
    public let defaultTableView = UITableView()
                
    override open func viewDidLoad() {
        super.viewDidLoad()
        self.setupDefaultTableView()
    }
    
    private func setupDefaultTableView() {
        self.defaultTableView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.defaultTableView)
        self.defaultTableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        self.defaultTableView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.defaultTableView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        self.defaultTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor,constant: bottomBarHeight).isActive = true
    }
    
    
    ///可丟[String] 或是 [UITableViewCell.Type]
    open func regisCellID<cellType>(cellIDs: cellType) {
        
        if let ids = cellIDs as? [String] {
            for id in ids {
                self.defaultTableView.register(UINib(nibName: id,
                                                     bundle: nil),
                                               forCellReuseIdentifier: id)
            }
        }
        
        if let cells = cellIDs as? [UITableViewCell.Type] {
            for cell in cells {
                self.defaultTableView.register(cell, forCellReuseIdentifier: cell.description())
            }
        }
    }
    
    ///可丟[String] 或是 [UITableViewCell.Type]
    open func regisHeaderFooterView<viewType>(viewIDs: viewType) {
        if let ids = viewIDs as? [String] {
            for id in ids {
                self.defaultTableView.register(UINib(nibName: id, bundle: nil), forHeaderFooterViewReuseIdentifier: id)
            }
        }
        
        if let views = viewIDs as? [UIView.Type] {
            for view in views {
                self.defaultTableView.register(view, forHeaderFooterViewReuseIdentifier: view.description())
            }
        }
    }

}

