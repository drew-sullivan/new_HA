//
//  ProsViewController.swift
//  Drew_Sullivan_HA_iOS_Project
//
//  Created by Drew Sullivan on 12/27/18.
//  Copyright © 2018 Drew Sullivan. All rights reserved.
//

import UIKit

class ProsTableViewController: UITableViewController {
    
    @IBOutlet private var sortButton: UIBarButtonItem!
    
    var proStore: ProStore!
    var searchController: UISearchController!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureSearchController()
        configureCellSize()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    // MARK: - IBActions
    @IBAction private func sort(_ sender: UIBarButtonItem) {
        let sortingAlertController = configureSortingAlertController()
        present(sortingAlertController, animated: true)
    }
    
    // MARK: - UITableViewController
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProTableViewCell", for: indexPath) as! ProTableViewCell
        
        let specialtyGroups = getSpecialtyGroupsWithCheckForFiltering()
        let group = specialtyGroups[indexPath.section]
        let pro = group.pro(byIndex: indexPath.row)
        
        cell.config(given: pro)
        
        return cell
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        let specialtyGroups = getSpecialtyGroupsWithCheckForFiltering()
        return specialtyGroups.count
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let specialtyGroups = getSpecialtyGroupsWithCheckForFiltering()
        return specialtyGroups[section].specialtyName
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let specialtyGroups = getSpecialtyGroupsWithCheckForFiltering()
        return specialtyGroups[section].prosWithSpecialty.count
    }
    
    // MARK: - Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "proDetailsSegue":
            if let indexPath = tableView.indexPathForSelectedRow {
                let specialtyGroups = getSpecialtyGroupsWithCheckForFiltering()
                let group = specialtyGroups[indexPath.section]
                let pro = group.prosWithSpecialty[indexPath.row]
                let proDetailsViewController = segue.destination as! ProDetailsViewController
                proDetailsViewController.pro = pro
            }
        default:
            return
        }
    }
    
    // MARK: - Helpers for Filtering
    private func getSpecialtyGroupsWithCheckForFiltering() -> [SpecialtyGroup] {
        if userIsCurrentlyFiltering() {
            return proStore.filteredSpecialtyGroups
        }
        return proStore.specialtyGroups
    }
    
    // MARK: - Helpers for Configuring
    private func configureSearchController() {
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search for a Pro"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    private func configureCellSize() {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 65
    }
    
    private func configureSortingAlertController() -> UIAlertController {
        let title = "Sort by..."
        
        let ac = UIAlertController(title: title, message: nil, preferredStyle: .actionSheet)
        
        let sortByCompanyNameAction = UIAlertAction(title: ProSortingAttribute.companyName.rawValue, style: .default) { _ in
            self.proStore.sortProsWithinSpecialtyGroups(by: .companyName)
            self.tableView.reloadData()
        }
        
        let sortByRatingAction = UIAlertAction(title: ProSortingAttribute.rating.rawValue, style: .default) { _ in
            self.proStore.sortProsWithinSpecialtyGroups(by: .rating)
            self.tableView.reloadData()
        }
        
        let sortByNumRatingAction = UIAlertAction(title: ProSortingAttribute.numRatings.rawValue, style: .default) { _ in
            self.proStore.sortProsWithinSpecialtyGroups(by: .numRatings)
            self.tableView.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        ac.addAction(sortByCompanyNameAction)
        ac.addAction(sortByRatingAction)
        ac.addAction(sortByNumRatingAction)
        ac.addAction(cancelAction)
        
        return ac
    }
}

// MARK: - UISearchResultsUpdating
extension ProsTableViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        filterProsBySearchText(searchController.searchBar.text!)
    }
    
    private func userIsCurrentlyFiltering() -> Bool {
        return searchController.isActive && !isSearchBarEmpty()
    }
    
    private func isSearchBarEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    private func filterProsBySearchText(_ searchText: String, scope: String = "All") {
        let filteredPros = proStore.allPros.filter { (pro: Pro) -> Bool in
            return pro.companyName.lowercased().contains(searchText.lowercased())
        }
        proStore.updateFilteredSpecialtyGroups(withFilteredPros: filteredPros)
        
        tableView.reloadData()
    }
}
