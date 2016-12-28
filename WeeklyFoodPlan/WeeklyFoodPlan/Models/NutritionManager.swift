//
//  NutritionManager.swift
//  WeeklyFoodPlan
//
//  Created by vulgur on 2016/12/29.
//  Copyright © 2016年 MAD. All rights reserved.
//

import Foundation

struct NutritionManager {
    func nutritionList() -> [Nutrition] {
        let vitaminA = Nutrition(name: "维他命A")
        return [vitaminA]
    }
}
