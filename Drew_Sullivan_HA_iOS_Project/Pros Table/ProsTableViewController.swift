//
//  ProsViewController.swift
//  Drew_Sullivan_HA_iOS_Project
//
//  Created by Drew Sullivan on 12/27/18.
//  Copyright © 2018 Drew Sullivan. All rights reserved.
//

import UIKit

class ProsTableViewController: UITableViewController {
    
    var proStore: ProStore!
    private var searchController: UISearchController!
    
    @IBOutlet var sortButton: UIBarButtonItem!
    
    @IBAction func sort(_ sender: UIBarButtonItem) {
        let sortingAlertController = configureSortingAlertController()
        present(sortingAlertController, animated: true)
    }
    
    
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
    
    //MARK: - UITableViewController
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProTableViewCell", for: indexPath) as! ProTableViewCell
        
        let groups = getGroupsWithCheckForFiltering()
        let group = groups[indexPath.section]
        let pro = group.pro(byIndex: indexPath.row)
        
        cell.config(given: pro)
        
        return cell
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        let groups = getGroupsWithCheckForFiltering()
        return groups.count
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let groups = getGroupsWithCheckForFiltering()
        return groups[section].name
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let groups = getGroupsWithCheckForFiltering()
        return groups[section].pros.count
    }
    
    // MARK: - Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "proDetailsSegue":
            if let indexPath = tableView.indexPathForSelectedRow {
                let groups = getGroupsWithCheckForFiltering()
                let group = groups[indexPath.section]
                let pro = group.pros[indexPath.row]
                let proDetailsViewController = segue.destination as! ProDetailsViewController
                proDetailsViewController.pro = pro
            }
        default:
            return
        }
    }
    
    //MARK: - Helpers for Filtering
    private func getGroupsWithCheckForFiltering() -> [Group] {
        if userIsCurrentlyFiltering() {
            return proStore.filteredGroups
        }
        return proStore.groups
    }
    
    //MARK: - Helpers for Configuring
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
        
        let sortByCompanyNameAction = UIAlertAction(title: SortingType.companyName.rawValue, style: .default) { _ in
            self.proStore.sortGroupContents(by: .companyName)
            self.tableView.reloadData()
        }
        
        let sortByRatingAction = UIAlertAction(title: SortingType.rating.rawValue, style: .default) { _ in
            self.proStore.sortGroupContents(by: .rating)
            self.tableView.reloadData()
        }
        
        let sortByNumRatingAction = UIAlertAction(title: SortingType.numRatings.rawValue, style: .default) { _ in
            self.proStore.sortGroupContents(by: .numRatings)
            self.tableView.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        
        ac.addAction(sortByCompanyNameAction)
        ac.addAction(sortByRatingAction)
        ac.addAction(sortByNumRatingAction)
        ac.addAction(cancelAction)
        
        return ac
    }
}

//MARK: - UISearchResultsUpdating
extension ProsTableViewController: UISearchResultsUpdating {
    
    private func userIsCurrentlyFiltering() -> Bool {
        return searchController.isActive && !isSearchBarEmpty()
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        filterProsBySearchText(searchController.searchBar.text!)
    }
    
    private func isSearchBarEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    private func filterProsBySearchText(_ searchText: String, scope: String = "All") {
        let filteredPros = proStore.pros.filter { (pro: Pro) -> Bool in
            return pro.companyName.lowercased().contains(searchText.lowercased())
        }
        proStore.updateGroups(withPros: filteredPros)
        
        tableView.reloadData()
    }
}