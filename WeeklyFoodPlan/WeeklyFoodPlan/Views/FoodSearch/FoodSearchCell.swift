//
//  FoodSearchCell.swift
//  WeeklyFoodPlan
//
//  Created by vulgur on 2017/3/16.
//  Copyright © 2017年 MAD. All rights reserved.
//

import UIKit

class FoodSearchCell: UITableViewCell {

    @IBOutlet var foodImageView: UIImageView!
    @IBOutlet var foodLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
