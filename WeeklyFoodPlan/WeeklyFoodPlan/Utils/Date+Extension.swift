//
//  Date+Extension.swift
//  WeeklyFoodPlan
//
//  Created by vulgur on 2017/3/5.
//  Copyright © 2017年 MAD. All rights reserved.
//

import Foundation

extension Date {
    func dateAndWeekday() -> String {
        return self.string(dateStyle: .medium, timeStyle: .none) + " " + self.weekdayName
    }
}
