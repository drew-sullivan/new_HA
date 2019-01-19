//
//  ProStore.swift
//  Drew_Sullivan_HA_iOS_Project
//
//  Created by Drew Sullivan on 12/27/18.
//  Copyright © 2018 Drew Sullivan. All rights reserved.
//

import UIKit

public class ProStore {
    
    var groups = [Group]()
    var filteredGroups = [Group]()
    
    var pros: [Pro] {
        var pros = [Pro]()
        for group in groups {
            pros.append(contentsOf: group.pros)
        }
        return pros
    }

    var numPros: Int {
        return groups.reduce(0) { $0 + $1.pros.count }
    }
    
    private init() {
        readJSONFile(fileName: "pro_data", fileExtension: "json")
    }
    
    static let shared: ProStore = {
        let instance = ProStore()
        return instance
    }()
    
    func updateGroups(withPros pros: [Pro]) {
        let filteredGroups = organizeIntoGroups(pros)
        self.filteredGroups = filteredGroups
    }
    
    // MARK: - Sorting
    func sortGroupContents(by sortingType: SortingType) {
        for group in groups {
            switch sortingType {
            case .companyName:
                group.pros.sort { $0.companyName < $1.companyName }
            case .rating:
                group.pros.sort {
                    let lhsRating = Double($0.compositeRating) ?? 0.0
                    let rhsRating = Double($1.compositeRating) ?? 0.0
                    return rhsRating < lhsRating
                }
            case .numRatings:
                group.pros.sort {
                    let lhsNumRatings = Int($0.ratingCount) ?? 0
                    let rhsNumRatings = Int($1.ratingCount) ?? 0
                    return rhsNumRatings < lhsNumRatings
                }
            }
        }
    }
    
    // MARK: - Helpers
    private func readJSONFile(fileName res: String, fileExtension ext: String) {
        do {
            if let file = Bundle.main.url(forResource: res, withExtension: ext) {
                let data = try Data(contentsOf: file, options: [])
                let pros = try JSONDecoder().decode([Pro].self, from: data)
                let groups = organizeIntoGroups(pros)
                self.groups = groups
            } else {
                print("No file at that location")
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func organizeIntoGroups(_ pros: [Pro]) -> [Group] {
        // Group pros by specialty
        var groupedPros: [String: [Pro]] = [:]
        for pro in pros {
            groupedPros[pro.specialty, default: [Pro]()].append(pro)
        }
        
        // Transform dict into Group objects
        var groups = [Group]()
        let sortedKeys = groupedPros.keys.sorted()
        for groupName in sortedKeys {
            if let pros = groupedPros[groupName] {
                let sortedPros = pros.sorted { $0.companyName < $1.companyName }
                groups.append(Group(name: groupName, pros: sortedPros))
            }
        }
        return groups
    }
    
}

enum SortingType: String {
    case companyName = "Company Name"
    case rating = "Rating"
    case numRatings = "Number of Ratings"
}
