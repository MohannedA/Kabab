//
//  VisitorsDatabase.swift
//  Kabab
//
//  Created by mac on 19/10/1439 AH.
//  Copyright © 1439 mac. All rights reserved.
//

import RealmSwift

class EmployeeDataObject: Object {
    @objc dynamic var fullName = ""
    @objc dynamic var IDNumber = ""
    @objc dynamic var phoneNumber = ""
    @objc dynamic var email = ""
    
    convenience init(employee: Employee) {
        self.init()
        fullName = employee.fullName
        IDNumber = employee.IDNumber
        phoneNumber = employee.phoneNumber
        email = employee.email
    }
    
    var entry: Employee {
        return Employee(fullName: fullName, IDNumber: IDNumber, phoneNumber: phoneNumber, email: email)
    }
    
}
