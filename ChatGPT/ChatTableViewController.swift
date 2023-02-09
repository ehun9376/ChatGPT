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
            
            let param: parameter = [
                "model": "text-davinci-001",
                "prompt" : textViewText
            ]
            
            APIService.shared.requestWithParam(httpMethod: .post, headerField: APIService.shared.createTokenWithJsonHeader(), urlText: .ChatGPTURL, param: param, modelType: GPTRespondModel.self) { jsonModel, error in
                print(jsonModel?.text ?? "")
            }
        })
        
        if reset {
            self.mainInputView.reset(viewModel: viewModel)
        } else {
            self.mainInputView = .init(viewModel: viewModel)
        }
        
    }


}




