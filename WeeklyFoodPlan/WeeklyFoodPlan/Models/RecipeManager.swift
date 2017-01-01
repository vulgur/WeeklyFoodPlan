//
//  RecipeManager.swift
//  WeeklyFoodPlan
//
//  Created by vulgur on 2017/1/2.
//  Copyright © 2017年 MAD. All rights reserved.
//

import Foundation
import ObjectMapper

struct RecipeManager {
    
    static func recipeFromJSON(fileName: String) -> Recipe? {
        if let path = Bundle.main.path(forResource: fileName, ofType: "json") {
            if let jsonData = NSData(contentsOfFile: path) {
                if let jsonString = String(data: jsonData as Data, encoding: .utf8) {
                    if let recipe = Mapper<Recipe>().map(JSONString: jsonString) {
                        return recipe
                    }
                }
            }
        }
        return nil
    }
}
