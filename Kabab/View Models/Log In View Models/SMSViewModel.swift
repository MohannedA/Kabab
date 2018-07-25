//
//  SMSViewModel.swift
//  Kabab
//
//  Created by mac on 12/11/1439 AH.
//  Copyright © 1439 mac. All rights reserved.
//

import Foundation

class SMSViewModel {
    
    // MARK: ~ Inits
    init() {}
    
    // MARK: ~ Public Methods
    
    /// To check if SMS number is valid or not. 
    ///
    /// - Returns: Bool
    func checkISSMSNumberValid(SMSText: String) -> Bool {
        if SMSText ==  "0000" {
            return true
        } else {
            return false
        }
    }
}
