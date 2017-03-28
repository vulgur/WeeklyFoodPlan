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
    let nutritions = List<Nutrition>()
    dynamic var imagePath: String?
    
    override static func primaryKey() -> String? {
        return "name"
    }
    
}
