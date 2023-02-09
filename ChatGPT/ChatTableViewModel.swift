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
            "prompt": inputText
        ]

        APIService.shared.requestWithParam(httpMethod: .post,
                                           headerField: APIService.shared.createTokenWithJsonHeader(),
                                           urlText: .ChatGPTURL,
                                           param: param,
                                           modelType: GPTRespondModel.self,
                                           completeAction: { jsonModel, error  in
            if let text = jsonModel?.text {
                complete?(text)
            }
        })
        
    }
}
