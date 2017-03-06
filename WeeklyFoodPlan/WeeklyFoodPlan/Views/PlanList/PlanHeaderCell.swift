//
//  PlanHeaderCell.swift
//  WeeklyFoodPlan
//
//  Created by vulgur on 2017/3/7.
//  Copyright © 2017年 MAD. All rights reserved.
//

import UIKit

class PlanHeaderCell: UITableViewCell {

    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var editButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
