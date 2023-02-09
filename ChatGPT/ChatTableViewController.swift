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
        self.setupMainInputView()
        self.addAllSubView()
        
        self.viewModel = .init(tableView: self.defaultTableView)
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(viewEndEdit)))
        
    }
    
    @objc func viewEndEdit() {
        self.view.endEditing(true)
    }

    
    func addAllSubView() {
        self.view.addSubview(self.mainInputView)
        NSLayoutConstraint.activate([
            self.mainInputView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.mainInputView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.mainInputView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        
    }
    
    func setupMainInputView(reset: Bool = false, textViewText: String = "", fileName: String? = nil) {
        
        let viewModel = MainInputViewModel(textViewText: textViewText,
                                           sendButtonAction: { [weak self]  button, textViewText in
            self?.viewModel?.generateText(inputText: textViewText, complete: { respondText in
                print(respondText)
            })
        })
        
        if reset {
            self.mainInputView.reset(viewModel: viewModel)
        } else {
            self.mainInputView = .init(viewModel: viewModel)
        }
        
    }


}




