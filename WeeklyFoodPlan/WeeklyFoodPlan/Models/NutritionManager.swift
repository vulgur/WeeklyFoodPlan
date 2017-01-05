//
//  NutritionManager.swift
//  WeeklyFoodPlan
//
//  Created by vulgur on 2016/12/29.
//  Copyright © 2016年 MAD. All rights reserved.
//

import Foundation

class NutritionManager: BaseManager {
    
    class func save(nutrition: Nutrition) {
        try! realm.write {
            realm.add(nutrition)
        }
    }
    
    class func nutritionCount() -> Int {
        let nutritions = realm.objects(Nutrition.self)
        return nutritions.count
    }
}
