//
//  HomeCook.swift
//  WeeklyFoodPlan
//
//  Created by vulgur on 2017/1/21.
//  Copyright © 2017年 MAD. All rights reserved.
//

import Foundation
import RealmSwift

class WhenObject: Object {
    dynamic var value = Food.When.lunch.rawValue
    override static func primaryKey() -> String? {
        return "value"
    }
}

class Food: Object {
    
    enum When: String {
        case breakfast = "Breakfast"
        case brunch = "Brunch"
        case lunch = "Lunch"
        case dinner = "Dinner"
    }
    
    enum FoodType: String {
        case homeCook = "HomeCook"
        case eatingOut = "EatingOut"
        case takeOut = "TakeOut"
    }
    
    dynamic var id = UUID().uuidString
    dynamic var name: String = ""
    dynamic var isFavored: Bool = false
    dynamic var imagePath: String?
    var whenObjects = List<WhenObject>()
    var tags = List<Tag>()
    var ingredients = List<Ingredient>()
    var tips = List<Tip>()
    dynamic var cookCount:Int = 0
    dynamic var typeRawValue = FoodType.homeCook.rawValue
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    func addNeedIngredientCount() {
        for i in self.ingredients {
            i.neededCount += 1
        }
    }
}

extension Food{
    var type: FoodType {
        get {
            if let result = FoodType(rawValue: typeRawValue) {
                return result
            } else {
                return FoodType.homeCook
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
