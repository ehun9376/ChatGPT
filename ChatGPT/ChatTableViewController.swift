//
//  ViewController.swift
//  ChatGPT
//
//  Created by 陳逸煌 on 2023/2/8.
//

import UIKit

class ChatTableViewController: BaseTableViewController {
    
    var mainInputView = MainInputView()
    
    var remindView = RemindView()
    
    var viewModel: ChatTableViewModel?
    
    var showRemindView: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.resetTableView()
        self.setupRemindView()
        self.setupMainInputView()
        self.addAllSubView()
        KeyboardHelper.shared.delegate = self
        
        self.viewModel = .init(tableView: self.defaultTableView, delegate: self)
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(viewEndEdit)))
        self.defaultTableView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(viewEndEdit)))
        
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
        self.defaultTableView.separatorStyle = .none
        
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
        
        self.view.addSubview(self.remindView)
        
        NSLayoutConstraint.activate([
            self.mainInputView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.mainInputView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.mainInputView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.mainInputView.topAnchor.constraint(equalTo: self.defaultTableView.bottomAnchor),
            
            self.remindView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.remindView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.remindView.bottomAnchor.constraint(equalTo: self.mainInputView.topAnchor)
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
    
    func setupRemindView(reset: Bool = false, text: String = "") {
        let viewModel = RemindViewModel(text: text,
                                       show: self.showRemindView,
                                       viewAction: { [weak self] in
            self?.defaultTableView.scrollToBottom()
            self?.showRemindView = false
            self?.setupRemindView(reset: true, text: "")
        })
        
        
        if reset {
            self.remindView.setupView(viewModel)
        } else {
            self.remindView = .init(viewModel: viewModel)
        }
        
    }


}

extension ChatTableViewController: ChatTableViewMethod {
    func openAIRespond(text: String) {
        self.setupRemindView(reset: true, text: text)
        if !self.showRemindView {
            self.defaultTableView.scrollToBottom()
        }
    }
    
    func scroll(offset: CGFloat) {
        
        print("self.defaultTableView.contentSize.height \(self.defaultTableView.contentSize.height)")
        print("self.defaultTableView.frame.height \(self.defaultTableView.frame.height)")
        print(offset)
        
        self.showRemindView = !(self.defaultTableView.contentSize.height - self.defaultTableView.frame.height <= offset) && self.defaultTableView.contentSize.height > self.defaultTableView.frame.height
        print(self.showRemindView)
        
    }
}

extension ChatTableViewController: KeyboardHelperDelegate {
    func didViewChanged(frame: CGRect, duration: Double, isHiddenKeyboard: Bool) {
        if !isHiddenKeyboard {
            
        }
    }
    
    
}
