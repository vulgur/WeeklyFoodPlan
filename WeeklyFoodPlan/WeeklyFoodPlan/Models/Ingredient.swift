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
    dynamic var name: String = ""
    let nutritions = List<Nutrition>()
    var icon: UIImage?
    
    override static func ignoredProperties() -> [String] {
        return ["icon"]
    }
}

extension Ingredient {

    static func == (lhs: Ingredient, rhs: Ingredient) -> Bool {
        if lhs.name != rhs.name {
            return false
        }
        
        // TODO: for now just compare the count of nutritions
        if lhs.nutritions.count != rhs.nutritions.count {
            return false
        }
        
        return true
    }
}
