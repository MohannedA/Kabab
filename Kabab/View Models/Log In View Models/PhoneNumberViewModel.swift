//
//  PhoneNumberViewModel.swift
//  Kabab
//
//  Created by mac on 12/11/1439 AH.
//  Copyright © 1439 mac. All rights reserved.
//

import Foundation

class PhoneNumebrViewModel {
    
    // MARK: ~ Inits
    init() {}
    
    
    // MARK: ~ Public Methods
    
    /// To check the phone number if valid or not. 
    ///
    /// - Returns: Bool
    func checkIsPhoneNumberValid(phoneNumber: String) -> Bool {
        if let _ = VisitorLocalCRUD.shered.getByPhoneNumber(phoneNumber: phoneNumber) {
            return true
        } else {
            return false
        }
    }
}
