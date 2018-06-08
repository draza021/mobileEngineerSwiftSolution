//
//  Endpoint.swift
//  MobileEngineerTest
//
//  Created by Drago on 6/6/18.
//  Copyright © 2018 nsiddevelopment. All rights reserved.
//

import Foundation

protocol Endpoint {
    var path: String { get }
    var queryItems: [URLQueryItem] { get }
}

enum ItemEndpoint: Endpoint {
    case allItems
    
    var path: String {
        switch self {
        case .allItems:
            return "/danieloskarsson/mobile-coding-exercise/master/items.json"
        }
    }
    
    var queryItems: [URLQueryItem] {
        return []
    }
}

extension Endpoint {
    var urlComponent: URLComponents {
        var component = URLComponents()
        component.scheme = "https"
        component.host = "raw.githubusercontent.com"
        component.path = path
        component.queryItems = queryItems
        
        return component
    }
    
    var urlRequest: URLRequest? {
        guard let url = urlComponent.url else { return nil }
        return URLRequest(url: url)
    }
}
