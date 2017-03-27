//
//  FoodManager.swift
//  WeeklyFoodPlan
//
//  Created by vulgur on 2017/3/15.
//  Copyright © 2017年 MAD. All rights reserved.
//

import Foundation
import RealmSwift

class FoodManager {
    static let shared = FoodManager()
    let realm = try! Realm()
    
    func randomFood(of when: Food.When) -> Food {
        let whenObject = realm.objects(WhenObject.self).first { (w) -> Bool in
            w.value == when.rawValue
        }
        let results = realm.objects(Food.self).filter("%@ IN whenObjects", whenObject!)
        let randomIndex = Int(arc4random_uniform(UInt32(results.count)))
        return results[randomIndex]
    }
    
    func allFoods(of when: Food.When) -> [Food] {
        let whenObject = realm.objects(WhenObject.self).first { (w) -> Bool in
            w.value == when.rawValue
        }
        let results = realm.objects(Food.self).filter("%@ IN whenObjects", whenObject!)
        return results.toArray()
    }
    
    func allFoods(of keyword: String) -> [Food] {
        // by name
        let nameResults = realm.objects(Food.self).filter("name CONTAINS %@", keyword).toArray()
        // by tag
        let tag = realm.objects(Tag.self).first { (t) -> Bool in
            t.name.contains(keyword)
        }
        let tagResults = realm.objects(Food.self).filter("%@ IN tags", tag!).toArray()
        var result = Set<Food>()
        result = result.union(nameResults)
        result = result.union(tagResults)
        return Array(result)
    }
}
