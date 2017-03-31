//
//  FoodPreviewViewController.swift
//  WeeklyFoodPlan
//
//  Created by Wang Shudao on 2017/3/31.
//  Copyright © 2017年 MAD. All rights reserved.
//

import UIKit

class FoodPreviewViewController: UIViewController {

    @IBOutlet var foodNameLabel: UILabel!
    @IBOutlet var whenLabel: UILabel!
    @IBOutlet var tagsLabel: UILabel!
    @IBOutlet var ingredientsLabel: UILabel!
    
    var food: Food?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let food = food {
            foodNameLabel.text = food.name
            
            whenLabel.text = food.whenList.joined(separator: " / ")
            
            var tagsString = ""
            for tag in food.tags {
                tagsString += tag.name + " "
            }
            tagsLabel.text = tagsString
            
            var ingreString = ""
            for ingre in food.ingredients {
                ingreString += ingre.name + " "
            }
            ingredientsLabel.text = ingreString
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
