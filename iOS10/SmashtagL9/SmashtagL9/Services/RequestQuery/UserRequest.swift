//
//  Request.swift
//  SmashtagL9
//
//  Created by Shantanu Dutta on 31/05/18.
//  Copyright © 2018 Shantanu Dutta. All rights reserved.
//

import Foundation

class UserRequest {
    private let count: Int
    private let operationQueue = OperationQueue()
    private var urlRequest: URLRequest?
    init(count: Int = 5) {
        self.count = count
        formRequest()
    }
    
    fileprivate func formRequest(){
        var urlComponents = URLComponents()
        urlComponents.scheme = RequestParamValues.scheme.get()
        urlComponents.host = RequestParamValues.host.get()
        urlComponents.path = RequestParamValues.path.get()
        
        var items = [URLQueryItem]()
        items.append(URLQueryItem(name: RequestParamKeys.results.get(), value: RequestParamValues.results(count).get()))
        items.append(URLQueryItem(name: RequestParamKeys.exclude.get(), value: RequestParamValues.exclude.get()))
        
        items = items.filter{!$0.name.isEmpty}
        
        if !items.isEmpty {
            urlComponents.queryItems = items
        }
        
        guard let partialURL = urlComponents.url else {
            return
        }
        
        var absoluteURL = partialURL.absoluteString
        absoluteURL.append("&\(RequestParamKeys.noinfo.get())")
        
        guard let url = URL(string: absoluteURL) else {
            return
        }
        
//        print("##### URL formed : \(url.absoluteString)")
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        self.urlRequest = urlRequest
    }
    
    func fetch(_ response: (([User]?) -> ())?){
        guard let request = urlRequest, let _ = request.url else {
            response?(nil)
            return
        }
        
        let networkProvider = NetworkProviderFactory.createHttpConnector()
        let networkOperation = GetDataOperation(withURLRequest: request, andNetworkingProvider: networkProvider)
        networkOperation.completionBlock = {
            if networkOperation.error != nil {
                print("<UserRequest> Error in HTTP : [StatusCode : \(String(describing: networkOperation.response?.statusCode))] : <error  [\(String(describing: networkOperation.error?.localizedDescription))]>")
                response?(nil)
                return
            }
            guard let httpresponse = networkOperation.response, let responseData = networkOperation.responseData else{
                response?(nil)
                return
            }
            
//            print("<UserRequest> HTTP Response : \n : Status Code : \(httpresponse.statusCode) : \n")
//            print("Data Received as :\(String(describing: String(data: responseData, encoding: String.Encoding.utf8)))")
            
            let decoder = JSONDecoder()
            do{
                let user = try decoder.decode(Results.self, from: responseData)
                if user.results.count > 0 {
                    response?(user.results)
                }else{
                    print("<UserRequest> Error : No data found")
                    response?(nil)
                }
            }catch let error {
                print("<UserRequest> Error while parsing : [\(error.localizedDescription)]")
                response?(nil)
            }
        }
        
        operationQueue.addOperations([networkOperation], waitUntilFinished: false)
    }
}

fileprivate enum RequestParamValues {
    case scheme
    case host
    case path
    case results(Int)
    case exclude
    
    func get() -> String {
        switch self {
        case .scheme:
            return "https"
        case .host:
            return "randomuser.me"
        case .path:
            return "/api/"
        case let .results(count):
            return count != 0 ? "\(count)" : "\(5)"
        case .exclude:
            return "login,id,registered"
        }
    }
}

fileprivate enum RequestParamKeys {
    case results
    case noinfo
    case exclude
    
    func get() -> String {
        switch self {
        case .results:
            return "results"
        case .noinfo:
            return "noinfo"
        case .exclude:
            return "exc"
        }
    }
}
