//
//  Meal.swift
//  WeeklyFoodPlan
//
//  Created by vulgur on 2016/12/18.
//  Copyright © 2016年 MAD. All rights reserved.
//

import UIKit

struct Recipe {
    var name: String
    var tags: [String]
    var type: String
    var ingredients: [Ingredient]
    var photo: UIImage
    var cookCount: Int
    var isFavored: Bool
    var steps: [RecipeStep]
}
