//
//  TakeOut.swift
//  WeeklyFoodPlan
//
//  Created by vulgur on 2017/1/15.
//  Copyright © 2017年 MAD. All rights reserved.
//

import UIKit
import RealmSwift

class TakeOut: Object, Meal {
    dynamic var name: String = ""
    dynamic var isFavored: Bool = false
    var tags = List<Tag>()
    dynamic var imagePath: String?
}
