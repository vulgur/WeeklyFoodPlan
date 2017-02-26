//
//  Meal.swift
//  WeeklyFoodPlan
//
//  Created by vulgur on 2017/1/15.
//  Copyright © 2017年 MAD. All rights reserved.
//

import UIKit
import RealmSwift

enum When: String {
    case breakfast = "breakfast"
    case brunch = "brunch"
    case lunch = "lunch"
    case dinner = "dinner"
    case other = "other"
}

class WhenObject: Object {
    dynamic var value = When.other.rawValue
    override static func primaryKey() -> String? {
        return "value"
    }
}

protocol Meal {

    var id: String { get }
    var name: String { get set }
    var isFavored: Bool { get set }
    var tags: List<Tag> { get set }
    var imagePath: String? { get set }
    var whenObjects: List<WhenObject> { get set }
}

extension Meal{
    var when: [When] {
        get {
            var result = [When]()
            for obj in whenObjects {
                let when = When(rawValue: obj.value)
                result.append(when!)
            }
            return result
        }
    }
}
