//
//  NoticeIndustryCell.swift
//  Job1111
//
//  Created by 陳逸煌 on 2022/12/13.
//  Copyright © 2022 JobBank. All rights reserved.
//

import Foundation
import UIKit

class NoticeIndustryCellRowModel: CellRowModel {
    
    override func cellReUseID() -> String {
        return "NoticeIndustryCell"
    }
    
    var title: String?
    
    var content: String?
    
    var sendDate: String?
    
    var wishReplyDate: String?
        
    init(
        title: String?,
        content: String?,
        sendDate: String?,
        wishReplyDate: String?
    ){
        self.title = title
        self.content = content
        self.sendDate = sendDate
        self.wishReplyDate = wishReplyDate
    }
    
    
}

class NoticeIndustryCell: UITableViewCell {
    
    @IBOutlet weak var titleLineView: UIView!
    
    @IBOutlet weak var contentBackgroundView: UIView!
    
    @IBOutlet weak var letterTypeLabel: UILabel!
    
    @IBOutlet weak var contentTextView: UITextView!
    
    @IBOutlet weak var selectDateCollectionView: UICollectionView!
    
    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!
    
    
    @IBOutlet weak var sendTimeDateLabel: UILabel!
    
    @IBOutlet weak var wishReplayDateLabel: UILabel!
    
    
    var rowModel: NoticeIndustryCellRowModel?
    
    
    override func awakeFromNib() {

        self.selectionStyle = .none
        self.backgroundColor = .white
        self.contentBackgroundView.layer.cornerRadius = 10
        self.contentBackgroundView.clipsToBounds = true
        self.contentBackgroundView.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner,.layerMaxXMaxYCorner]
        self.contentBackgroundView.layer.borderWidth = 1
        self.contentBackgroundView.layer.borderColor = UIColor.black.cgColor
        
        self.titleLineView.backgroundColor = .gray
        
        self.contentTextView.isEditable = false
        self.contentTextView.isScrollEnabled = false
        self.contentTextView.backgroundColor = .clear
        self.contentTextView.textColor = .black
        self.contentTextView.font = .systemFont(ofSize: 14)
        
        
        self.sendTimeDateLabel.font = .systemFont(ofSize: 10)
        self.sendTimeDateLabel.textColor = .black
        
        self.letterTypeLabel.textColor = .blue
        self.letterTypeLabel.font = .systemFont(ofSize: 16)
        
        self.wishReplayDateLabel.textColor = .black
        self.wishReplayDateLabel.font = .systemFont(ofSize: 12)
        self.wishReplayDateLabel.numberOfLines = 0
        self.wishReplayDateLabel.lineBreakMode = .byCharWrapping
        
    }
    
}

extension NoticeIndustryCell: BaseCellView {
    func setupCellView(model: BaseCellModel) {
        guard let rowModel = model as? NoticeIndustryCellRowModel else { return }
        self.rowModel = rowModel
        
        self.letterTypeLabel.text = rowModel.title
        
        self.contentTextView.text = rowModel.content
        
        self.sendTimeDateLabel.text = rowModel.sendDate
        
        self.wishReplayDateLabel.text = rowModel.wishReplyDate
        self.wishReplayDateLabel.isHidden = rowModel.wishReplyDate?.isEmpty ?? true
    }
}
