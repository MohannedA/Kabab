//
//  ScannerViewModel.swift
//  Kabab
//
//  Created by mac on 12/11/1439 AH.
//  Copyright © 1439 mac. All rights reserved.
//

import Foundation

class ScannerViewModel {
    
    // MARK: ~ Inits
    init() {}
    
    // MARK: ~ Public Methods
    
    /// To check if QR code is valid or not.
    ///
    /// - Returns: Bool
    func checkIsQRCodeValid(code: String) -> Bool {
        return true
    }
    
    /// To check if invitation code is valid or not.
    ///
    /// - Returns: Bool
    func checkIsInvitationCodeValid(code: String) -> Bool {
        if code == "0000" {
            return true
        }
        return false
    }
}
