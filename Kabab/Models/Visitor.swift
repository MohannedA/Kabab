//
//  Visitor .swift
//  Kabab
//
//  Created by mac on 19/10/1439 AH.
//  Copyright © 1439 mac. All rights reserved.
//

import Foundation

class Visitor: NSObject {
    //MARK: ~ Variables
    var phoneNumber: String
    var IDNumber: String
    
    init(phoneNumber: String, IDNumber: String) {
        self.phoneNumber = phoneNumber
        self.IDNumber = IDNumber
    }
    
}
