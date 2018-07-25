//
//  VisitorsViewModel.swift
//  Kabab
//
//  Created by mac on 12/11/1439 AH.
//  Copyright © 1439 mac. All rights reserved.
//

import Foundation

class VisitorsViewModel {
    
    // MARK: ~ Inits
    init() {}
    
    // MARK: ~ Public Methods
    
    /// To load visitors data from the database.
    ///
    /// - Returns: [[[String: String]]]
    func loadVisitorsData() -> [[[String: String]]] {
        var visitorsData = [[[String: String]]]()
        visitorsData = [[["Name": "Ghostbusters",  "Section": "Expected"],
        ["Name": "Keanu",  "Section": "Expected"]],[["Name": "Jason Bourne",  "Section": "CheckedIn"], ["Name": "Suicide Squad",  "Section": "CheckedIn"]], [["Name": "Star Trek Beyond",  "Section": "CheckedOut"], ["Name": "London Has Fallen",  "Section": "CheckedOut"]]]
        return visitorsData
    }
    
    /// To refresh visitros data in the database.
    ///
    /// - Returns: Void
    func refreshVisitorsData(visitorsData: [[[String: String]]]) {}
}
