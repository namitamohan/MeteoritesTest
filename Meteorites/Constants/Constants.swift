//
//  Constants.swift
//  MeteoriteTest
//
//  Created by Namita on 9/3/21.
//  Copyright © 2021 Namita. All rights reserved.
//

import Foundation

struct Constants {
    static let scheme = "https"
    static let host = "data.nasa.gov"
    static let meteoriteLandings = "/resource/gh4g-9sfh.json"
    static let appToken = "w1mKcUUTPUVuLHkVBLEeu3Vn3"
    
    struct DateFormats {
        static let yyyymmdd = "yyyy-mm-dd"
        static let yyyy = "yyyy"
    }
    
    struct ViewControllers {
        static let meteoriteLocationViewController = "meteoriteLocationViewController"
        static let bookmarksViewController = "bookmarksViewController"
        static let filterTableViewController = "filterTableViewController"
        static let meteoriteListViewController = "meteoriteListViewController"
    }
    
    struct TableViewCells {
        static let meteoriteListTableViewCell = "meteoriteListTableViewCell"
        static let bookmarkTableViewCell = "bookmarkTableViewCell"
    }
    
    struct Titles {
        static let homeViewTitle = "Meteorite"
        static let filterTitle = "Filter"
        static let bookmark = "Bookmark"
    }
    
    struct RequestKeys {
        static let apiKey = "$$app_token"
    }
    
    struct ErrorMessages {
        static let noData = "No Data"
        static let badRequest = "Bad Request"
        static let badURL = "Bad URL"
        static let jsonError = "Json Error"
    }
}
