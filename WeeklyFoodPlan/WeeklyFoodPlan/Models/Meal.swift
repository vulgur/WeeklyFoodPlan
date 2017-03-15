//
//  Meal.swift
//  WeeklyFoodPlan
//
//  Created by vulgur on 2017/3/3.
//  Copyright © 2017年 MAD. All rights reserved.
//

import Foundation
import RealmSwift

class Meal: Object {
    dynamic var id = UUID().uuidString
    dynamic var name: String = "" // correspond to Food.When.value
    var foods = List<Food>()
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

class DoneFoodInMeal: Object {
    dynamic var id = UUID().uuidString
    dynamic var meal: Meal?
    dynamic var food: Food?
    dynamic var isDone = false
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
