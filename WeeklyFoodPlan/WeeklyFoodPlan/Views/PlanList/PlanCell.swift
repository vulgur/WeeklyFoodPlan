//
//  PlanCell.swift
//  WeeklyFoodPlan
//
//  Created by vulgur on 2017/3/3.
//  Copyright © 2017年 MAD. All rights reserved.
//

import UIKit

protocol PlanCellDelegate {
    func lockButtonTapped(section: Int)
    func unlockButtonTapped(section: Int)
    func editButtonTapped(section: Int)
    func pickButtonTapped(section: Int)
}

class PlanCell: UICollectionViewCell {

    @IBOutlet var tableView: UITableView!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var pickButton: UIButton!
    @IBOutlet var editButton: UIButton!
    
    
    let cellIdentifier = "PlanMealCell"
    
    var isLocked: Bool {
        return !self.pickButton.isEnabled
    }
    
    var section:Int = 0
    var plan = DailyPlan()
    var delegate: PlanCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableViewAutomaticDimension
    }

    
    @IBAction func pickButtonTapped(_ sender: UIButton) {
        delegate?.pickButtonTapped(section: section)
    }
    
    @IBAction func editButtonTapped(_ sender: UIButton) {
        delegate?.editButtonTapped(section: section)
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
        cell.config(with: meal)

        cell.mealCollectionView.reloadData()
        return cell
    }
}

extension PlanCell: UITableViewDelegate {

}
