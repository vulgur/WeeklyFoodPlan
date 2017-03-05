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
    enum FirstWeekday {
        case saturday
        case sunday
        case monday
    }
    
    static let shared = WeeklyPlanManager()
    
    let realm = try! Realm()
    let firstWeekdayKey = "FirstWeekdayIsMonday"
    var firstWeekdayIsSunday = true
    
    func fakePlan() -> [DailyPlan] {
        
        if let _ = UserDefaults.standard.string(forKey: firstWeekdayKey) {
            self.firstWeekdayIsSunday = false
        } else {
            self.firstWeekdayIsSunday = true
        }
        
        let now = Date()
        
        var nextStartDay: DateInRegion
        var nextEndDay: DateInRegion

        if now.isInWeekend {
            // make plan for next week
            if firstWeekdayIsSunday {
                let nextSunday = now.next(day: .sunday)!
                nextStartDay = DateInRegion(absoluteDate: nextSunday)
                nextEndDay = DateInRegion(absoluteDate: nextSunday.next(day: .saturday)!)
            } else {
                nextStartDay = DateInRegion(absoluteDate: now.next(day: .monday)!)
                nextEndDay = now.nextWeekend!.endDate
            }
        } else {
            // make plan for this week
            nextStartDay = DateInRegion(absoluteDate: now + 1.day)
            if firstWeekdayIsSunday {
                nextEndDay = now.nextWeekend!.startDate
            } else {
                nextEndDay = now.nextWeekend!.endDate
            }
        }
        
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
