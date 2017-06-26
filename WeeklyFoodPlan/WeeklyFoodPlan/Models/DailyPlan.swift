//
//  DailyPlan.swift
//  WeeklyFoodPlan
//
//  Created by vulgur on 2017/3/3.
//  Copyright © 2017年 MAD. All rights reserved.
//

import Foundation
import RealmSwift

class DailyPlan: Object {
    dynamic var id = UUID().uuidString
    dynamic var date = Date()
    dynamic var isExpired = false
    var meals = List<Meal>()
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    convenience init(plan: DailyPlan) {
        self.init()
        self.date = plan.date
        self.meals.append(contentsOf: plan.meals)
    }
    
    func reduceIngredients() {
        for meal in self.meals {
            for mealFood in meal.mealFoods {
                mealFood.food?.reduceNeedIngredientCount()
            }
        }
    }
}
