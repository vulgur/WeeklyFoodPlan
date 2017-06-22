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
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var pickButton: UIButton!
    @IBOutlet var editButton: UIButton!
    @IBOutlet var lockButton: UIButton!
    
    let cellIdentifier = "PlanMealCell"
    
    var isLocked: Bool {
        return !self.pickButton.isEnabled
    }
    
    var plan = DailyPlan()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableViewAutomaticDimension
    }

    
    @IBAction func lockButtonTapped(_ sender: UIButton) {
        pickButton.isEnabled = !pickButton.isEnabled
        editButton.isEnabled = !editButton.isEnabled
        let title = pickButton.isEnabled ? "Lock": "Unlock"
        sender.setTitle(title, for: .normal)
        
        let cells = tableView.visibleCells
        cells.forEach({ (cell) in
            if self.isLocked {
                (cell as! PlanMealCell).lockImageView.isHidden = false
            } else {
                (cell as! PlanMealCell).lockImageView.isHidden = true
            }
        })
        
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
        cell.lockImageView.isHidden = !self.isLocked
        cell.mealLabel.text = meal.name
        cell.meal = meal
        cell.mealCollectionView.reloadData()
        return cell
    }
}

extension PlanCell: UITableViewDelegate {

}
