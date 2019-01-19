//
//  ProStore.swift
//  Drew_Sullivan_HA_iOS_Project
//
//  Created by Drew Sullivan on 12/27/18.
//  Copyright © 2018 Drew Sullivan. All rights reserved.
//

import UIKit

public class ProStore {
    
    var pros = [Pro]()
    var filteredPros = [Pro]()
    var groups = [Group]()
    var filteredGroups = [Group]()

    var numPros: Int {
        return groups.reduce(0) { $0 + $1.pros.count }
    }
    
    private init() {
        readJSONFile(fileName: "pro_data", fileExtension: "json")
    }
    
    public static let shared: ProStore = {
        let instance = ProStore()
        return instance
    }()
    
    func pro(by sectionIndex: Int, and proIndex: Int) -> Pro {
        return groups[sectionIndex].pro(byIndex: proIndex)
    }
    
    func numPros(inSection sectionIndex: Int) -> Int {
        return groups[sectionIndex].pros.count
    }
    
    func section(forIndex sectionIndex: Int) -> Group {
        return groups[sectionIndex]
    }
    
    func updateSections(withPros pros: [Pro], context: ContextType) {
        let filteredSections = groupProsBySpecialty(prosToGroup: pros, context: context)
        self.filteredGroups = filteredSections
    }
    
    //MARK: - Filtering
    func filteredPro(forIndex index: Int) -> Pro {
        return filteredPros[index]
    }
    
    //MARK: - Sorting
    func sortPros(by sortingType: SortingType) {
        switch sortingType {
        case .companyName:
            pros.sort { $0.companyName < $1.companyName }
        case .rating:
            pros.sort {
                let lhsRating = Double($0.compositeRating) ?? 0.0
                let rhsRating = Double($1.compositeRating) ?? 0.0
                return rhsRating < lhsRating
            }
        case .numRatings:
            pros.sort {
                let lhsNumRatings = Int($0.ratingCount) ?? 0
                let rhsNumRatings = Int($1.ratingCount) ?? 0
                return rhsNumRatings < lhsNumRatings
            }
        }
    }
    
    //MARK: - Helpers
    private func readJSONFile(fileName res: String, fileExtension ext: String) {
        do {
            if let file = Bundle.main.url(forResource: res, withExtension: ext) {
                let data = try Data(contentsOf: file, options: [])
                pros = try JSONDecoder().decode([Pro].self, from: data)
                let sections = groupProsBySpecialty(prosToGroup: pros, context: .normal)
                self.groups = sections
            } else {
                print("No file at that location")
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func groupProsBySpecialty(prosToGroup pros: [Pro], context: ContextType) -> [Group] {
        //Group pros by specialty
        var groupedPros: [String: [Pro]] = [:]
        for pro in pros {
            groupedPros[pro.specialty, default: [Pro]()].append(pro)
        }
        
        //Transform dict into Section objects
        var prosGroupedBySection = [Group]()
        let sortedKeys = groupedPros.keys.sorted()
        for sectionName in sortedKeys {
            if let pros = groupedPros[sectionName] {
                let sortedPros = pros.sorted { $0.companyName < $1.companyName }
                prosGroupedBySection.append(Group(name: sectionName, pros: sortedPros))
            }
        }
        
//        if context == .normal {
//            self.sections = prosGroupedBySection
//        } else if context == .filtering {
//            self.filteredSections = prosGroupedBySection
//        }
        
        return prosGroupedBySection
    }
    
}

public enum SortingType: String {
    case companyName = "Company Name"
    case rating = "Rating"
    case numRatings = "Number of Ratings"
}

public enum ContextType {
    case normal
    case filtering
}
