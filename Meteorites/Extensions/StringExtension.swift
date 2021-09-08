//
//  StringExtension.swift
//  MeteoriteTest
//
//  Created by Namita on 9/5/21.
//  Copyright © 2021 Namita. All rights reserved.
//

import Foundation

extension String {
    
    func toStringDate(withFormat with: String, toFormat to: String) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = with
        let date = dateFormatter.date(from: self) ?? Date()
        dateFormatter.dateFormat = to
        let string = dateFormatter.string(from: date)
        return string
    }
    
    func toDate(format with: String) -> Date {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = with
        return dateFormatter.date(from: self) ?? Date()
        
    }
}
