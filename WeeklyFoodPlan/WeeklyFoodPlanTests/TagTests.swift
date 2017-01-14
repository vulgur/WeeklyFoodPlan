//
//  TagTests.swift
//  WeeklyFoodPlan
//
//  Created by vulgur on 2017/1/15.
//  Copyright © 2017年 MAD. All rights reserved.
//

import XCTest
import RealmSwift
@testable import WeeklyFoodPlan

class TagTests: XCTestCase {
    
    let realm = try! Realm()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let allTags = realm.objects(Tag.self)
        try! realm.write {
            realm.delete(allTags)
        }
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testTagInRealm() {
        let tag = Tag(value: ["name": "test tag"])
        let realm = try! Realm()
        try! realm.write {
            realm.add(tag)
        }
        
        let tags = realm.objects(Tag.self)
        XCTAssertEqual(tags.count, 1)
    }
    
}
