//
//  PlanManager.swift
//  WeeklyFoodPlan
//
//  Created by vulgur on 2017/3/3.
//  Copyright © 2017年 MAD. All rights reserved.
//

import Foundation
import RealmSwift

class PlanManager {
    static let shared = PlanManager()
    let realm = try! Realm()
    
    func fakePlan() -> DailyPlan {
        let breakfastObject = realm.objects(WhenObject.self).first { (when) -> Bool in
            when.value == Food.When.breakfast.rawValue
        }
        let lunchObject = realm.objects(WhenObject.self).first { (when) -> Bool in
            when.value == Food.When.lunch.rawValue
        }
        let dinnerObject = realm.objects(WhenObject.self).first { (when) -> Bool in
            when.value == Food.When.dinner.rawValue
        }
        let breakfastResults = realm.objects(Food.self).filter("%@ IN whenObjects", breakfastObject!)
        let lunchResults = realm.objects(Food.self).filter("%@ IN whenObjects", lunchObject!)
        let dinnerResults = realm.objects(Food.self).filter("%@ IN whenObjects", dinnerObject!)
        
        let plan = DailyPlan()
        plan.date = Date()
        
        let breakfastMeal = Meal()
        breakfastMeal.name = Food.When.breakfast.rawValue
        for i in 0..<10 {
            let breakfast = breakfastResults[i]
            breakfastMeal.foods.append(breakfast)
        }
        
        let lunchMeal = Meal()
        lunchMeal.name = Food.When.lunch.rawValue
        for i in 0..<10 {
            let lunch = lunchResults[i]
            lunchMeal.foods.append(lunch)
        }
        
        let dinnerMeal = Meal()
        dinnerMeal.name = Food.When.dinner.rawValue
        for i in 0..<10 {
            let dinner = dinnerResults[i]
            dinnerMeal.foods.append(dinner)
        }
        
        plan.meals.append(breakfastMeal)
        plan.meals.append(lunchMeal)
        plan.meals.append(dinnerMeal)
        
        return plan
    }
}
