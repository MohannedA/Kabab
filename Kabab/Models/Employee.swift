//
//  Employee .swift
//  Kabab
//
//  Created by mac on 09/11/1439 AH.
//  Copyright © 1439 mac. All rights reserved.
//

import Foundation

class Employee: NSObject {
    //MARK: ~ Variables
    var fullName: String
    var IDNumber: String
    var phoneNumber: String
    var email: String
    
    init(fullName: String, IDNumber: String, phoneNumber: String, email: String) {
        self.fullName = fullName
        self.IDNumber = IDNumber
        self.phoneNumber = phoneNumber
        self.email = email
    }
    
}
