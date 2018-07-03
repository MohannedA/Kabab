//
//  AppDataSource.swift
//  Kabab
//
//  Created by mac on 19/10/1439 AH.
//  Copyright © 1439 mac. All rights reserved.
//

import Foundation

protocol Repository {
    associatedtype T
    
    func getAll(completion: (Bool) -> ()) -> [T]
    
    func getByPhoneNumber(phoneNumber: String, completion: (Bool) -> ()) -> T
    
    func insert(item: T, completion: (Bool) -> ())
}
