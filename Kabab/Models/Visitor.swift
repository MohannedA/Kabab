//
//  Visitor .swift
//  Kabab
//
//  Created by mac on 19/10/1439 AH.
//  Copyright © 1439 mac. All rights reserved.
//

import Foundation

class Visitor: NSObject {
    //MARK: Var.
    var phoneNumber: String
    var ID: String
    
    init(phoneNumber: String, ID: String) {
        self.phoneNumber = phoneNumber
        self.ID = ID
    }
    
}
