//
//  MealHeaderCell.swift
//  WeeklyFoodPlan
//
//  Created by vulgur on 2017/3/7.
//  Copyright © 2017年 MAD. All rights reserved.
//

import UIKit

protocol MealHeaderCellDelegate {
    func addFoodButtonTapped(section: Int)
    func pickFoodButtonTapped(section: Int)
}

class MealHeaderCell: UITableViewCell {

    @IBOutlet var mealNameLabel: UILabel!
    @IBOutlet var addFoodButton: UIButton!
    @IBOutlet var pickFoodButton: UIButton!
    
    var section: Int?
    
    var delegate: MealHeaderCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func addFoodButtonTapped(_ sender: UIButton) {
        if let section = section {
            delegate?.addFoodButtonTapped(section: section)
        }
    }
    @IBAction func pickFoodButtonTapped(_ sender: UIButton) {
        if let section = section {
            delegate?.pickFoodButtonTapped(section: section)
        }
    }
}
