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
    
    func getAll() -> [T]
    
    func getByPhoneNumber(phoneNumber: String) -> T?
    
    func getByIDNumber(IDNumber: String) -> T?
    
    func insert(item: T)
}
