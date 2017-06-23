//
//  FoodViewListViewCell.swift
//  WeeklyFoodPlan
//
//  Created by vulgur on 2017/2/23.
//  Copyright © 2017年 MAD. All rights reserved.
//

import UIKit
import SwipyCell

protocol FoodViewListViewCellDelegate {
    func didRemoveItem(_ item: String, type: FoodViewListViewCell.ItemType)
}

class FoodViewListViewCell: UITableViewCell {

    enum ItemType {
        case Ingredient
        case Tip
    }
    
    let cellIdentifier = "FoodViewListItemCell"
    var items = [String]()
    var delegate: FoodViewListViewCellDelegate?
    var itemType: ItemType = .Ingredient
    
    @IBOutlet var tableView: UITableView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        tableView.register(UINib.init(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        tableView.dataSource = self
        tableView.isScrollEnabled = false
        tableView.rowHeight = 44
        tableView.tableFooterView = UIView()
    }

    override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
        if items.count > 0 {
            tableView.frame = CGRect(x: 0, y: 0, width: self.bounds.width, height: CGFloat.leastNormalMagnitude)
            tableView.layoutIfNeeded()
            
            return tableView.contentSize
        } else {
            return CGSize(width: self.bounds.width, height: 50)
        }
    }
}

extension FoodViewListViewCell: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! FoodViewListItemCell
        let title = items[indexPath.row]
        cell.itemLabel.text = title
        cell.itemImageView.backgroundColor = UIColor.green
        cell.defaultColor = tableView.backgroundView?.backgroundColor
        let imageView = UIImageView(image: #imageLiteral(resourceName: "cross"))
        imageView.contentMode = .center
        cell.delegate = self
        cell.addSwipeTrigger(forState: .state(1, .right), withMode: .exit, swipeView: imageView, swipeColor: UIColor.red) { [unowned self] (cell, state, mode) in
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

extension FoodViewListViewCell: SwipyCellDelegate {
    func swipyCellDidStartSwiping(_ cell: SwipyCell) {
        
    }
    func swipyCellDidFinishSwiping(_ cell: SwipyCell) {
        
    }
    func swipyCell(_ cell: SwipyCell, didSwipeWithPercentage percentage: CGFloat) {
        
    }
}
