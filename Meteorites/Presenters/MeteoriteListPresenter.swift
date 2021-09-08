//
//  MeteoriteListPresenter.swift
//  MeteoriteTest
//
//  Created by Namita on 9/3/21.
//  Copyright © 2021 Namita. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class MeteoriteListPresenter {

    private let meteoriteDataService : MeteoriteDataService
    weak private var meteoriteListViewDelegate : MeteoriteListViewDelegate?

    init(meteoriteDataService: MeteoriteDataService){
        self.meteoriteDataService = meteoriteDataService
    }

    // Function for setting delegate
    func setViewDelegate(meteoriteListViewDelegate:MeteoriteListViewDelegate?){
        self.meteoriteListViewDelegate = meteoriteListViewDelegate
    }
    
    func getFilteredList(list: [Meteorite]?, filters: MeteoriteFilters?) {
        
        guard let meteorites = list else {return}
        var filtered: [Meteorite] = meteorites
        
        if let year = filters?.fromYear {
            filtered = meteorites.filter({ Int($0.yearString) ?? 0 >= Int(year) ?? 0})
        }
        
        switch filters?.sortBy {
        case .mass:
            filtered = filtered.sorted(by: { Int($0.mass ?? "") ?? 0 > Int($1.mass ?? "") ?? 0 })
        case .year:
            filtered = filtered.sorted(by: { Int($0.yearString) ?? 0 > Int($1.yearString) ?? 0 })
        default:
            filtered = filtered.sorted(by: { $0.name ?? "" > $1.name ?? "" })
        }
        
        self.meteoriteListViewDelegate?.displayFilteredList(list: filtered)
    }
    
    func getMeteoriteList() {
        
        meteoriteDataService.getMeteoriteList { (meteorites, errorMessage) in
            DispatchQueue.main.async {
                if let error = errorMessage {
                    self.meteoriteListViewDelegate?.displayError(error: error)
                }
                self.meteoriteListViewDelegate?.displayList(response: meteorites)
            }
        }
    }
    
    func bookmarkMeteorite(meteorite: Meteorite?, _ success: @escaping (_ isBookmarked: Bool)->Void) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate, let meteorite = meteorite else  {
            return
        }

        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "MeteoriteDB")
        fetchRequest.predicate = NSPredicate(format: "id == %@", meteorite.id ?? "")
        
        var results: [NSManagedObject] = []
        do
        {
            results = try managedContext.fetch(fetchRequest)
        }
        catch {
            print("Could not fetch")
        }
        
        // already exists
        if results.count > 0 {
            do {
                for object in results {
                    managedContext.delete(object)
                }
                
                try managedContext.save()
                success(false)
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
            
        } else {
            
            let entity = NSEntityDescription.entity(forEntityName: "MeteoriteDB", in: managedContext)!
            
              let bookmark = NSManagedObject(entity: entity, insertInto: managedContext)
              bookmark.setValue(meteorite.name, forKeyPath: "name")
              bookmark.setValue(meteorite.id, forKeyPath: "id")
              bookmark.setValue(meteorite.nametype, forKeyPath: "nametype")
              bookmark.setValue(meteorite.recclass, forKeyPath: "recclass")
              bookmark.setValue(meteorite.mass, forKeyPath: "mass")
              bookmark.setValue(meteorite.fall, forKeyPath: "fall")
              bookmark.setValue(meteorite.year, forKeyPath: "year")
              bookmark.setValue(meteorite.reclat, forKeyPath: "reclat")
              bookmark.setValue(meteorite.reclong, forKeyPath: "reclong")
            
              do {
                  try managedContext.save()
                success(true)
              } catch let error as NSError {
                  print("Could not save. \(error), \(error.userInfo)")
              }
        }
    }

}
