//
//  SearchViewController.swift
//  Kabab
//
//  Created by mac on 09/11/1439 AH.
//  Copyright © 1439 mac. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    // MARK: ~ Properties
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    
    // MARK: ~ Variables
    var visitorsData = [[[String: String]]]() // Contains all the visitors data.
    var joinedVisitorsData = [[String: String]]()
    var filteredVisitorsData = [[String: String]]() // Contains only filtered data.
    var isSearching = false
    var searchText = ""
    

    // MARK: ~ Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Join the visitors array.
        joinedVisitorsData = Array(Array(visitorsData.joined()))
        
        // Set up delegates
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        
        // Set up search bar done key.
        searchBar.returnKeyType = UIReturnKeyType.done
        
    }
    
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == "" {
            isSearching = false
            
            // Resign the first responder.
            view.endEditing(true)
            
            // Update the table view.
            tableView.reloadData()
        } else {
            isSearching = true
            
            // Filter visitors data.
            filteredVisitorsData = joinedVisitorsData.filter({$0["Name"] == searchBar.text})
            
            // Update with new filtered visitors data.
            tableView.reloadData()
        }
    }
}


extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching {
            return filteredVisitorsData.count
        }
        return joinedVisitorsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if let titleLabel = cell.viewWithTag(10) as? UILabel {
            if isSearching {
                searchText = filteredVisitorsData[indexPath.row]["Name"]!
                titleLabel.text = searchText
            } else {
                searchText = joinedVisitorsData[indexPath.row]["Name"]!
                titleLabel.text = searchText
            }
        }
        if let subtitleLabel = cell.viewWithTag(20) as? UILabel {
            if isSearching {
                subtitleLabel.text = filteredVisitorsData[indexPath.row]["Section"]
            } else {
                subtitleLabel.text = joinedVisitorsData[indexPath.row]["Section"]
            }
        }
        return cell
    }

}
