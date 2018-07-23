//
//  VisitorsDatabase.swift
//  Kabab
//
//  Created by mac on 19/10/1439 AH.
//  Copyright © 1439 mac. All rights reserved.
//

import RealmSwift

class VisitorDataObject: Object {
    @objc dynamic var phoneNumber: String = ""
    @objc dynamic var IDNumber: String = ""
    
    convenience init(visitor: Visitor) {
        self.init()
        phoneNumber = visitor.phoneNumber
        IDNumber = visitor.IDNumber
    }
    
    var entry: Visitor {
        return Visitor(phoneNumber: phoneNumber, IDNumber: IDNumber)
    }
    
}
