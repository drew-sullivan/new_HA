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
        
//        let pro = getProWithCheckForFiltering(index: indexPath.row)
        
        let pro = proStore.prosGroupedBySpecialty[indexPath.section].1[indexPath.row]
        
        cell.config(given: pro)
        
        return cell
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return proStore.numSections
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return proStore.section(forIndex: section)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return proStore.numPros(inSection: section)
    }
    
    // MARK: - Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "proDetailsSegue":
            if let row = tableView.indexPathForSelectedRow?.row {
                let pro = getProWithCheckForFiltering(index: row)
                let proDetailsViewController = segue.destination as! ProDetailsViewController
                proDetailsViewController.pro = pro
            }
        default:
            return
        }
    }
    
    //MARK: - Helpers for Filtering
    private func getProWithCheckForFiltering(index: Int) -> Pro {
        if userIsCurrentlyFiltering() {
            return proStore.filteredPro(forIndex: index)
        } else {
            return proStore.pro(forIndex: index)
        }
    }
    
    private func getMultipleProsWithCheckForFiltering() -> [Pro] {
        if userIsCurrentlyFiltering() {
            return proStore.getFilteredPros()
        }
        return proStore.getPros()
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
            self.proStore.sortPros(by: .companyName)
            self.tableView.reloadData()
        }
        
        let sortByRatingAction = UIAlertAction(title: SortingType.rating.rawValue, style: .default) { _ in
            self.proStore.sortPros(by: .rating)
            self.tableView.reloadData()
        }
        
        let sortByNumRatingAction = UIAlertAction(title: SortingType.numRatings.rawValue, style: .default) { _ in
            self.proStore.sortPros(by: .numRatings)
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
    
    internal func updateSearchResults(for searchController: UISearchController) {
        filterProsBySearchText(searchController.searchBar.text!)
    }
    
    private func isSearchBarEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    private func filterProsBySearchText(_ searchText: String, scope: String = "All") {
        let filteredPros = proStore.getPros().filter { (pro: Pro) -> Bool in
            return pro.companyName.lowercased().contains(searchText.lowercased())
        }
        proStore.setFilteredPros(filteredPros)
        
        tableView.reloadData()
    }
}
