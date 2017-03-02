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
}
