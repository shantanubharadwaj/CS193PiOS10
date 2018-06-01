//
//  URLSessionNetworkConnector.swift
//  SmashtagL9
//
//  Created by Shantanu Dutta on 31/05/18.
//  Copyright © 2018 Shantanu Dutta. All rights reserved.
//

import Foundation

struct URLSessionNetworkConnector: NetworkProvider {
    func sendRequest(with urlRequest: URLRequest, onCompleted: ((Data?, HTTPURLResponse?, Error?) -> ())?) {
        guard let _ = urlRequest.url else {
            onCompleted?(nil,nil,nil)
            return
        }
        
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        
        let urlTask = session.dataTask(with: urlRequest) { (data, response, error) in
            onCompleted?(data, response as? HTTPURLResponse, error)
        }
        
        urlTask.resume()
    }
}

public protocol URLConvertible {
    func asURL() -> URL?
}

extension String: URLConvertible {
    public func asURL() -> URL? {
        guard let url = URL(string: self) else { return nil }
        return url
    }
}
