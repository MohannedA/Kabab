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
    func checkIsQRCodeValid(code: String) -> Bool {
        return true
    }
    
    func checkIsInvitationCodeValid(code: String) -> Bool {
        if code == "0000" {
            return true
        }
        return false
    }
}
