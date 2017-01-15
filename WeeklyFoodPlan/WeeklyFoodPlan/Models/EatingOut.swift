//
//  EatingOut.swift
//  WeeklyFoodPlan
//
//  Created by vulgur on 2017/1/16.
//  Copyright © 2017年 MAD. All rights reserved.
//

import Foundation
import RealmSwift

class EatingOut: Object, Meal {
    dynamic var name: String = ""
    dynamic var isFavored: Bool = false
    var tags = List<Tag>()
    dynamic var imagePath: String?
    
    override static func primaryKey() -> String? {
        return "name"
    }
}
