//
//  MainInputView.swift
//  Job1111
//
//  Created by yihuang on 2022/12/17.
//  Copyright © 2022 JobBank. All rights reserved.
//

import Foundation
import UIKit

class MainInputViewModel {

    var lineHeight: CGFloat = UIFont.systemFont(ofSize: 16).lineHeight
    
    var textViewText: String?
    
    var sendButtonAction: ((UIButton, String)->())?
    
    init(lineHeight: CGFloat = UIFont.systemFont(ofSize: 16).lineHeight,
         textViewText: String?,
         moreButtonAction: ((UIButton) -> ())? = nil,
         sendButtonAction: ((UIButton, String) -> ())? = nil
    ) {
        self.textViewText = textViewText
        self.lineHeight = lineHeight
        self.textViewText = textViewText
        self.sendButtonAction = sendButtonAction
    }
}


class MainInputView: UIView {
                
    private var textView = InputLetterTextView()
    
    private var viewModel: MainInputViewModel?
    
    private var lineHeight: CGFloat = 0
    
    lazy private var safeHeight: CGFloat = DeviceType.iPhoneX ? 20.0 : 0
    
    lazy private var offset: CGFloat = 30.0 + self.safeHeight

    lazy private var maxSize: CGFloat = 200.0 + offset
    
    private var inputViewHeight: NSLayoutConstraint?
    
    private var sendButton = UIButton()
        
    private var placeholderLabel = UILabel()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    convenience init(
        viewModel: MainInputViewModel
    ){
        self.init(frame: .zero)
        self.viewModel = viewModel
        self.lineHeight = viewModel.lineHeight
        self.setupMainInputView()
    }
    
    func reset(viewModel: MainInputViewModel) {
        self.viewModel = viewModel
        self.textView.text = viewModel.textViewText
        self.placeholderLabel.isHidden = !self.textView.text.isEmpty
        self.updateSendButton()
        self.checkInputViewHeight()
    }
    
    
    private func checkInputViewHeight() {
                
        let textViewHeight: CGFloat = CGFloat(self.textView.numberOfLines()) * self.lineHeight
        
        if textViewHeight + offset >= maxSize {
            self.inputViewHeight?.constant = maxSize
        } else {
            self.inputViewHeight?.constant = textViewHeight + offset
        }

    }
    
    private func updateSendButton() {
        if !self.textView.text.isEmpty {
            self.sendButton.isEnabled = true
            self.sendButton.tintColor = .blue
        } else {
            self.sendButton.isEnabled = false
            self.sendButton.tintColor = .gray
        }
    
    }
    
    private func setupMainInputView() {
        
        self.backgroundColor = .white
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
        self.placeholderLabel.text = "請輸入您要傳送的訊息"
        self.placeholderLabel.sizeToFit()
        self.placeholderLabel.isHidden = false
        self.placeholderLabel.font = .systemFont(ofSize: 16)
        self.placeholderLabel.textColor = .black
        
        self.textView.delegate = self
        self.textView.layer.borderWidth = 1
        self.textView.layer.borderColor = UIColor.gray.cgColor
        self.textView.layer.cornerRadius = 5
        self.textView.translatesAutoresizingMaskIntoConstraints = false
        self.textView.isScrollEnabled = true
        self.textView.backgroundColor = UIColor(hex: "E5ECF0")
        self.textView.font = .systemFont(ofSize: 16)
        self.textView.textColor = .black
        self.textView.textDidChangeHandler = { text in
            self.checkInputViewHeight()
            self.updateSendButton()
            self.placeholderLabel.isHidden = !text.isEmpty
        }
        
        
        self.sendButton = UIButton(frame: .init(x: 0, y: 0, width: 25, height: self.lineHeight))
        if #available(iOS 15.0, *) {
            sendButton.configuration = nil
        }
        
        self.sendButton.translatesAutoresizingMaskIntoConstraints = false
        self.sendButton.addTarget(self, action: #selector(sendButtonAction(_:)), for: .touchUpInside)
        self.sendButton.isEnabled = false
        self.sendButton.tintColor = .darkGray
        self.sendButton.setImage(UIImage(named: "send")?.resizeImage(targetSize: .init(width: self.lineHeight,height: self.lineHeight)).withRenderingMode(.alwaysTemplate), for: .normal)
        
        self.addSubViews()
    }
    
    private func addSubViews() {
        
        self.textView.addSubview(self.placeholderLabel)

        self.addSubview(self.textView)
        self.addSubview(self.sendButton)
        
        self.inputViewHeight = self.heightAnchor.constraint(greaterThanOrEqualToConstant: self.lineHeight + self.offset)
        self.inputViewHeight?.isActive = true

        NSLayoutConstraint.activate([

            self.placeholderLabel.topAnchor.constraint(equalTo: self.textView.topAnchor, constant: 7),
            self.placeholderLabel.leadingAnchor.constraint(equalTo: self.textView.leadingAnchor, constant: 3),
            self.placeholderLabel.trailingAnchor.constraint(equalTo: self.textView.trailingAnchor),
            
            self.textView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            self.textView.trailingAnchor.constraint(equalTo: sendButton.leadingAnchor, constant: -10),
            self.textView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            self.textView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: DeviceType.iPhoneX ? -10 + -self.safeHeight : -10),
            self.textView.heightAnchor.constraint(greaterThanOrEqualToConstant: self.lineHeight+10),
            
            self.sendButton.heightAnchor.constraint(equalToConstant: self.lineHeight),
            self.sendButton.widthAnchor.constraint(equalToConstant: 30),
            self.sendButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            self.sendButton.bottomAnchor.constraint(equalTo: textView.bottomAnchor),
        ])
        
    }
    
    @objc func sendButtonAction(_ sender: UIButton) {
        self.viewModel?.sendButtonAction?(sender, self.textView.text)
    }
    
    
}

extension MainInputView: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        self.placeholderLabel.isHidden = true
    }
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        self.placeholderLabel.isHidden = !textView.text.isEmpty
        return true
    }
    
}
