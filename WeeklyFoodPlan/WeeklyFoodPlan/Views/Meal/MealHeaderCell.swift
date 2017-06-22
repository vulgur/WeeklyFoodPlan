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
    
    
    var delegate: MealHeaderCellDelegate?
    var section: Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func addFoodButtonTapped(_ sender: UIButton) {
        delegate?.addFoodButtonTapped(section: section)
    
    }
    @IBAction func pickFoodButtonTapped(_ sender: UIButton) {
        delegate?.pickFoodButtonTapped(section: section)
    }

}
