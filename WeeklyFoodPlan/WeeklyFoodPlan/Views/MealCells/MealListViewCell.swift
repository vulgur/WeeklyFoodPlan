//
//  MealListViewCell.swift
//  WeeklyFoodPlan
//
//  Created by vulgur on 2017/2/23.
//  Copyright © 2017年 MAD. All rights reserved.
//

import UIKit
import SwipyCell

protocol MealListViewCellDelegate {
    func didRemoveItem(_ item: String, type: MealListViewCell.ItemType)
}

class MealListViewCell: UITableViewCell {

    enum ItemType {
        case Ingredient
        case Tip
    }
    
    let cellIdentifier = "MealListItemCell"
    var items = [String]()
    var delegate: MealListViewCellDelegate?
    var itemType: ItemType = .Ingredient
    
    @IBOutlet var tableView: UITableView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        tableView.register(UINib.init(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        tableView.dataSource = self
        tableView.isScrollEnabled = false
        tableView.tableFooterView = UIView()
    }

    override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
//        tableView.frame = CGRect(x: 0, y: 0, width: self.bounds.width, height: CGFloat.leastNormalMagnitude)
        tableView.layoutIfNeeded()
        
        return tableView.contentSize
    }
}

extension MealListViewCell: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! MealListItemCell
        let title = items[indexPath.row]
        cell.itemLabel.text = title
        cell.itemImageView.backgroundColor = UIColor.green
        cell.defaultColor = tableView.backgroundView?.backgroundColor
        let imageView = UIImageView(image: #imageLiteral(resourceName: "cross"))
        imageView.contentMode = .center
        cell.delegate = self
        cell.setSwipeGesture(imageView, color: UIColor.red, mode: SwipyCellMode.exit, state: SwipyCellState.state1) { (cell, state, mode) in
            self.deleteCell(cell)
        }
        return cell
    }
    
    private func deleteCell(_ cell: UITableViewCell) {
    
        if let indexPath = tableView.indexPath(for: cell) {
            let item = items[indexPath.row]
            items.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            delegate?.didRemoveItem(item, type: self.itemType)
        }
    }
}

extension MealListViewCell: SwipyCellDelegate {
    func swipeableTableViewCell(_ cell: SwipyCell, didSwipeWithPercentage percentage: CGFloat) {

    }
    
    func swipeableTableViewCellDidEndSwiping(_ cell: SwipyCell) {
        
    }
    
    func swipeableTableViewCellDidStartSwiping(_ cell: SwipyCell) {
        
    }
}
