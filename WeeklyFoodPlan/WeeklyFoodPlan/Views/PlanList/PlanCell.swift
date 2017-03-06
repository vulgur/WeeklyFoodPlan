//
//  PlanCell.swift
//  WeeklyFoodPlan
//
//  Created by vulgur on 2017/3/3.
//  Copyright © 2017年 MAD. All rights reserved.
//

import UIKit

class PlanCell: UICollectionViewCell {

    @IBOutlet var tableView: UITableView!
    let cellIdentifier = "PlanMealCell"
    
    var plan = DailyPlan()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        tableView.estimatedRowHeight = 200
        tableView.rowHeight = UITableViewAutomaticDimension
    }

}

extension PlanCell: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return plan.meals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! PlanMealCell
        let meal = plan.meals[indexPath.row]
        cell.mealLabel.text = meal.name
        cell.meal = meal
        cell.mealCollectionView.reloadData()
        return cell
    }
}

extension PlanCell: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlanHeaderCell") as! PlanHeaderCell
        cell.dateLabel.text = plan.date.dateAndWeekday()
        cell.editButton.tag = section
        return cell
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
}
