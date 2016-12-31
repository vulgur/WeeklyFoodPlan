//
//  NutritionManager.swift
//  WeeklyFoodPlan
//
//  Created by vulgur on 2016/12/29.
//  Copyright © 2016年 MAD. All rights reserved.
//

import Foundation
import ObjectMapper

struct NutritionManager {
    static func nutritionList() -> [Nutrition] {
        if let path = Bundle.main.path(forResource: "nutritions", ofType: "json") {
            print(path)
            if let jsonData = NSData(contentsOfFile: path) {
                if let jsonString = String.init(data: jsonData as Data, encoding: .utf8) {
                    if let nutritions = Mapper<Nutrition>().mapArray(JSONString: jsonString) {
                        return nutritions
                    }
                }
            }
        }
        return []
    }
}
