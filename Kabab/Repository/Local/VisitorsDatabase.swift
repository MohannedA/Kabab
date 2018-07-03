//
//  VisitorsDatabase.swift
//  Kabab
//
//  Created by mac on 19/10/1439 AH.
//  Copyright © 1439 mac. All rights reserved.
//

import RealmSwift

class VisitorsDatabase: Object {
    @objc dynamic var phoneNumber: String = ""
    @objc dynamic var ID: String = ""
    
    convenience init(visitor: Visitor) {
        self.init()
        phoneNumber = visitor.phoneNumber
        ID = visitor.ID
    }
    
    var entry: Visitor {
        return Visitor(phoneNumber: phoneNumber, ID: ID)
    }
    
}
