//
//  DailyPlanManager.swift
//  WeeklyFoodPlan
//
//  Created by vulgur on 2017/3/3.
//  Copyright © 2017年 MAD. All rights reserved.
//

import Foundation
import RealmSwift

class DailyPlanManager {
    static let shared = DailyPlanManager()
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
        let randomBreakfastList = breakfastResults.shuffled()
        for i in 0..<2 {
            let breakfast = randomBreakfastList[i]
            BaseManager.shared.transaction {
                breakfast.addNeedIngredientCount()
            }
            breakfastMeal.foods.append(breakfast)
        }
        
        let lunchMeal = Meal()
        lunchMeal.name = Food.When.lunch.rawValue
        let randomLunchList = lunchResults.shuffled()
        for i in 0..<2 {
            let lunch = randomLunchList[i]
            BaseManager.shared.transaction {
                lunch.addNeedIngredientCount()
            }
            lunchMeal.foods.append(lunch)
        }
        
        let dinnerMeal = Meal()
        dinnerMeal.name = Food.When.dinner.rawValue
        let randomDinnerList = dinnerResults.shuffled()
        for i in 0..<2 {
            let dinner = randomDinnerList[i]
            BaseManager.shared.transaction {
                dinner.addNeedIngredientCount()
            }
        
            dinnerMeal.foods.append(dinner)
        }
        
        plan.meals.append(breakfastMeal)
        plan.meals.append(lunchMeal)
        plan.meals.append(dinnerMeal)
        
        return plan
    }
}
