//
//  BaseManager.swift
//  WeeklyFoodPlan
//
//  Created by vulgur on 2017/1/6.
//  Copyright © 2017年 MAD. All rights reserved.
//

import Foundation
import RealmSwift

class BaseManager {
    static let realm = try! Realm()
    
    static func deleteAll() {
        try! realm.write {
            realm.deleteAll()
        }
    }
}
