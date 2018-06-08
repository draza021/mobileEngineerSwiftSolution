//
//  APIClient.swift
//  MobileEngineerTest
//
//  Created by Drago on 6/6/18.
//  Copyright © 2018 nsiddevelopment. All rights reserved.
//

import Foundation

enum Result<V, E> where E: Error {
    case success(V)
    case error(E)
}

protocol APIClient {
    var session: URLSession { get }
    func fetch<V: Codable>(with urlRequest: URLRequest, completion: @escaping (Result<V, APIError>) -> Void)
}

extension APIClient {
    
    func fetch<V: Codable>(with urlRequest: URLRequest, completion: @escaping (Result<V, APIError>) -> Void) {
        let task = session.dataTask(with: urlRequest) { (data, response, error) in
            guard error == nil else {
                completion(.error(.urlError(error as! URLError)))
                return
            }
            
            guard let response = response as? HTTPURLResponse, 200..<300 ~= response.statusCode else {
                completion(.error(.badResponse))
                return
            }
            
            guard let data = data, let value = try? JSONDecoder().decode(V.self, from: data) else {
                completion(.error(.jsonDecoder))
                return
            }
            
            completion(.success(value))
        }
        task.resume()
    }
}
