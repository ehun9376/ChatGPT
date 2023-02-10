//
//  ChatTableViewModel.swift
//  ChatGPT
//
//  Created by 陳逸煌 on 2023/2/9.
//

import Foundation
import UIKit

protocol ChatTableViewMethod {
    func openAIRespond(text: String)
    func scroll(offset: CGFloat)
}

class ChatTableViewModel: NSObject {
    
    var adapter: TableViewAdapter?
    
    var delegate: ChatTableViewMethod?
    
    init(tableView: UITableView, delegate: ChatTableViewMethod) {
        super.init()
        self.adapter = .init(tableView)
        self.delegate = delegate
        self.adapter?.scrollViewDidScroll = { [weak self] offset in
            self?.delegate?.scroll(offset: offset)
        }
    }
    
    func generateText(inputText: String, complete: ((_ respondText: String) -> ())?) {
        
        let param: parameter = [
            "model": "text-davinci-003",
            "prompt": inputText,
            "max_tokens": 1000
        ]

        APIService.shared.requestWithParam(httpMethod: .post,
                                           headerField: APIService.shared.createTokenWithJsonHeader(),
                                           urlText: .ChatGPTURL,
                                           param: param,
                                           modelType: GPTRespondModel.self,
                                           completeAction: { jsonModel, error  in
            self.chatGPTRespond(title: jsonModel?.model ?? "", text: jsonModel?.text ?? "")
            self.delegate?.openAIRespond(text: jsonModel?.text ?? "")
            self.sendLocalNotication(title: "GPT回應囉", body: jsonModel?.text ?? "")
        })
        
    }
    
    func userSendMessage(text: String) {
        let rowModel = self.creatUserRowModel(text: text)
        self.adapter?.insertRowsAtLast(rowModels: [rowModel], scrollToRow: true)
        self.generateText(inputText: text, complete: nil)
    }
    
    func chatGPTRespond(title: String,text: String) {
        let rowModel = self.creatRespondRowModel(title: title, text: text)
        self.adapter?.insertRowsAtLast(rowModels: [rowModel])
    }
    
    func creatUserRowModel(text: String) -> NoticeUserCellRowModel {
        let rowModel = NoticeUserCellRowModel(content: text, sendDate: nil, readed: true)
        return rowModel
    }
    
    func creatRespondRowModel(title: String, text: String) -> NoticeIndustryCellRowModel {
        let rowModel = NoticeIndustryCellRowModel(title: title, content: text, sendDate: nil, wishReplyDate: nil)
        return rowModel
    }
}
