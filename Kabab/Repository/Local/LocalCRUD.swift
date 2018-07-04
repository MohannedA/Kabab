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
    
    //MARK: Var
    private let realm: Realm = try! Realm()
    static var shered = LocalCRUD()
    
    
    func getAll() -> [Visitor] {
        return realm.objects(VisitorsDatabase.self).map {$0.entry}
    }
    
    func getByPhoneNumber(phoneNumber: String) -> Visitor {
        return (realm.objects(VisitorsDatabase.self).filter("title = %@", phoneNumber).last?.entry)!
    }
    
    func insert(item: Visitor) {
        self.realm.add(VisitorsDatabase(visitor: item))
    }
    
    typealias T = Visitor
    
    
}
