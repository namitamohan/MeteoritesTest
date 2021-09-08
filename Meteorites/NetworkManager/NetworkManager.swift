//
//  NetworkManager.swift
//  MeteoriteTest
//
//  Created by Namita on 9/3/21.
//  Copyright © 2021 Namita. All rights reserved.
//

import Foundation

class NetworkManager {
    
    typealias success = ( _ data: Data?)->Void
    
    typealias failure = ( _ data: Data?, _ error: String?)->Void
    
    // Function for GET HTTP request
    func get(path: String, parameters: [String:String] , success: @escaping success, failure: @escaping failure) {
        
        var components = URLComponents()
        components.scheme = Constants.scheme
        components.host = Constants.host
        components.path = path
        components.queryItems = parameters.map {
             URLQueryItem(name: $0, value: $1)
        }
        
        guard let url = components.url else {
            return failure(nil, Constants.ErrorMessages.badURL)
        }
        
        print(url)
        
        let dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {
                return failure(nil, Constants.ErrorMessages.badRequest)
            }
            
            
            switch statusCode {
                case 200:
                    // convert json to data
                    guard let data = data else {
                        failure(nil, Constants.ErrorMessages.noData)
                        return
                    }
                    success(data)
                case 401:
                    failure(data, nil)
                case 404:
                    failure(data, nil)
                default:
                    failure(nil, "statusCode: \(statusCode)")
            }
        }
        
        dataTask.resume()
    }
}
