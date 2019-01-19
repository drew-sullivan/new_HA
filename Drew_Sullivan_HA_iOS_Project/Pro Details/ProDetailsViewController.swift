//
//  ProDetailsViewController.swift
//  Drew_Sullivan_HA_iOS_Project
//
//  Created by Drew Sullivan on 12/27/18.
//  Copyright © 2018 Drew Sullivan. All rights reserved.
//

import UIKit

class ProDetailsViewController: UIViewController {
    
    @IBOutlet private var proNameLabel: UILabel!
    @IBOutlet private var specialtyLabel: UILabel!
    @IBOutlet private var ratingInformationLabel: UILabel!
    @IBOutlet private var locationLabel: UILabel!
    @IBOutlet private var servicesLabel: UILabel!
    @IBOutlet private var overviewTextView: UITextView!
    @IBOutlet private var callButton: UIButton!
    @IBOutlet private var emailButton: UIButton!
    
    var pro: Pro!
    
    // MARK: - Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        proNameLabel.text = pro.companyName
        specialtyLabel.text = pro.specialty
        ratingInformationLabel.text = pro.ratingInformation
        locationLabel.text = pro.primaryLocation
        servicesLabel.text = pro.serviceInformation
        overviewTextView.text = pro.companyOverview
    }
    
    // MARK: - IBActions
    @IBAction private func callButtonTapped(_ sender: UIButton) {
        print("phone = \(pro.phoneNumber)")
    }
    @IBAction private func emailButtonTapped(_ sender: UIButton) {
        print("email = \(pro.email)")
    }
}
