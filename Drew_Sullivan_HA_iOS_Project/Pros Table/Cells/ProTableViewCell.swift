//
//  ProTableViewCell.swift
//  Drew_Sullivan_HA_iOS_Project
//
//  Created by Drew Sullivan on 12/28/18.
//  Copyright © 2018 Drew Sullivan. All rights reserved.
//

import UIKit

class ProTableViewCell: UITableViewCell {
    
    @IBOutlet private var proNameLabel: UILabel!
    @IBOutlet private var ratingInfoLabel: UILabel!
    
    func config(given pro: Pro) {
        let proCellViewModel = ProCellViewModel(pro: pro)
        proNameLabel.text = proCellViewModel.pro.companyName
        ratingInfoLabel.text = proCellViewModel.pro.ratingInformation
        ratingInfoLabel.textColor = proCellViewModel.ratingInfoColor
    }
    
}
