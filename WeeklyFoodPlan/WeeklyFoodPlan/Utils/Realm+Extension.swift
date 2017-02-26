//
//  Realm+Extension.swift
//  WeeklyFoodPlan
//
//  Created by vulgur on 2017/2/26.
//  Copyright © 2017年 MAD. All rights reserved.
//

import Foundation
import RealmSwift

extension Results {
    func toArray() -> [T] {
        return self.map{$0}
    }
}

extension RealmSwift.List {
    func toArray() -> [T] {
        return self.map{$0}
    }
}
