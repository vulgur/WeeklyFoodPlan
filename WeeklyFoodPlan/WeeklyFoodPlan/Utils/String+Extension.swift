//
//  String+Extension.swift
//  WeeklyFoodPlan
//
//  Created by vulgur on 2017/2/9.
//  Copyright © 2017年 MAD. All rights reserved.
//

import Foundation

extension String {
    func localized(withComment comment: String = "") -> String {
        return NSLocalizedString(self, comment: comment)
    }
}
