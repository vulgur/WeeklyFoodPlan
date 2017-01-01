//
//  Meal.swift
//  WeeklyFoodPlan
//
//  Created by vulgur on 2016/12/18.
//  Copyright © 2016年 MAD. All rights reserved.
//

import UIKit
import ObjectMapper

struct Recipe: Mappable {
    
    enum RecipeType: String {
        case HomeCooking = "HomeCooking"
        case EatingOut = "EatingOut"
        case TakeOut = "TakeOut"
        case Other = "Other"
    }
    
    let typeTransform = TransformOf<RecipeType, String>(fromJSON: { (type: String?) -> Recipe.RecipeType? in
        if let type = type {
            switch type {
                case "HomeCooking": return RecipeType.HomeCooking
                case "EatingOut": return RecipeType.EatingOut
                case "TakeOut": return RecipeType.TakeOut
                default: return RecipeType.Other
            }
        } else {
            return RecipeType.Other
        }
    }) { (recipeType: Recipe.RecipeType?) -> String? in
        return recipeType?.rawValue
    }
    
    var name: String?
    var tags: [String]?
    var type: RecipeType?
    var ingredients: [Ingredient]?
    var photo: UIImage?
    var cookCount: Int?
    var isFavored: Bool?
    var steps: [RecipeStep]?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        name <- map["name"]
        tags <- map["tags"]
        type <- (map["type"], typeTransform)
        ingredients <- map["ingredients"]
        // TODO: add properties to map
    }
}
