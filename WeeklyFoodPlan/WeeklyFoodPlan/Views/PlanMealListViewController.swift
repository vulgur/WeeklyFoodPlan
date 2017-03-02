//
//  WeeklyFoodListViewController.swift
//  WeeklyFoodPlan
//
//  Created by vulgur on 2017/1/3.
//  Copyright © 2017年 MAD. All rights reserved.
//

import UIKit
import RealmSwift

class PlanMealListViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    let cellIdentifier = "PlanMealCell"
    
    var plans = [DailyPlan]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        generateFakeData()
        
        tableView.dataSource = self
        tableView.register(UINib.init(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        tableView.tableFooterView = UIView()
        tableView.estimatedRowHeight = 60
        tableView.rowHeight = UITableViewAutomaticDimension
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func generateFakeData() {
        let realm = try! Realm()
        let breakfastObject = realm.objects(WhenObject.self).first { (when) -> Bool in
            when.value == Food.When.breakfast.rawValue
        }
        let lunchObject = realm.objects(WhenObject.self).first { (when) -> Bool in
            when.value == Food.When.lunch.rawValue
        }
        let dinnerObject = realm.objects(WhenObject.self).first { (when) -> Bool in
            when.value == Food.When.dinner.rawValue
        }
        let breakfastResults = realm.objects(Food.self).filter("%@ IN whenObjects", breakfastObject!)
        let lunchResults = realm.objects(Food.self).filter("%@ IN whenObjects", lunchObject!)
        let dinnerResults = realm.objects(Food.self).filter("%@ IN whenObjects", dinnerObject!)
        
        let plan = DailyPlan()
        plan.date = Date()
        
        let breakfastMeal = Meal()
        breakfastMeal.name = Food.When.breakfast.rawValue
        for i in 0..<10 {
            let breakfast = breakfastResults[i]
            breakfastMeal.foods.append(breakfast)
        }
        
        let lunchMeal = Meal()
        lunchMeal.name = Food.When.lunch.rawValue
        for i in 0..<10 {
            let lunch = lunchResults[i]
            lunchMeal.foods.append(lunch)
        }
        
        let dinnerMeal = Meal()
        dinnerMeal.name = Food.When.dinner.rawValue
        for i in 0..<10 {
            let dinner = dinnerResults[i]
            dinnerMeal.foods.append(dinner)
        }
        
        plan.meals.append(breakfastMeal)
        plan.meals.append(lunchMeal)
        plan.meals.append(dinnerMeal)
        
        plans.append(plan)
    }
    
}

extension PlanMealListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return plans.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let plan = plans[section]
        return plan.meals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! PlanMealCell
        let meal = plans[indexPath.section].meals[indexPath.row]
        cell.mealLabel.text = meal.name
        cell.meal = meal
        cell.mealCollectionView.reloadData()
        return cell
    }
}
