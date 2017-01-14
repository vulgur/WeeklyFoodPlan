//
//  Meal.swift
//  WeeklyFoodPlan
//
//  Created by vulgur on 2017/1/15.
//  Copyright © 2017年 MAD. All rights reserved.
//

import UIKit
import RealmSwift

protocol Meal: Equatable {
    var name: String { get set }
    var isFavored: Bool { get set }
    var tags: List<Tag> { get set }
    var imagePath: String? { get set }
}

//extension Meal{
//    func == (lhs: Self, rhs: Self) -> Bool {}
//}
