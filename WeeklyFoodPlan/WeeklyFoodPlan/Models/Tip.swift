//
//  Tip.swift
//  WeeklyFoodPlan
//
//  Created by vulgur on 2017/2/25.
//  Copyright © 2017年 MAD. All rights reserved.
//

import Foundation
import RealmSwift

class Tip: Object {
    dynamic var id = UUID().uuidString
    dynamic var content: String = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
