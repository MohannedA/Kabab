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
    
    func getByName(name: String) -> T
    
    func insert(item: T)
    
    func update(item: T)
    
    func clean()
    
    func deleteByName(name: String)
    
}
