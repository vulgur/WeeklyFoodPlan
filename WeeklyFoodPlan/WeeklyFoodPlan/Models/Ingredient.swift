//
//  Ingredient.swift
//  WeeklyFoodPlan
//
//  Created by vulgur on 2016/12/17.
//  Copyright © 2016年 MAD. All rights reserved.
//

import UIKit
import RealmSwift

class Ingredient: Object {
//    dynamic var id = UUID().uuidString
    dynamic var name: String = ""
    dynamic var neededCount = 0
    dynamic var remainedCount = 0
    dynamic var freshDays = 0
    let nutritions = List<Nutrition>()
    dynamic var imagePath: String?
    
    override static func primaryKey() -> String? {
        return "name"
    }
    
}
