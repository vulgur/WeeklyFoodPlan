//
//  MealOptionViewCell.swift
//  WeeklyFoodPlan
//
//  Created by vulgur on 2017/2/22.
//  Copyright © 2017年 MAD. All rights reserved.
//

import UIKit

protocol MealOptionCellDelegate {
    func didAddOption(_ option: String)
    func didRemoveOption(_ option: String)
}

class MealOptionViewCell: UITableViewCell {

    let cellIdentifier = "MealOptionCell"
    let optionSelectedColor = UIColor.green
    let optionDeselectedColor = UIColor.white
    var optionTitles = ["早餐", "午餐", "晚餐"]
    var selectedOptions = [String]()
    let cellGap:CGFloat = 8
    let optionHeight: CGFloat = 30
    let maxOptionsInARow = 3
    
    var delegate: MealOptionCellDelegate?
    @IBOutlet var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        collectionView.register(UINib.init(nibName: cellIdentifier, bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
        collectionView.allowsMultipleSelection = true
        collectionView.dataSource = self
        collectionView.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
        collectionView.frame = CGRect(x: 0, y: 0, width: self.bounds.width, height: CGFloat.leastNormalMagnitude)
        collectionView.layoutIfNeeded()
        
        return collectionView.collectionViewLayout.collectionViewContentSize
    }

}

extension MealOptionViewCell: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return optionTitles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! MealOptionCell
        let title = self.optionTitles[indexPath.row]
        if selectedOptions.contains(title) {
            collectionView.selectItem(at: indexPath, animated: false, scrollPosition: .centeredVertically)
            cell.isSelected = true
            cell.optionLabel.backgroundColor = optionSelectedColor
        }
        cell.optionLabel.text = title
        cell.backgroundColor = optionDeselectedColor
        cell.layer.borderColor = optionSelectedColor.cgColor
        cell.layer.borderWidth = 2
        cell.layer.cornerRadius = 5
        return cell
    }
}

extension MealOptionViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! MealOptionCell
        cell.optionLabel.backgroundColor = optionSelectedColor
        delegate?.didAddOption(cell.optionLabel.text!)
        print("selected")
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! MealOptionCell
        cell.optionLabel.backgroundColor = optionDeselectedColor
        let removedOption = optionTitles[indexPath.row]
        delegate?.didRemoveOption(removedOption)
        print("deselected")
    }
}

extension MealOptionViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = UIScreen.main.bounds.width
        let count = CGFloat(maxOptionsInARow)
        if count > 0 {
            return CGSize(width: (screenWidth - cellGap * count * 2)/count, height: optionHeight)
        } else {
            return CGSize.zero
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(8, 8, 8, 8)
    }
}


