//
//  ProTableViewCell.swift
//  Drew_Sullivan_HA_iOS_Project
//
//  Created by Drew Sullivan on 12/28/18.
//  Copyright © 2018 Drew Sullivan. All rights reserved.
//

import UIKit

class ProTableViewCell: UITableViewCell {
    
    @IBOutlet var proNameLabel: UILabel!
    @IBOutlet var ratingInfoLabel: UILabel!
    
    public func config(given pro: Pro) {
        proNameLabel.text = pro.companyName
        ratingInfoLabel.text = pro.ratingInformation
        ratingInfoLabel.textColor = pro.ratingInfoColor
    }
    
}
