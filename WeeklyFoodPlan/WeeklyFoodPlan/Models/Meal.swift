//
//  Meal.swift
//  WeeklyFoodPlan
//
//  Created by vulgur on 2017/1/15.
//  Copyright © 2017年 MAD. All rights reserved.
//

import UIKit
import RealmSwift

enum When: Int {
    case breakfast = 0
    case brunch = 1
    case lunch = 2
    case dinner = 3
    case other = 4
}

protocol Meal: Equatable {

    var id: String { get }
    var name: String { get set }
    var isFavored: Bool { get set }
    var tags: List<Tag> { get set }
    var imagePath: String? { get set }
    var whenRaw: Int { get set }
//    var when: When {get set}
    
}

extension Meal{
    var when: When {
        get {
            return When(rawValue: whenRaw)!
        }
        set {
            whenRaw = newValue.rawValue
        }
    }
}
