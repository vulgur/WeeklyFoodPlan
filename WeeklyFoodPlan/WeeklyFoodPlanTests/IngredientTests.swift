//
//  IngredientTests.swift
//  WeeklyFoodPlan
//
//  Created by vulgur on 2017/1/1.
//  Copyright © 2017年 MAD. All rights reserved.
//

import XCTest
import RealmSwift
@testable import WeeklyFoodPlan

class IngredientTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
//    func testInit() {
//        let nutritionList = NutritionManager.shared.nutritionList()
//        let tomato = Ingredient()
//        tomato.name = "Tomato"
//        tomato.nutritions = nutritionList
//        
//        XCTAssertNotNil(tomato)
//    }
    
    func testRealmSave() {
//        BaseManager.shared.deleteAll()
        
        let va = Nutrition(value: ["name": "Vitamin-A"])
        let vb = Nutrition(value: ["name": "Vitamin-B"])
        let vc = Nutrition(value: ["name": "Vitamin-C"])
        
        let apple = Ingredient()
        apple.name = "Apple"
        apple.nutritions.append(va)
        apple.nutritions.append(vb)

        let banana = Ingredient()
        banana.name = "Banana"
        banana.nutritions.append(vc)
        
        BaseManager.shared.save(object: apple)
        BaseManager.shared.save(object: banana)
        BaseManager.shared.save(object: banana)
        
        XCTAssertEqual(BaseManager.shared.queryTotalCount(ofType: Ingredient.self), 2)
    }
}
