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
    var isDone: Bool = false
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func config(by mealFood: MealFood) {
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.black.cgColor
        if mealFood.isDone {
            self.backgroundColor = UIColor.gray
        } else {
            self.backgroundColor = UIColor.white
        }
        isDone = mealFood.isDone
        self.foodNameLabel.text = mealFood.food?.name
        self.foodNameLabel.textColor = UIColor.black
    }

    func toggle() {
        isDone = !isDone
        if isDone {
            self.backgroundColor = UIColor.lightGray
            self.foodNameLabel.textColor = UIColor.white
        } else {
            self.backgroundColor = UIColor.white
            self.foodNameLabel.textColor = UIColor.black
        }
        delegate?.didToggle(cell: self, isDone: isDone)
    }
}
