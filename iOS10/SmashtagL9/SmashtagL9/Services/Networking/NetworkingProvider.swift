//
//  NetworkingProvider.swift
//  SmashtagL9
//
//  Created by Shantanu Dutta on 31/05/18.
//  Copyright © 2018 Shantanu Dutta. All rights reserved.
//

import Foundation

protocol NetworkProvider {
    func sendRequest(with urlRequest: URLRequest, onCompleted: ((Data?, HTTPURLResponse?, Error?) -> ())?)
}
