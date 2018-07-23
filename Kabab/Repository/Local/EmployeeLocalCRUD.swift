//
//  LocalDataSource.swift
//  Kabab
//
//  Created by mac on 19/10/1439 AH.
//  Copyright © 1439 mac. All rights reserved.
//

import Foundation
import RealmSwift

class EmployeeLocalCRUD: Repository {
    
    init() {}
    typealias T = Employee
    
    //MARK: Var
    private let realm: Realm = try! Realm()
    // Singleton Instance
    static var shered = EmployeeLocalCRUD()
    
    
    func getAll() -> [Employee] {
        return realm.objects(EmployeeDataObject.self).map {$0.entry}
    }
    
    func getByPhoneNumber(phoneNumber: String) -> Employee? {
        return realm.objects(EmployeeDataObject.self).filter("phoneNumber = '" + String(phoneNumber) + "'").first?.entry
    }
    
    func getByIDNumber(IDNumber: String) -> Employee? {
        return realm.objects(EmployeeDataObject.self).filter("IDNumber = '" + String(IDNumber) + "'").first?.entry
    }
    
    func insert(item: Employee) {
        try! realm.write {
            realm.add(EmployeeDataObject(employee: item))
        }
    }
    
    func deleteAll() {
        try! realm.write {
            realm.deleteAll()
        }
    }
    
    
}
