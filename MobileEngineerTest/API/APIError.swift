//
//  APIError.swift
//  MobileEngineerTest
//
//  Created by Drago on 6/7/18.
//  Copyright © 2018 nsiddevelopment. All rights reserved.
//

import Foundation

enum APIError: Error {
    case urlError(URLError)
    case badResponse
    case jsonDecoder
}

extension APIError {
    var title: String? {
        switch self {
        case .badResponse, .jsonDecoder:
            return nil
        case .urlError(let urlError):
            return nil
        }
    }
    
    var message: String? {
        switch self {
        case .badResponse:
            return NSLocalizedString("Invalid response", comment: "")  // We should not present this to the user, it is for our reference
        case .jsonDecoder:
            return NSLocalizedString("Failed to decode JSON", comment: "")  // Also this...We are testing errors
        case .urlError(let urlError):
            return urlError.localizedDescription
        }
    }
}
