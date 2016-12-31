//
//  Ingredient.swift
//  WeeklyFoodPlan
//
//  Created by vulgur on 2016/12/17.
//  Copyright © 2016年 MAD. All rights reserved.
//

import UIKit
import ObjectMapper

struct Ingredient: Mappable {
    var name: String?
    var nutritions: [Nutrition]?
    var icon: UIImage?
    
    init(name: String, nutritions: [Nutrition], icon: UIImage? = nil) {
        self.name = name
        self.nutritions = nutritions
        self.icon = icon
    }
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        name <- map["name"]
        nutritions <- map["nutritions"]
    }
}

extension Ingredient: Equatable {}

func == (lhs: Ingredient, rhs: Ingredient) -> Bool {
    if lhs.name != rhs.name {
        return false
    }
    
    // TODO: for now just compare the count of nutritions
    if lhs.nutritions?.count != rhs.nutritions?.count {
        return false
    }
    
    return true
}
