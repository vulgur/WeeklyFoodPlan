//
//  IngredientManager.swift
//  WeeklyFoodPlan
//
//  Created by vulgur on 2017/1/1.
//  Copyright © 2017年 MAD. All rights reserved.
//

import Foundation
import ObjectMapper

struct IngredientManager {
    
    static func ingredientFromJSON(dataName: String) -> Ingredient? {
        if let path = Bundle.main.path(forResource: dataName, ofType: "json") {
            if let jsonData = NSData(contentsOfFile: path) {
                if let jsonString = String(data: jsonData as Data, encoding: .utf8) {
                    if let ingredient = Mapper<Ingredient>().map(JSONString: jsonString) {
                        return ingredient
                    }
                }
            }
        }
        return nil
    }
}
