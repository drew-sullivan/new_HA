//
//  Group.swift
//  Drew_Sullivan_HA_iOS_Project
//
//  Created by Drew Sullivan on 1/19/19.
//  Copyright © 2019 Drew Sullivan. All rights reserved.
//

import Foundation

class Group {
    var name: String
    var pros: [Pro]
    
    init(name: String, pros: [Pro]) {
        self.name = name
        self.pros = pros
    }
    
    func pro(byIndex index: Int) -> Pro {
        return pros[index]
    }
}
