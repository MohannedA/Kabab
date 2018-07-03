//
//  LocalDataSource.swift
//  Kabab
//
//  Created by mac on 19/10/1439 AH.
//  Copyright © 1439 mac. All rights reserved.
//

import Foundation
import RealmSwift

class LocalDataSource: Repository {
    private let realm: Realm = try! Realm()
    
    func getAll() -> [Visitor] {
        return realm.objects(VisitorsDatabase.self).map {$0.entry}
    }
    
    func getByPhoneNumber(phoneNumber: String) -> Visitor {
        return (realm.objects(VisitorsDatabase.self).filter("title = %@", phoneNumber).last?.entry)!
    }
    
    typealias T = Visitor
    
    
}
