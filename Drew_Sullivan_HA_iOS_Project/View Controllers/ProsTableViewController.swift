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
    var searchController: UISearchController!
    
    @IBOutlet var sortButton: UIBarButtonItem!
    
    @IBAction func sort(_ sender: UIBarButtonItem) {
        let title = "Sort by..."
        
        let ac = UIAlertController(title: title, message: nil, preferredStyle: .actionSheet)
        
        let sortByCompanyNameAction = UIAlertAction(title: SortingType.companyName.description, style: .default) { _ in
            self.proStore.sortPros(by: .companyName)
            self.tableView.reloadData()
        }
        let sortByRatingAction = UIAlertAction(title: SortingType.rating.description, style: .default) { _ in
            self.proStore.sortPros(by: .rating)
            self.tableView.reloadData()
        }
        let sortByNumRatingAction = UIAlertAction(title: SortingType.numRatings.description, style: .default) { _ in
            self.proStore.sortPros(by: .numRatings)
            self.tableView.reloadData()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        
        ac.addAction(sortByCompanyNameAction)
        ac.addAction(sortByRatingAction)
        ac.addAction(sortByNumRatingAction)
        ac.addAction(cancelAction)
        
        present(ac, animated: true)
    }
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = true
        searchController.searchBar.placeholder = "Search For a Pro"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 65
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    // MARK: - TableView
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return proStore.numPros
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProTableViewCell", for: indexPath) as! ProTableViewCell
        let pro = proStore.pro(forIndex: indexPath.row)
        
        cell.proNameLabel.text = pro.companyName
        cell.ratingInfoLabel.text = pro.ratingInformation
        cell.ratingInfoLabel.textColor = pro.ratingInfoColor
        
        return cell
    }
    
    // MARK: - Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "proDetailsSegue":
            if let row = tableView.indexPathForSelectedRow?.row {
                let pro = proStore.pro(forIndex: row)
                let proDetailsViewController = segue.destination as! ProDetailsViewController
                proDetailsViewController.pro = pro
            }
        default:
            return
        }
    }
}

extension ProsTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        // todo
    }
}
