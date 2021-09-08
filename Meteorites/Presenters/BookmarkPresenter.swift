//
//  BookmarkPresenter.swift
//  Meteorites
//
//  Created by Namita on 9/8/21.
//  Copyright © 2021 Namita. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class BookmarkPresenter {

    private var bookmarkViewDelegate: BookmarkViewDelegate?

    // Function for setting delegate
    func setViewDelegate(bookmarkViewDelegate: BookmarkViewDelegate?){
        self.bookmarkViewDelegate = bookmarkViewDelegate
    }
    
    func getBookmarkedMeteorites() {
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
            return
        }
          
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "MeteoriteDB")
        
        var meteoriteList: [Meteorite] = []
        
        do {
            let list = try managedContext.fetch(fetchRequest)
            
            for object in list {
                let meteorite = getMeteorieModel(object: object)
                meteoriteList.append(meteorite)
            }
            
            bookmarkViewDelegate?.displayList(list: meteoriteList)
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    func getMeteorieModel(object:NSManagedObject ) -> Meteorite {
        
        let name = object.value(forKey: "name") as? String
        let id = object.value(forKey: "id") as? String
        let nametype = object.value(forKey: "nametype") as? String
        let recclass = object.value(forKey: "recclass") as? String
        let mass = object.value(forKey: "mass") as? String
        let fall = object.value(forKey: "fall") as? String
        let year = object.value(forKey: "year") as? String
        let reclat = object.value(forKey: "reclat") as? String
        let reclong = object.value(forKey: "reclong") as? String
        
        return Meteorite(name: name, id: id, nametype: nametype, recclass: recclass, mass: mass, fall: fall, year: year, reclat: reclat, reclong: reclong, geolocation: nil)
    }

}
