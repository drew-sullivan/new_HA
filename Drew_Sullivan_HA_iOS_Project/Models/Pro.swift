//
//  Pro.swift
//  Drew_Sullivan_HA_iOS_Project
//
//  Created by Drew Sullivan on 12/27/18.
//  Copyright © 2018 Drew Sullivan. All rights reserved.
//

import UIKit

public struct Pro: Decodable {
    var entityId: String
    var companyName: String
    var ratingCount: String
    var compositeRating: String
    var companyOverview: String
    var canadianSP: Bool
    var spanishSpeaking: Bool
    var phoneNumber: String
    var latitude: Double?
    var longitude: Double?
    var servicesOffered: String?
    var specialty: String
    var primaryLocation: String
    var email: String
    
    var ratingInformation: String {
        if let numRatings = Int(ratingCount), numRatings > 0 {
            return "Ratings: \(compositeRating) | \(numRatings) rating(s)"
        } else {
            return "References Available"
        }
    }
    
    var serviceInformation: String {
        if let services = servicesOffered {
            return services
        } else {
            return "Services Not Available"
        }
    }
    
    var ratingInfoColor: UIColor {
        if let rating = Double(compositeRating), rating > 0 {
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
