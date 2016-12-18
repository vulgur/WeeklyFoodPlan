//
//  Meal.swift
//  WeeklyFoodPlan
//
//  Created by vulgur on 2016/12/18.
//  Copyright © 2016年 MAD. All rights reserved.
//

import UIKit

struct Recipe {
    let name: String
    let tags: [String]
    let type: String
    let ingredients: [Ingredient]
    let photo: UIImage
    let cookCount: Int
    let isFavored: Bool
    let steps: [RecipeStep]
}
