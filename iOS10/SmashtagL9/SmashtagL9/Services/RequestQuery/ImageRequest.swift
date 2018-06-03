//
//  ImageRequest.swift
//  SmashtagL9
//
//  Created by Shantanu Dutta on 01/06/18.
//  Copyright © 2018 Shantanu Dutta. All rights reserved.
//

import Foundation
import UIKit

class ImageRequest {
    private let operationQueue = OperationQueue()
    private var urlRequest: URLRequest?
    init(url: URL) {
        formRequest(url)
    }
    
    fileprivate func formRequest(_ url: URL) {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        self.urlRequest = urlRequest
    }
    
    func fetch(_ response: ((UIImage?) -> ())?){
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
            guard let _ = networkOperation.response, let responseData = networkOperation.responseData else{
                response?(nil)
                return
            }
            
//            print("<ImageRequest> HTTP Response : \n : Status Code : \(httpresponse.statusCode) : \n")
            if let image = UIImage(data: responseData) {
                response?(image)
            }else{
                print("<ImageRequest> Error while converting data to image")
                response?(nil)
            }
        }
        
        operationQueue.addOperations([networkOperation], waitUntilFinished: false)
    }
}
