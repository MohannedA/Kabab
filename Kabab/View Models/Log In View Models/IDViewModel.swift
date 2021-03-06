//
//  IDViewModel.swift
//  Kabab
//
//  Created by mac on 12/11/1439 AH.
//  Copyright © 1439 mac. All rights reserved.
//

import Foundation

class IDViewModel {
    
    // MARK: ~ Inits
    init() {}
    
    // MARK: ~ Public Methods
    
    /// To check the ID number if valid or not.
    ///
    /// - Returns: Bool
    func checkIsIDValid(IDNumber: String) -> Bool {
        if let _ = VisitorLocalCRUD.shered.getByIDNumber(IDNumber: IDNumber) {
            return true
        } else {
            return false
        }
    }
    
}
