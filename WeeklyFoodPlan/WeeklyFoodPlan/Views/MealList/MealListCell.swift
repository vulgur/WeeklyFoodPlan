//
//  MealListItemCell.swift
//  WeeklyFoodPlan
//
//  Created by vulgur on 2017/2/26.
//  Copyright © 2017年 MAD. All rights reserved.
//

import UIKit

class MealListCell: UITableViewCell {

    @IBOutlet var mealImageView: UIImageView!
    @IBOutlet var mealNameLabel: UILabel!
    @IBOutlet var mealTypeLabel: UILabel!
    @IBOutlet var mealWhenLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
