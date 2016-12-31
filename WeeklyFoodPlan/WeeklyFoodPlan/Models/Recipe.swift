//
//  Meal.swift
//  WeeklyFoodPlan
//
//  Created by vulgur on 2016/12/18.
//  Copyright © 2016年 MAD. All rights reserved.
//

import UIKit

struct Recipe {
    
    enum RecipeType {
        case HomeCooking
        case EatingOut
        case TakeOut
    }
    
    var name: String
    var tags: [String]
    var type: RecipeType
    var ingredients: [Ingredient]
    var photo: UIImage
    var cookCount: Int
    var isFavored: Bool
    var steps: [RecipeStep]
}
