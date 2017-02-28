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
    let segueIdentifier = "ShowMeal"
    @IBOutlet var tableView: UITableView!
    
    var meals = [Meal]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.view.backgroundColor = UIColor.white
        tableView.register(UINib.init(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        tableView.rowHeight = 80
        tableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        meals = BaseManager.shared.queryAllMeals()
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == segueIdentifier {
            if let meal = sender as? Meal,
                let destinationVC = segue.destination as? MealViewController {
                destinationVC.meal = meal
            }
        }
    }

    @IBAction func showMealTypeOptions(_ sender: UIBarButtonItem) {
        let mealTypeVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MealTypeViewController") as! MealTypeViewController
        self.addChildViewController(mealTypeVC)
        self.view.addSubview(mealTypeVC.view)
        mealTypeVC.view.frame = self.view.frame
        mealTypeVC.didMove(toParentViewController: self)
        
    }
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
        cell.mealTypeLabel.text = meal.typeRawValue
        if meal.isFavored {
            cell.mealFavorImageView.isHidden = false
            cell.mealFavorImageView.image = #imageLiteral(resourceName: "heart")
        } else {
            cell.mealFavorImageView.isHidden = true
        }
        return cell
    }
}

extension MealListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let meal = meals[indexPath.row]
        performSegue(withIdentifier: segueIdentifier, sender: meal)
    }
}
