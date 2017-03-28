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
        var result = Set<Food>()

        // by name
        let nameResults = realm.objects(Food.self).filter("name CONTAINS %@", keyword).toArray()
        result = result.union(nameResults)
        // by tag
        if let tag = realm.objects(Tag.self).first(where: { (t) -> Bool in
            t.name.contains(keyword)
        }) {
            let tagResults = realm.objects(Food.self).filter("%@ IN tags", tag).toArray()
            result = result.union(tagResults)
        }
        
        // by ingredient
        if let ingredient = realm.objects(Ingredient.self).first(where: { (i) -> Bool in
            i.name.contains(keyword)
        }) {
            let ingredentResults = realm.objects(Food.self).filter("%@ IN ingredients", ingredient).toArray()
            result = result.union(ingredentResults)
        }
        
        return Array(result)
    }
}
