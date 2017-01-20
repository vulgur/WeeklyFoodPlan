//
//  HomeCook.swift
//  WeeklyFoodPlan
//
//  Created by vulgur on 2017/1/21.
//  Copyright © 2017年 MAD. All rights reserved.
//

import Foundation
import RealmSwift

class HomeCook: Object, Meal {
    dynamic var id = UUID().uuidString
    dynamic var name: String = ""
    dynamic var isFavored: Bool = false
    dynamic var imagePath: String?
    dynamic var whenRaw: Int = When.other.rawValue
    var tags = List<Tag>()
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
