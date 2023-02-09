//
//  NoticeUserCell.swift
//  Job1111
//
//  Created by 陳逸煌 on 2022/12/13.
//  Copyright © 2022 JobBank. All rights reserved.
//

import Foundation
import UIKit

class NoticeUserCellRowModel: CellRowModel {
    override func cellReUseID() -> String {
        return "NoticeUserCell"
    }
    
    var content: String?
    
    var sendDate: String?
    
    var readed: Bool = false
    
    init(
        content: String?,
        sendDate: String?,
        readed: Bool
    ){
        self.content = content
        self.sendDate = sendDate
        self.readed = readed
    }
    
}

class NoticeUserCell: UITableViewCell {
    
    @IBOutlet weak var contentBackgroundView: UIView!
    
    @IBOutlet weak var contentTextView: UITextView!
    
    @IBOutlet weak var sendDateTimeLabel: UILabel!
    
    @IBOutlet weak var readedLabel: UILabel!
    
    override func awakeFromNib() {
        self.selectionStyle = .none
        
        self.backgroundColor = .white
        
        self.contentTextView.isScrollEnabled = false
        self.contentTextView.isEditable = false
        self.contentTextView.backgroundColor = .clear
        self.contentTextView.textColor = .white
        
        self.contentBackgroundView.backgroundColor = .lightGray
        self.contentBackgroundView.layer.cornerRadius = 10
        self.contentBackgroundView.clipsToBounds = true
        self.contentBackgroundView.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner,.layerMinXMaxYCorner]
        
        self.sendDateTimeLabel.font = .systemFont(ofSize: 10)
        self.sendDateTimeLabel.textColor = .black
        
        self.readedLabel.font = .systemFont(ofSize: 10)
        self.readedLabel.textColor = .black
        self.readedLabel.text = "已讀"
        
    }
    
}

extension NoticeUserCell: BaseCellView {
    func setupCellView(model: BaseCellModel) {
        guard let rowModel = model as? NoticeUserCellRowModel else { return }
        self.contentTextView.text = rowModel.content
        self.sendDateTimeLabel.text = rowModel.sendDate
        self.readedLabel.isHidden = !rowModel.readed
    }
}
