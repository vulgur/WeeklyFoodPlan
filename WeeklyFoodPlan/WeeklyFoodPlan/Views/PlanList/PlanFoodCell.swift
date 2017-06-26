//
//  PlanFoodCell.swift
//  WeeklyFoodPlan
//
//  Created by vulgur on 2017/3/3.
//  Copyright © 2017年 MAD. All rights reserved.
//

import UIKit

protocol PlanFoodCellDelegate {
    func didToggle(cell: PlanFoodCell, isDone: Bool)
}

class PlanFoodCell: UICollectionViewCell {

    @IBOutlet var foodNameLabel: UILabel!
    var delegate: PlanFoodCellDelegate?
    var isDone = false
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func toggle() {
        isDone = !isDone
        if isDone {
            self.backgroundColor = UIColor.lightGray
        } else {
            self.backgroundColor = UIColor.white
        }
        delegate?.didToggle(cell: self, isDone: isDone)
    }
}
