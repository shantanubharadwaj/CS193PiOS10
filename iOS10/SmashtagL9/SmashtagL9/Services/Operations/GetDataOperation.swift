//
//  GetDataOperation.swift
//  OperationQueueTest
//
//  Created by Shantanu Dutta on 5/7/18.
//  Copyright © 2018 Shantanu Dutta. All rights reserved.
//

import Foundation

class GetDataOperation: ASOperation {
    private let urlRequest: URLRequest
    private let provider: NetworkProvider
    
    var responseData: Data?
    var response: HTTPURLResponse?
    var error: Error?
    
    init(withURLRequest urlRequest: URLRequest, andNetworkingProvider provider: NetworkProvider) {
        self.urlRequest = urlRequest
        self.provider = provider
    }
    
    override func main() {
        guard isCancelled == false else {
            finish(true)
            return
        }
        
        executing(true)
        provider.sendRequest(with: urlRequest) { (data, response, error) in
            self.responseData = data
            self.response = response
            self.error = error
            self.executing(false)
            self.finish(true)
        }
    }
}
