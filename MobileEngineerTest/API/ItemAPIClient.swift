//
//  ItemAPIClient.swift
//  MobileEngineerTest
//
//  Created by Drago on 6/6/18.
//  Copyright © 2018 nsiddevelopment. All rights reserved.
//

import Foundation

class ItemAPIClient: APIClient {
    var session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func fetchItems(with endpoint: ItemEndpoint, completion: @escaping (Result<[Item], APIError>) -> Void) {
        guard let urlRequest = endpoint.urlRequest else { return }
        fetch(with: urlRequest) { (result: Result<[Item], APIError>) in
            switch result {
            case .error(let error):
                completion(.error(error))
            case .success(let value):
                completion(.success(value))
            }
        }
    }
}
