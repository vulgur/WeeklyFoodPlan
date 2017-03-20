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
    let firstWeekDayKey = "FirstWeekday"
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
        let value = UserDefaults.standard.integer(forKey: firstWeekDayKey)
        // random the value for test
//        let value = Int(arc4random_uniform(UInt32(7))) + 1
        if value != 0 {
            firstWeekDay = WeekDay(rawValue: value)!
        } else {
            firstWeekDay = WeekDay(rawValue: Calendar.autoupdatingCurrent.firstWeekday)!
            UserDefaults.standard.set(firstWeekDay.rawValue, forKey: firstWeekDayKey)
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
        return plans
    }
}
