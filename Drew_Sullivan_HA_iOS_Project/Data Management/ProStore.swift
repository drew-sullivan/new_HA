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
    var prosGroupedBySpecialty = [(String, [Pro])]()
    
    private init() {
        readJSONFile(fileName: "pro_data", fileExtension: "json")
        pros = pros.sorted { $0.companyName < $1.companyName }
    }
    
    public static let shared: ProStore = {
        let instance = ProStore()
        return instance
    }()
    
    func pro(forIndex index: Int) -> Pro {
        return pros[index]
    }
    
    func numPros(inSection index: Int) -> Int {
        return prosGroupedBySpecialty[index].1.count
    }
    
    func section(forIndex index: Int) -> String {
        return prosGroupedBySpecialty[index].0
    }
    
    //MARK: - Filtering
    func getFilteredPros() -> [Pro] {
        return filteredPros
    }
    
    func filteredPro(forIndex index: Int) -> Pro {
        return filteredPros[index]
    }
    
    func setFilteredPros(_ filteredPros: [Pro]) {
        self.filteredPros = filteredPros
    }
    
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
                groupProsBySpecialty(prosToGroup: pros)
            } else {
                print("No file at that location")
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func groupProsBySpecialty(prosToGroup pros: [Pro]) {
        var specialtiesAndPros: [String: [Pro]] = [:]
        for pro in pros {
            specialtiesAndPros[pro.specialty, default: [Pro]()].append(pro)
        }
        let specialtiesProsTupleArray = specialtiesAndPros.sorted { $0.key < $1.key }
        prosGroupedBySpecialty = specialtiesProsTupleArray
    }
}

public enum SortingType: String {
    case companyName = "Company Name"
    case rating = "Rating"
    case numRatings = "Number of Ratings"
}
