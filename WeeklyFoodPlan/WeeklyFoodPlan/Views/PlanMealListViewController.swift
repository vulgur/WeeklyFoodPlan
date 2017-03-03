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
        plans.append(PlanManager.shared.fakePlan())
        plans.append(PlanManager.shared.fakePlan())
        plans.append(PlanManager.shared.fakePlan())
        plans.append(PlanManager.shared.fakePlan())
        plans.append(PlanManager.shared.fakePlan())
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

extension PlanMealListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let plan = plans[section]
        return plan.date.description
    }
}
