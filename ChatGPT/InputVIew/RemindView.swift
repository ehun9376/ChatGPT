//
//  RemindView.swift
//  ChatGPT
//
//  Created by 陳逸煌 on 2023/2/10.
//

import Foundation
import UIKit

class RemindViewModel {
    
    var text: String?
    
    var show: Bool = false
    
    var viewAction: (()->())?
    
    init(text: String? = nil,
         show: Bool,
         viewAction: (()->())? = nil
    ) {
        self.text = text
        self.show = show
        self.viewAction = viewAction
    }
}

class RemindView: UIView {
    
    var viewModel: RemindViewModel?
    
    let textLabel: UILabel = .init(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    convenience init(
        viewModel: RemindViewModel
    ) {
        self.init()
        self.viewModel = viewModel
        self.defaultSet()
        self.setupView(self.viewModel)
        self.addAllSubView()
    }
    
    func setupView(_ viewModel: RemindViewModel?) {
        guard let viewModel = viewModel else { return }
        DispatchQueue.main.async {

            self.isHidden = !viewModel.show
            
            
            self.textLabel.text = viewModel.text

        }

    }
    
    func defaultSet() {
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(viewTapAction)))

        self.textLabel.translatesAutoresizingMaskIntoConstraints = false
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.5)
        
        self.textLabel.numberOfLines = 1
        self.textLabel.lineBreakMode = .byTruncatingTail
        self.textLabel.textColor = .black
    }
    
    @objc func viewTapAction() {
        self.viewModel?.viewAction?()
    }
    
    private func addAllSubView() {
        self.addSubview(self.textLabel)
        
        NSLayoutConstraint.activate([
            self.textLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            self.textLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
            self.textLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            self.textLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 5)
        ])
        
    }
    
}
