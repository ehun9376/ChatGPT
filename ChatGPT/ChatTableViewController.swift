//
//  ViewController.swift
//  ChatGPT
//
//  Created by 陳逸煌 on 2023/2/8.
//

import UIKit

class ChatTableViewController: BaseTableViewController {
    
    var mainInputView = MainInputView()
    
    var viewModel: ChatTableViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.resetTableView()
        
        self.setupMainInputView()
        self.addAllSubView()
        
        
        self.viewModel = .init(tableView: self.defaultTableView)
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(viewEndEdit)))
        
        self.regisCellID(cellIDs: [
            "NoticeIndustryCell",
            "NoticeUserCell"
        ])
        
    }
    
    
    func resetTableView() {
        if self.view.subviews.contains(self.defaultTableView) {
            self.defaultTableView.removeFromSuperview()
        }
        self.defaultTableView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.defaultTableView)
        self.defaultTableView.setContentHuggingPriority(.defaultHigh, for: .vertical)
        self.defaultTableView.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        
        NSLayoutConstraint.activate([
            self.defaultTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.defaultTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.defaultTableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor)
        ])
        
        
    }
    
    @objc func viewEndEdit() {
        self.view.endEditing(true)
    }

    
    func addAllSubView() {
        self.view.addSubview(self.mainInputView)
        NSLayoutConstraint.activate([
            self.mainInputView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.mainInputView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.mainInputView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.mainInputView.topAnchor.constraint(equalTo: self.defaultTableView.bottomAnchor)
        ])
        
    }
    
    func setupMainInputView(reset: Bool = false, textViewText: String = "", fileName: String? = nil) {
        
        let viewModel = MainInputViewModel(textViewText: textViewText,
                                           sendButtonAction: { [weak self]  button, textViewText in
            self?.viewModel?.userSendMessage(text: textViewText)
        })
        
        if reset {
            self.mainInputView.reset(viewModel: viewModel)
        } else {
            self.mainInputView = .init(viewModel: viewModel)
        }
        
    }


}




