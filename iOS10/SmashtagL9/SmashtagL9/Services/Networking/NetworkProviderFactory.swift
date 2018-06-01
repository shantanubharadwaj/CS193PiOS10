//
//  NetworkProviderFactory.swift
//  SmashtagL9
//
//  Created by Shantanu Dutta on 31/05/18.
//  Copyright © 2018 Shantanu Dutta. All rights reserved.
//

import Foundation

struct NetworkProviderFactory {
    static func createHttpConnector() -> NetworkProvider {
        return URLSessionNetworkConnector()
    }
}
