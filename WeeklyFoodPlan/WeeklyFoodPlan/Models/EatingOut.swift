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
    dynamic var id = UUID().uuidString
    dynamic var name: String = ""
    dynamic var isFavored: Bool = false
    dynamic var imagePath: String?
    var whenObjects = List<WhenObject>()
    var tags = List<Tag>()
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
