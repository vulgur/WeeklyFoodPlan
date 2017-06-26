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
    
    let planFoodCellIdentifier = "PlanFoodCell"
    let cellFontSize: CGFloat = 12
    let cellHeight: CGFloat = 30
    var meal = Meal()
    
    override func awakeFromNib() {
        super.awakeFromNib()

        mealCollectionView.dataSource = self
        mealCollectionView.delegate = self
        mealCollectionView.isScrollEnabled = false
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
        var totalSize = CGSize.zero
        mealCollectionView.frame = CGRect(x: 0, y: 0, width: self.bounds.width, height: CGFloat.leastNormalMagnitude)
        mealCollectionView.layoutIfNeeded()
        totalSize.height = mealLabel.bounds.height + mealCollectionView.collectionViewLayout.collectionViewContentSize.height + 8*3
        totalSize.width = self.bounds.width
//        return mealCollectionView.collectionViewLayout.collectionViewContentSize
        return totalSize
    }
    
    func config(with meal: Meal) {
        self.mealLabel.text = meal.name
        self.meal = meal
    }
   
}

extension PlanMealCell: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return meal.mealFoods.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: planFoodCellIdentifier, for: indexPath) as! PlanFoodCell
        let food = meal.mealFoods[indexPath.row]

        cell.delegate = self
        cell.config(by: food)
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
        let title = meal.mealFoods[indexPath.row].food?.name
        let cellWidth = cellWidthFor(title: title!)
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(8, 0, 8, 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? PlanFoodCell {
            cell.toggle()
        }
    }
}

extension PlanMealCell: PlanFoodCellDelegate {
    func didToggle(cell: PlanFoodCell, isDone: Bool) {
        if let indexPath = mealCollectionView.indexPath(for: cell) {
            let food = meal.mealFoods[indexPath.row]
            updateIngredients(of: food, isDone: isDone)
        }
    }
    
    private func updateIngredients(of mealFood: MealFood, isDone: Bool) {
        BaseManager.shared.transaction {
            mealFood.isDone = isDone
            if isDone {
                mealFood.food?.consumeIngredients()
            } else {
                mealFood.food?.restoreIngredients()
            }
        }
    }
}
