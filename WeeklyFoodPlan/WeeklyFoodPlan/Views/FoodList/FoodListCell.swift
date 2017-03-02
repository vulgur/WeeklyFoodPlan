//
//  FoodViewListItemCell.swift
//  WeeklyFoodPlan
//
//  Created by vulgur on 2017/2/26.
//  Copyright © 2017年 MAD. All rights reserved.
//

import UIKit

class FoodListCell: UITableViewCell {

    @IBOutlet var foodImageView: UIImageView!
    @IBOutlet var foodNameLabel: UILabel!
    @IBOutlet var foodTypeLabel: UILabel!
    @IBOutlet var foodWhenLabel: UILabel!
    @IBOutlet var foodFavorImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
