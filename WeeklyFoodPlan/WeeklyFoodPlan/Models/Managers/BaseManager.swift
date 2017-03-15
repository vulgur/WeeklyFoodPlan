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
    static let shared = BaseManager()
    
    let realm = try! Realm()
    
    func save<T: Object>(object: T) {
        do {
            try realm.write {
                realm.add(object, update: true)
            }
        } catch let error as NSError {
            print("Error in saving: ", error)
        }
    }
    
    func queryTotalCount<T: Object>(ofType: T.Type) -> Int {
        let results = realm.objects(T.self)
        return results.count
    }
    
    func queryAllFoods() -> [Food] {
        let foods = realm.objects(Food.self).toArray()
        return foods.reversed()
    }
    
    func deleteAll() {
        try! realm.write {
            realm.deleteAll()
        }
    }
    
    func delete<T: Object>(object: T) {
        do {
            try realm.write {
                realm.delete(object)
            }
        } catch let error as NSError {
            print("Error in deleting: ", error)
        }
    }
}
