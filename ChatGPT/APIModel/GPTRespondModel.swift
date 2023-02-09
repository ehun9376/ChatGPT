//
//  GPTRespondModel.swift
//  ChatGPT
//
//  Created by 陳逸煌 on 2023/2/9.
//

import Foundation

class GPTRespondModel: JsonModel {
    var prompt_tokens: Int?
    var completion_tokens: Int?
    var total_tokens: Int?
    var id: String?
    var object: String?
    var created: Int?
    var model: String?
    var logprobs: Int?
    var text: String?
    var finish_reason: String?
    var index: Int?
    required init(json: JBJson) {
        self.prompt_tokens = json["prompt_tokens"].intValue
        self.completion_tokens = json["completion_tokens"].intValue
        self.total_tokens = json["prompt_tokens"].intValue
        self.id = json["id"].stringValue
        self.object = json["object"].stringValue
        self.created = json["created"].intValue
        self.model = json["model"].stringValue
        
        self.logprobs = (json["choices"].arrayValue.first ?? .null)["logprobs"].intValue
        self.text = (json["choices"].arrayValue.first ?? .null)["text"].stringValue
        self.finish_reason = (json["choices"].arrayValue.first ?? .null)["finish_reason"].stringValue
        self.index = (json["choices"].arrayValue.first ?? .null)["index"].intValue
        
    }
//    {
//      "model" : "text-davinci-003",
//      "created" : 1675847205,
//      "usage" : {
//        "completion_tokens" : 15,
//        "prompt_tokens" : 6,
//        "total_tokens" : 21
//      },
//      "id" : "cmpl-6hahZ2MWXh14OgeeXQuD0y2bZgrEw",
//      "choices" : [
//        {
//          "index" : 0,
//          "text" : "用\n#### 小型PHP測",
//          "finish_reason" : "length",
//          "logprobs" : null
//        }
//      ],
//      "object" : "text_completion"
//    }
}
