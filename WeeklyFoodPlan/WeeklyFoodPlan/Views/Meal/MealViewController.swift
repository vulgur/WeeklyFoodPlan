//
//  MealViewController.swift
//  WeeklyFoodPlan
//
//  Created by vulgur on 2017/3/6.
//  Copyright © 2017年 MAD. All rights reserved.
//

import UIKit

class MealViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    let mealItemCellIdentifier = "MealItemCell"
    let mealHeaderCellIdentifier = "MealHeaderCell"
    var dailyPlan = DailyPlan()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = dailyPlan.date.dateAndWeekday()
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

extension MealViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return dailyPlan.meals.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let meal = dailyPlan.meals[section]
        return meal.foods.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: mealItemCellIdentifier, for: indexPath) as! MealItemCell
        let meal = dailyPlan.meals[indexPath.section]
        let food = meal.foods[indexPath.row]
        cell.foodNameLabel.text = food.name
        return cell
    }
}

extension MealViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let meal = dailyPlan.meals[section]
        let cell = tableView.dequeueReusableCell(withIdentifier: mealHeaderCellIdentifier) as! MealHeaderCell
        cell.mealNameLabel.text = meal.name
        return cell
    }
}
