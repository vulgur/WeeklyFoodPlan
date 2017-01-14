//
//  TakeOutTests.swift
//  WeeklyFoodPlan
//
//  Created by vulgur on 2017/1/15.
//  Copyright © 2017年 MAD. All rights reserved.
//

import XCTest
import RealmSwift
@testable import WeeklyFoodPlan

class TakeOutTests: XCTestCase {
    let realm = try! Realm()
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let allTakeOuts = realm.objects(TakeOut.self)
        try! realm.write {
            realm.delete(allTakeOuts)
        }
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testTakeOutInRealm() {
        let tag1 = Tag(value: ["name": "fish"])
        let tag2 = Tag(value: ["name": "good"])
        let takeout = TakeOut()
        takeout.name = "KFC22"
        takeout.isFavored = true
        takeout.tags.append(tag1)
        takeout.tags.append(tag2)
    
        try! realm.write {
            realm.add(takeout)
        }
        
        let tag3 = Tag(value: ["name": "fish2"])
        let tag4 = Tag(value: ["name": "good2"])
        let takeout2 = TakeOut()
        takeout2.name = "MacD22"
        takeout2.isFavored = true
        takeout2.tags.append(tag3)
        takeout2.tags.append(tag4)
        
        try! realm.write {
            realm.add(takeout2)
        }
        
        let takeouts = realm.objects(TakeOut.self)
        XCTAssertEqual(takeouts.count, 2)
    }
    
}
