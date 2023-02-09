//
//  InputTextView.swift
//  Job1111
//
//  Created by 陳逸煌 on 2022/12/15.
//  Copyright © 2022 JobBank. All rights reserved.
//

import Foundation
import UIKit

class InputLetterTextView: UITextView {
    
    convenience init() {
           self.init(frame: CGRect.zero, textContainer: nil)
           NotificationCenter.default.addObserver(self, selector: #selector(textDidChangeNotification), name: UITextView.textDidChangeNotification , object: nil)
       }

       deinit {
           NotificationCenter.default.removeObserver(self)
       }

       @objc func textDidChangeNotification(_ notif: Notification) {
           guard self == notif.object as? UITextView else {
               return
           }
           textDidChangeHandler?(self.text)
       }

       var textDidChangeHandler: ((String)->())?

}

extension InputLetterTextView {

    func numberOfLines() -> Int{
        if let fontUnwrapped = self.font{
            return Int(self.contentSize.height / fontUnwrapped.lineHeight)
        }
        return 0
    }

}
