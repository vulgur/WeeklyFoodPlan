//
//  WeeklyPlanManager.swift
//  WeeklyFoodPlan
//
//  Created by vulgur on 2017/3/5.
//  Copyright © 2017年 MAD. All rights reserved.
//

import Foundation
import RealmSwift
import SwiftDate

class WeeklyPlanManager {

    static let shared = WeeklyPlanManager()
    
    let realm = try! Realm()
    static let firstWeekdayKey = "FirstWeekday"
    var firstWeekDay = WeekDay.sunday
    
    private func regionOf(firstWeekDay: WeekDay) -> Region {
        let tz = TimeZone.autoupdatingCurrent
        let loc = Locale.autoupdatingCurrent
        var cal = Calendar.autoupdatingCurrent
        cal.firstWeekday = firstWeekDay.rawValue
        
        let region = Region(tz: tz, cal: cal, loc: loc)
        return region
    }

    func nextWeeklyPlan() -> [DailyPlan] {
        let now = Date()
        let results = realm.objects(DailyPlan.self).filter("date > %@", now)
        return results.toArray()
    }

    func fakePlan() -> [DailyPlan] {
        let value = UserDefaults.standard.integer(forKey: WeeklyPlanManager.firstWeekdayKey)
        // random the value for test
//        let value = Int(arc4random_uniform(UInt32(7))) + 1
        if value != 0 {
            firstWeekDay = WeekDay(rawValue: value)!
        } else {
            firstWeekDay = WeekDay(rawValue: Calendar.autoupdatingCurrent.firstWeekday)!
            UserDefaults.standard.set(firstWeekDay.rawValue, forKey: WeeklyPlanManager.firstWeekdayKey)
        }

        let today = DateInRegion(absoluteDate: Date(), in: regionOf(firstWeekDay: firstWeekDay))
        
        var nextStartDay: DateInRegion
        var nextEndDay: DateInRegion

        nextStartDay = today + 1.day
        nextEndDay = nextStartDay.endWeek
        
        var components = DateComponents()
        components.day = 1
        let days = Date.dates(between: nextStartDay.absoluteDate, and: nextEndDay.absoluteDate - 1.day, increment: components)

        var plans = [DailyPlan]()
        for day in days {
            let dailyPlan = DailyPlanManager.shared.fakePlan()
            dailyPlan.date = day
            plans.append(dailyPlan)
        }
        // if before night, make meals for today
        if let todayPlan = todayPlan() {
            plans.insert(todayPlan, at: 0)
        }
        
        return plans
    }
    
    private func todayPlan() -> DailyPlan? {
        let plan = DailyPlanManager.shared.fakePlan()
        let now = Date()
        if now.hour > 8 {
            plan.meals.remove(objectAtIndex: 0)
        }
        if now.hour > 12 {
            plan.meals.remove(objectAtIndex: 0)
        }
        if now.hour > 18 {
            return nil
        }
        return plan
    }
}
