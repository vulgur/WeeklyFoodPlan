//
//  IngredientTests.swift
//  WeeklyFoodPlan
//
//  Created by vulgur on 2017/1/1.
//  Copyright © 2017年 MAD. All rights reserved.
//

import XCTest
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
//        let nutritionList = NutritionManager.nutritionList()
//        let tomato = Ingredient(name: "Tomato", nutritions: nutritionList, icon: nil)
//        
//        XCTAssertNotNil(tomato)
//    }
//    
//    func testInitFromJSON() {
//        let apple = IngredientManager.ingredientFromJSON(fileName: "apple_ingredient")!
//        
//        let appleNutritions = NutritionManager.nutritionList(fromData: "apple_nutritions")
//        let anotherApple = Ingredient(name: "Apple", nutritions: appleNutritions)
//        
//        XCTAssert(apple == anotherApple)
//    }
}
