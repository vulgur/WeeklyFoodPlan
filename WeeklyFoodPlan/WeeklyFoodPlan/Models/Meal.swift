//
//  HomeCook.swift
//  WeeklyFoodPlan
//
//  Created by vulgur on 2017/1/21.
//  Copyright © 2017年 MAD. All rights reserved.
//

import Foundation
import RealmSwift



enum When: String {
    case breakfast = "breakfast"
    case brunch = "brunch"
    case lunch = "lunch"
    case dinner = "dinner"
}

class WhenObject: Object {
    dynamic var value = When.lunch.rawValue
    override static func primaryKey() -> String? {
        return "value"
    }
}

class Meal: Object {
    enum MealType: String {
        case homeCook = "HomeCook"
        case eatingOut = "EatingOut"
        case takeOut = "TakeOut"
    }
    // Protocol properties
    dynamic var id = UUID().uuidString
    dynamic var name: String = ""
    dynamic var isFavored: Bool = false
    dynamic var imagePath: String?
    var whenObjects = List<WhenObject>()
    var tags = List<Tag>()
    var ingredients = List<Ingredient>()
    var tips = List<Tip>()
    dynamic var cookCount:Int = 0
    dynamic var typeRawValue = MealType.homeCook.rawValue
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

extension Meal{
    var type: MealType {
        get {
            if let result = MealType(rawValue: typeRawValue) {
                return result
            } else {
                return MealType.homeCook
            }
        }
    }
    
    var whenList: [String] {
        get {
            var result = [String]()
            for obj in whenObjects {
                result.append(obj.value)
            }
            return result
        }
    }
}
