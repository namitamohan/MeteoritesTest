//
//  MeteoriteDataService.swift
//  MeteoriteTest
//
//  Created by Namita on 9/3/21.
//  Copyright © 2021 Namita. All rights reserved.
//

import Foundation

class MeteoriteDataService {
    
    let manager = NetworkManager()
    
    // Function for fetching movies list
    func getMeteoriteList(completion: @escaping (_ movieList: [Meteorite]?, _ error: String?)->Void) {
        
        let parameters: [String:String]  = [Constants.RequestKeys.apiKey:Constants.appToken]
        
        manager.get(path: Constants.meteoriteLandings, parameters: parameters, success: { (data) in
            
            if let movieList = try? JSONDecoder().decode([Meteorite].self, from: data!) {
               completion(movieList, nil)
            } else {
                completion(nil, Constants.ErrorMessages.jsonError)
            }
            
        }) { (data, error) in
            
            if let errorResponse = try? JSONDecoder().decode(FailureResponse.self, from: data!) {
                completion(nil, errorResponse.message)
            } else {
                completion(nil, Constants.ErrorMessages.jsonError)
            }
        }
     }
}
