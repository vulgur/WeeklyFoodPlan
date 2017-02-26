//
//  MealListViewController.swift
//  WeeklyFoodPlan
//
//  Created by vulgur on 2017/2/4.
//  Copyright © 2017年 MAD. All rights reserved.
//

import UIKit

class MealListViewController: UIViewController {

    let cellIdentifier = "MealListCell"
    @IBOutlet var tableView: UITableView!
    
    var meals = [Meal]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib.init(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        tableView.rowHeight = 80
        tableView.tableFooterView = UIView()
        meals = BaseManager.shared.queryAllMeals()
        tableView.reloadData()
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

extension MealListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meals.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! MealListCell
        let meal = meals[indexPath.row]
        cell.mealNameLabel.text = meal.name
        let whenString = meal.whenObjects.reduce("") { (string, when) -> String in
            string + " " + when.value
        }
        cell.mealWhenLabel.text = whenString
        if meal is HomeCook {
            cell.mealTypeLabel.text = "HomeCook"
        } else if meal is EatingOut {
            cell.mealTypeLabel.text = "EatingOut"
        } else if meal is TakeOut {
            cell.mealTypeLabel.text = "TakeOut"
        } else {
            cell.mealTypeLabel.text = "Unknown"
        }
        return cell
    }
}
