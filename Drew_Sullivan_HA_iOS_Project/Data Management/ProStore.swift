//
//  ProStore.swift
//  Drew_Sullivan_HA_iOS_Project
//
//  Created by Drew Sullivan on 12/27/18.
//  Copyright © 2018 Drew Sullivan. All rights reserved.
//

import UIKit

public class ProStore {
    
    var specialtyGroups = [SpecialtyGroup]()
    var filteredSpecialtyGroups = [SpecialtyGroup]()
    
    var allPros: [Pro] {
        // Get all pros, regardless of specialty group
        var pros = [Pro]()
        for specialtyGroup in specialtyGroups {
            pros.append(contentsOf: specialtyGroup.prosWithSpecialty)
        }
        return pros
    }

    var numProsTotal: Int {
        return specialtyGroups.reduce(0) { $0 + $1.prosWithSpecialty.count }
    }
    
    // MARK: - Initialization
    init() {
        readJSONFile(fileName: "pro_data", fileExtension: "json")
    }
    
    // MARK: - Updating Specialty Groups After Filtering
    func updateFilteredSpecialtyGroups(withFilteredPros filteredPros: [Pro]) {
        let filteredSpecialtyGroups = groupProsBySpecialty(prosToGroup: filteredPros)
        self.filteredSpecialtyGroups = filteredSpecialtyGroups
    }
    
    // MARK: - Sorting
    func sortProsWithinSpecialtyGroups(by proAttribute: ProSortingAttribute) {
        for specialtyGroup in specialtyGroups {
            switch proAttribute {
            case .companyName:
                specialtyGroup.prosWithSpecialty.sort { $0.companyName < $1.companyName }
            case .rating:
                specialtyGroup.prosWithSpecialty.sort {
                    let lhsRating = Double($0.compositeRating) ?? 0.0
                    let rhsRating = Double($1.compositeRating) ?? 0.0
                    return rhsRating < lhsRating
                }
            case .numRatings:
                specialtyGroup.prosWithSpecialty.sort {
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
                let specialtyGroups = groupProsBySpecialty(prosToGroup: pros)
                self.specialtyGroups = specialtyGroups
            } else {
                print("No file at that location")
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func groupProsBySpecialty(prosToGroup pros: [Pro]) -> [SpecialtyGroup] {
        // Group pros by Pro.specialty
        var groupedPros: [String: [Pro]] = [:]
        for pro in pros {
            groupedPros[pro.specialty, default: [Pro]()].append(pro)
        }
        
        // Transform dict into SpecialtyGroup objects
        var specialtyGroups = [SpecialtyGroup]()
        let sortedGroupNames = groupedPros.keys.sorted()
        for groupName in sortedGroupNames {
            if let pros = groupedPros[groupName] {
                let sortedPros = pros.sorted { $0.companyName < $1.companyName }
                specialtyGroups.append(SpecialtyGroup(name: groupName, pros: sortedPros))
            }
        }
        return specialtyGroups
    }
    
}

enum ProSortingAttribute: String {
    case companyName = "Company Name"
    case rating = "Rating"
    case numRatings = "Number of Ratings"
}
