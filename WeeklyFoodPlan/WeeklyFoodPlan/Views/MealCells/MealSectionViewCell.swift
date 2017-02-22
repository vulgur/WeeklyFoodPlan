//
//  MealSectionViewCell.swift
//  WeeklyFoodPlan
//
//  Created by vulgur on 2017/2/19.
//  Copyright © 2017年 MAD. All rights reserved.
//

import UIKit

class MealSectionViewCell: UITableViewCell {

    enum ButtonType: Int {
        case AddTag = 1
        case AddIngredient = 2
        case AddTip = 3
    }
    
    @IBOutlet var sectionImageView: UIImageView!
    @IBOutlet var sectionLabel: UILabel!
    @IBOutlet var sectionButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
