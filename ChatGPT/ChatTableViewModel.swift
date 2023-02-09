//
//  ChatTableViewModel.swift
//  ChatGPT
//
//  Created by 陳逸煌 on 2023/2/9.
//

import Foundation
import UIKit

protocol ChatTablewMethod {
    func openAIRespond(text: String)
}

class ChatTableViewModel {
    
    var adapter: TableViewAdapter?
    
    init(tableView: UITableView) {
        self.adapter = .init(tableView)
    }
    
    
    
    func generateText(inputText: String, complete: ((_ respondText: String) -> ())?) {
        
        let param: parameter = [
            "model": "text-davinci-001",
            "prompt": inputText,
            "max_tokens": 256
        ]

        APIService.shared.requestWithParam(httpMethod: .post,
                                           headerField: APIService.shared.createTokenWithJsonHeader(),
                                           urlText: .ChatGPTURL,
                                           param: param,
                                           modelType: GPTRespondModel.self,
                                           completeAction: { jsonModel, error  in
            self.chatGPTRespond(title: jsonModel?.model ?? "", text: jsonModel?.text ?? "")
            
        })
        
    }
    
    func userSendMessage(text: String) {
        let rowModel = self.creatUserRowModel(text: text)
        self.adapter?.insertRowsAtLast(rowModels: [rowModel])
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
