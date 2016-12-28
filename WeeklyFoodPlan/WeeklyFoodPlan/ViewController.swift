//
//  ViewController.swift
//  WeeklyFoodPlan
//
//  Created by vulgur on 2016/12/16.
//  Copyright © 2016年 MAD. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let nutritions = NutritionManager.nutritionList()
        nutritions.forEach { (nut) in
            print(nut.name!)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

