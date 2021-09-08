//
//  BookmarkTableViewCell.swift
//  Meteorites
//
//  Created by Namita on 9/8/21.
//  Copyright © 2021 Namita. All rights reserved.
//

import UIKit

class BookmarkTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var massLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!

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
    }

}
