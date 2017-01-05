//
//  NutritionTests.swift
//  WeeklyFoodPlan
//
//  Created by vulgur on 2017/1/4.
//  Copyright © 2017年 MAD. All rights reserved.
//

import XCTest
@testable import WeeklyFoodPlan

class NutritionTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSave() {
        NutritionManager.deleteAll()
        let nutA = Nutrition(value: ["name": "AAA"])
        let nutB = Nutrition(value: ["name": "BBB"])
        NutritionManager.save(nutrition: nutA)
        NutritionManager.save(nutrition: nutB)
        let count = NutritionManager.nutritionCount()
        
        XCTAssert(count == 2)
    }
}
