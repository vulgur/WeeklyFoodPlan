//
//  MealTypeViewController.swift
//  WeeklyFoodPlan
//
//  Created by vulgur on 2017/3/1.
//  Copyright © 2017年 MAD. All rights reserved.
//

import UIKit

class MealTypeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationController?.isNavigationBarHidden = true
        self.tabBarController?.tabBar.isHidden = true
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

    @IBAction func addHomeCook(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MealViewController") as! MealViewController
        let meal = Meal()
        meal.typeRawValue = Meal.MealType.homeCook.rawValue
        vc.meal = meal
        navigationController?.pushViewController(vc, animated: true)
        self.view.removeFromSuperview()
        self.removeFromParentViewController()
    }
    @IBAction func addTakeOut(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MealViewController") as! MealViewController
        let meal = Meal()
        meal.typeRawValue = Meal.MealType.takeOut.rawValue
        vc.meal = meal
        navigationController?.pushViewController(vc, animated: true)
        self.view.removeFromSuperview()
        self.removeFromParentViewController()
    }
    @IBAction func addEatingOut(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MealViewController") as! MealViewController
        let meal = Meal()
        meal.typeRawValue = Meal.MealType.eatingOut.rawValue
        vc.meal = meal
        navigationController?.pushViewController(vc, animated: true)
        self.view.removeFromSuperview()
        self.removeFromParentViewController()
    }
}
