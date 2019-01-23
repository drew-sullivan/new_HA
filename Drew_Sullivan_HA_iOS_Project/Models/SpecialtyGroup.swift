//
//  SpecialtyGroup.swift
//  Drew_Sullivan_HA_iOS_Project
//
//  Created by Drew Sullivan on 1/19/19.
//  Copyright © 2019 Drew Sullivan. All rights reserved.
//

import Foundation

class SpecialtyGroup {
    var specialtyName: String
    var prosWithSpecialty: [Pro]
    
    init(name: String, pros: [Pro]) {
        self.specialtyName = name
        self.prosWithSpecialty = pros
    }
    
    func pro(byIndex index: Int) -> Pro {
        return prosWithSpecialty[index]
    }
}
