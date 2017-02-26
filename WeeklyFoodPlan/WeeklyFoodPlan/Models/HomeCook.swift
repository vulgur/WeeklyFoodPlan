//
//  HomeCook.swift
//  WeeklyFoodPlan
//
//  Created by vulgur on 2017/1/21.
//  Copyright © 2017年 MAD. All rights reserved.
//

import Foundation
import RealmSwift

class HomeCook: Object, Meal {
    // Protocol properties
    dynamic var id = UUID().uuidString
    dynamic var name: String = ""
    dynamic var isFavored: Bool = false
    dynamic var imagePath: String?
    var whenObjects = List<WhenObject>()
    var tags = List<Tag>()
    
    // Custom properties
    var ingredients = List<Ingredient>()
    var tips = List<Tip>()
    dynamic var cookCount:Int = 0
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
