//
//  MealViewController.swift
//  WeeklyFoodPlan
//
//  Created by vulgur on 2017/3/6.
//  Copyright © 2017年 MAD. All rights reserved.
//

import UIKit
import SwipyCell

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
        tableView.rowHeight = 44
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = dailyPlan.date.dateAndWeekday()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
        if segue.identifier == "SearchFoods",
            let button = sender as? UIButton {
            let destinationVC = segue.destination as! FoodSearchViewController
            let when = Food.When(rawValue: dailyPlan.meals[button.tag].name)
            destinationVC.delegate = self
            destinationVC.when = when
        }
    }
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
        let deleteImageView = UIImageView(image: #imageLiteral(resourceName: "cross"))
        deleteImageView.contentMode = .center
        cell.setSwipeGesture(deleteImageView, color: .red, mode: .exit, state: .state1) { [unowned self] (cell, state, mode) in
            self.deleteFood(cell)
        }
        return cell
    }
    
    private func deleteFood(_ cell: UITableViewCell) {
        if let indexPath = tableView.indexPath(for: cell) {
            let meal = dailyPlan.meals[indexPath.section]
//            let food = meal.foods[indexPath.row]
            meal.foods.remove(objectAtIndex: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
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
//        cell.section = section
        cell.addFoodButton.tag = section
        cell.pickFoodButton.tag = section
        cell.delegate = self
        let sectionView = UIView(frame: cell.frame)
        sectionView.addSubview(cell)
        return sectionView
    }
}

extension MealViewController: MealHeaderCellDelegate {
    func addFoodButtonTapped(section: Int) {
//        performSegue(withIdentifier: "SearchFoods", sender: section)
    }
    
    func pickFoodButtonTapped(section: Int) {
        let meal = dailyPlan.meals[section]
        let when = Food.When(rawValue: meal.name)
        let food = FoodManager.shared.randomFood(of: when!)
        meal.foods.append(food)
        let indexPath = IndexPath(row: meal.foods.count-1, section: section)
        tableView.insertRows(at: [indexPath], with: .fade)
    }
}

extension MealViewController: SwipyCellDelegate {
    func swipeableTableViewCell(_ cell: SwipyCell, didSwipeWithPercentage percentage: CGFloat) {
        
    }
    func swipeableTableViewCellDidEndSwiping(_ cell: SwipyCell) {
        
    }
    func swipeableTableViewCellDidStartSwiping(_ cell: SwipyCell) {
    
    }
}

extension MealViewController: FoodSearchViewControllerDelegate {
    func didChoose(food: Food, when: Food.When) {
        for meal in dailyPlan.meals {
            if meal.name == when.rawValue {
                meal.foods.append(food)
                let indexPath = IndexPath(row: meal.foods.count-1, section: dailyPlan.meals.index(of: meal)!)
                tableView.insertRows(at: [indexPath], with: .fade)
            }
        }
    }
}
