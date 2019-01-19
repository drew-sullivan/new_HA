//
//  ProStore.swift
//  Drew_Sullivan_HA_iOS_Project
//
//  Created by Drew Sullivan on 12/27/18.
//  Copyright © 2018 Drew Sullivan. All rights reserved.
//

import UIKit

public class ProStore {
    
    private var pros = [Pro]()
    private var filteredPros = [Pro]()
    
    private init() {
        readJSONFile(fileName: "pro_data", fileExtension: "json")
        pros = pros.sorted { $0.companyName < $1.companyName }
    }
    
    public static let shared: ProStore = {
        let instance = ProStore()
        return instance
    }()
    
    public var numPros: Int {
        return pros.count
    }
    
    public func pro(forIndex index: Int) -> Pro {
        return pros[index]
    }
    
    public func getPros() -> [Pro] {
        return pros
    }
    
    //MARK: - Filtering
    public func getFilteredPros() -> [Pro] {
        return filteredPros
    }
    
    public func filteredPro(forIndex index: Int) -> Pro {
        return filteredPros[index]
    }
    
    public func setFilteredPros(_ filteredPros: [Pro]) {
        self.filteredPros = filteredPros
    }
    
    //MARK: - Sorting
    public func sortPros(by sortingType: SortingType) {
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
    
    // Opted for readability, despite adding duplication
    public func sortFilteredPros(by sortingType: SortingType) {
        switch sortingType {
        case .companyName:
            filteredPros.sort { $0.companyName < $1.companyName }
        case .rating:
            filteredPros.sort {
                let lhsRating = Double($0.compositeRating) ?? 0.0
                let rhsRating = Double($1.compositeRating) ?? 0.0
                return rhsRating < lhsRating
            }
        case .numRatings:
            filteredPros.sort {
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
            } else {
                print("No file at that location")
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}

public enum SortingType: String {
    case companyName = "Company Name"
    case rating = "Rating"
    case numRatings = "Number of Ratings"
}
