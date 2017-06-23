//
//  FridgeItemCell.swift
//  WeeklyFoodPlan
//
//  Created by Wang Shudao on 2017/6/23.
//  Copyright © 2017年 MAD. All rights reserved.
//

import UIKit
import SwipyCell

class FridgeItemCell: SwipyCell {

    @IBOutlet var itemNameLabel: UILabel!
    @IBOutlet var neededCountLabel: UILabel!
    @IBOutlet var remainedCountLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
