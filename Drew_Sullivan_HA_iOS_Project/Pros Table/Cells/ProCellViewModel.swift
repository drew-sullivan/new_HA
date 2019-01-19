//
//  ProCellViewModel.swift
//  Drew_Sullivan_HA_iOS_Project
//
//  Created by Drew Sullivan on 1/19/19.
//  Copyright © 2019 Drew Sullivan. All rights reserved.
//

import UIKit

class ProCellViewModel {
    
    var pro: Pro!
    
    init(pro: Pro) {
        self.pro = pro
    }
    
    var ratingInfoColor: UIColor {
        if let rating = Double(pro.compositeRating), rating > 0 {
            return getRatingInfoColor(rating: rating)
        } else {
            return UIColor.black
        }
    }
    
    private func getRatingInfoColor(rating num: Double) -> UIColor {
        if num >= 4.0 {
            return UIColor.green
        } else if num >= 3.0 {
            return UIColor.orange
        } else {
            return UIColor.red
        }
    }
}
