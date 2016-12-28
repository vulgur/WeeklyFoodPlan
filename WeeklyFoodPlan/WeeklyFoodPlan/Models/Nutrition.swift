//
//  Nutrition.swift
//  WeeklyFoodPlan
//
//  Created by vulgur on 2016/12/19.
//  Copyright © 2016年 MAD. All rights reserved.
//

import UIKit
import ObjectMapper

struct Nutrition: Mappable {
    var name: String?
//    var icon: UIImage
    init(name: String) {
        self.name = name
    }
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        name <- map["name"]
    }
}
