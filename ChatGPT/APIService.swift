//
//  APIService.swift
//  ChatGPT
//
//  Created by 陳逸煌 on 2023/2/8.
//

import Foundation

typealias HTTPHeaderField = [String: String]

typealias parameter = [String: Any]

typealias CompleteAction<T: JsonModel> = ((_ jsonModel: T?,_ error: Error?)->())

enum HttpMethod: String {
    case post = "POST"
    case get = "GET"
}

enum HeaderField {
    
    case json
    
    var field: HTTPHeaderField {
        switch self {
        case .json:
            return [
                "Content-Type" : "application/json"
            ]
        }
    }
}


class APIService: NSObject {
    
    static let shared = APIService()
    
    enum URLText: String {
        case ChatGPTURL = "https://api.openai.com/v1/completions"
    }
    
    private var session: URLSession!

    var savedCompletionHandler: (() -> Void)?
        
    private override init() {
        super.init()
        
        session = URLSession(configuration: URLSessionConfiguration.background(withIdentifier: "api_queue"),
                             delegate: self,
                             delegateQueue: nil)
    }
    
    func createTokenWithJsonHeader() -> HTTPHeaderField {
        
        let apiKey = "sk/3f2sQR1S6Ne9v2UovhgiT3BlbkFJ8iF9gaPfDj46t2m4qPmd"
        
        let key = apiKey.replacingOccurrences(of: "/", with: "-")
        
        return [
            "Content-Type" : "application/json",
            "Authorization": "Bearer \(key)"
        ]
    }
    
    var completeAction: ((_ json: JBJson?, _ error: Error?)->())?
    
    func requestWithParam<T: JsonModel>(httpMethod: HttpMethod, headerField: HTTPHeaderField, urlText: URLText, param: parameter, modelType: T.Type ,  completeAction: @escaping CompleteAction<T>) {
        
        if let url = URL(string: urlText.rawValue) {
            var request = URLRequest(url: url)
            
            for header in headerField {
                request.setValue(header.value, forHTTPHeaderField: header.key)
            }
            
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: param, options: JSONSerialization.WritingOptions())
            } catch {
                completeAction(nil, error)
            }
            
            request.httpMethod = httpMethod.rawValue
            
            session.downloadTask(with: request).resume()
            
            self.completeAction = { json, error in
                if let json = json {
                    completeAction(modelType.init(json: json), error)
                }
            }
//            self.apiQueue.async {
//                let task = URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
//
//                    if let error = error {
//                        completeAction(nil, error)
//                    } else if let data = data {
//                        do {
//                            let json = try JBJson(data: data)
//                            print(json)
//                            completeAction(modelType.init(json: json), error)
//                        } catch {
//                            completeAction(nil, error)
//                        }
//                    }
//                }
//
//                task.resume()
//            }
        }
    }
    
}

extension APIService: URLSessionDelegate {
    func urlSessionDidFinishEvents(forBackgroundURLSession session: URLSession) {
        DispatchQueue.main.async {
            self.savedCompletionHandler?()
            self.savedCompletionHandler = nil
        }
    }
}

extension APIService: URLSessionTaskDelegate {
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        if let error = error {
            // handle failure here
            self.completeAction?(nil, error)
        }
    }
}

extension APIService: URLSessionDownloadDelegate {
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        do {
            let data = try Data(contentsOf: location)
            let json = try JBJson(data: data)
            print(json)
            self.completeAction?(json, nil)
        } catch {
            self.completeAction?(nil, error)
        }
    }
}

//class BackgroundSession: NSObject {
//    static let shared = BackgroundSession()
//
//    static let identifier = "com.domain.app.bg"
//
//    private var session: URLSession!
//
//    var savedCompletionHandler: (() -> Void)?
//
//    private override init() {
//        super.init()
//
//        let configuration = URLSessionConfiguration.background(withIdentifier: BackgroundSession.identifier)
//        session = URLSession(configuration: configuration, delegate: self, delegateQueue: nil)
//    }
//
//    func start(_ request: URLRequest) {
//        session.downloadTask(with: request).resume()
//    }
//}
//
//extension BackgroundSession: URLSessionDelegate {
//    func urlSessionDidFinishEvents(forBackgroundURLSession session: URLSession) {
//        DispatchQueue.main.async {
//            self.savedCompletionHandler?()
//            self.savedCompletionHandler = nil
//        }
//    }
//}
//
//extension BackgroundSession: URLSessionTaskDelegate {
//    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
//        if let error = error {
//            // handle failure here
//            print("\(error.localizedDescription)")
//        }
//    }
//}
//
//extension BackgroundSession: URLSessionDownloadDelegate {
//    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
//        do {
//            let data = try Data(contentsOf: location)
//            let json = try JSONSerialization.jsonObject(with: data)
//
//            print("\(json)")
//            // do something with json
//        } catch {
//            print("\(error.localizedDescription)")
//        }
//    }
//}
