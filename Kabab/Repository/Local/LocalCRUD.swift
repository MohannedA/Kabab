//
//  LocalDataSource.swift
//  Kabab
//
//  Created by mac on 19/10/1439 AH.
//  Copyright © 1439 mac. All rights reserved.
//

import Foundation
import RealmSwift

class LocalCRUD: Repository {
    
    init() {}
    typealias T = Visitor
    
    //MARK: Var
    private let realm: Realm = try! Realm()
    // Singleton Instance
    static var shered = LocalCRUD()
    
    
    func getAll() -> [Visitor] {
        return realm.objects(VisitorsDatabase.self).map {$0.entry}
    }
    
    func getByPhoneNumber(phoneNumber: String) -> Visitor? {
        return realm.objects(VisitorsDatabase.self).filter("phoneNumber = '" + String(phoneNumber) + "'").first?.entry
    }
    
    func getByIDNumber(IDNumber: String) -> Visitor? {
        return realm.objects(VisitorsDatabase.self).filter("IDNumber = '" + String(IDNumber) + "'").first?.entry
    }
    
    func insert(item: Visitor) {
        try! realm.write {
            realm.add(VisitorsDatabase(visitor: item))
        }
    }
    
}
