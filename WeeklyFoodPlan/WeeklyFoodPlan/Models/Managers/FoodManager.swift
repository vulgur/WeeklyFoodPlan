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
}
