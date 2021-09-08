//
//  MeteoriteModel.swift
//  MeteoriteTest
//
//  Created by Namita on 9/3/21.
//  Copyright © 2021 Namita. All rights reserved.
//

import Foundation

enum SortBy {
    case name
    case mass
    case year
}

struct MeteoriteFilters {
    var fromYear: String?
    var sortBy: SortBy
}

// MARK: - MeteoriteElement
struct Meteorite: Codable {
    let name, id, nametype, recclass: String?
    let mass, fall, year, reclat: String?
    let reclong: String?
    let geolocation: Geolocation?
    
    var yearString: String {
        return year?.toStringDate(withFormat: "yyyy-MM-dd'T'HH:mm:ss.SSS", toFormat: "yyyy") ?? ""
    }
    
    var latDouble: Double {
        if let latString = reclat, let latValue = Double(latString) {
            return latValue
        }
        return 0
    }
    
    var longDouble: Double {
        if let longString = reclong, let longValue = Double(longString) {
            return longValue
        }
        return 0
    }
}

// MARK: - Geolocation
struct Geolocation: Codable {
    let latitude, longitude: String?
}

// MARK: - FailureResponse
struct FailureResponse: Codable {
    let code: String?
    let error: Bool?
    let message: String?
}
