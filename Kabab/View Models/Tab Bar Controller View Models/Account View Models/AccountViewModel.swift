//
//  AccountViewModel.swift
//  Kabab
//
//  Created by mac on 12/11/1439 AH.
//  Copyright © 1439 mac. All rights reserved.
//

import Foundation

class AccountViewModel {
    
    // MARK: ~ Inits
    init() {}
    
    // MARK: ~ Public Methods
    
    /// To load employee info from database.
    ///
    /// - Returns: (fullName: String?, IDNumber: String?, phoneNumber: String?, email: String?)
    func getEmployeeInfo() -> (fullName: String?, IDNumber: String?, phoneNumber: String?, email: String?) {
        let employee = EmployeeLocalCRUD.shered.getAll().first
        return (employee?.fullName, employee?.IDNumber, employee?.phoneNumber, employee?.email)
    }
    

}
