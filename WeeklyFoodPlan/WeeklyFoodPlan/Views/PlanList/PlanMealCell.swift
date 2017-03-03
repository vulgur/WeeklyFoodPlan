//
//  PlanMealCell.swift
//  WeeklyFoodPlan
//
//  Created by vulgur on 2017/3/3.
//  Copyright © 2017年 MAD. All rights reserved.
//

import UIKit

class PlanMealCell: UITableViewCell {

    @IBOutlet var mealLabel: UILabel!
    @IBOutlet var mealCollectionView: UICollectionView!
<<<<<<< HEAD
    
    let planFoodCellIdentifier = "PlanFoodCell"
    let cellFontSize: CGFloat = 12
    let cellHeight: CGFloat = 30
    var meal = Meal()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        mealCollectionView.register(UINib.init(nibName: planFoodCellIdentifier, bundle: nil), forCellWithReuseIdentifier: planFoodCellIdentifier)
        mealCollectionView.dataSource = self
        mealCollectionView.delegate = self
        mealCollectionView.isScrollEnabled = false
=======
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
>>>>>>> bb9746015e82457bab1343df9ee96f1bf8ac82eb
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
<<<<<<< HEAD
    override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
        if meal.foods.count > 0 {
            mealCollectionView.frame = CGRect(x: 0, y: 0, width: self.bounds.width, height: CGFloat.leastNormalMagnitude)
            mealCollectionView.layoutIfNeeded()
            return mealCollectionView.collectionViewLayout.collectionViewContentSize
        } else {
            return CGSize(width: self.bounds.width, height: 50)
        }
    }
}

extension PlanMealCell: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return meal.foods.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: planFoodCellIdentifier, for: indexPath) as! PlanFoodCell
        let food = meal.foods[indexPath.row]
        cell.foodNameLabel.text = food.name
        return cell
    }
}

extension PlanMealCell: UICollectionViewDelegateFlowLayout {
    
    private func cellWidthFor(title: String) -> CGFloat {
        let font = UIFont.systemFont(ofSize: cellFontSize)
        let tagWidth = title.widthWithConstrainedHeight(height: cellHeight, font: font) + 30
        return tagWidth
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let title = meal.foods[indexPath.row].name
        let cellWidth = cellWidthFor(title: title)
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(8, 8, 8, 8)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
=======
>>>>>>> bb9746015e82457bab1343df9ee96f1bf8ac82eb
}
