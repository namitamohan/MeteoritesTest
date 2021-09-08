//
//  MeteoriteListTableViewCell.swift
//  MeteoriteTest
//
//  Created by Namita on 9/3/21.
//  Copyright © 2021 Namita. All rights reserved.
//

import UIKit
import CoreData

class MeteoriteListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var massLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    @IBOutlet weak var bookmarkButton: UIButton!
    
    var bookmarkMeteorite: (()->Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setDataForCell(meteorite: Meteorite?) {
        
        var title = meteorite?.name
        if let name = meteorite?.name, let recClass = meteorite?.recclass {
            title = "\(name) (\(recClass))"
        }
        nameLabel.text = title
        massLabel.text = meteorite?.mass
        yearLabel.text = meteorite?.yearString
        latitudeLabel.text = String(format: "%.2f", meteorite?.latDouble ?? 0)
        longitudeLabel.text = String(format: "%.2f", meteorite?.longDouble ?? 0)
        bookmarkButton.isSelected = isBookmarked(id: meteorite?.id ?? "")
    }
    
    @IBAction func bookmarkButtonAction(_ sender: Any) {
        bookmarkMeteorite?()
    }
    
    func isBookmarked(id: String) -> Bool {
        
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
            return false
        }
          
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "MeteoriteDB")
        
        fetchRequest.predicate = NSPredicate(format: "id == %@", id)
        var results: [NSManagedObject] = []

        do {
            results = try managedContext.fetch(fetchRequest)
        }
        catch {
            print("error executing fetch request: \(error)")
        }

        return results.count > 0
    }
}
