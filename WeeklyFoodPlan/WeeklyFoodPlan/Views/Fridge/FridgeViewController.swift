//
//  FridgeViewController.swift
//  WeeklyFoodPlan
//
//  Created by Wang Shudao on 2017/6/23.
//  Copyright © 2017年 MAD. All rights reserved.
//

import UIKit
import SwipyCell

class FridgeViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    let cellIdentifier = "FridgeItemCell"
    
    var items = [Ingredient]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        items = BaseManager.shared.queryAllNeededIngredients()
        tableView.reloadData()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension FridgeViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! FridgeItemCell
        let item = items[indexPath.row]
        cell.itemNameLabel.text = item.name
        cell.neededCountLabel.text = "/\(item.neededCount)"
        cell.neededCountLabel.textColor = UIColor.green
        cell.remainedCountLabel.text = "\(item.remainedCount)"
        if item.remainedCount >= item.neededCount {
            cell.remainedCountLabel.textColor = UIColor.green
        } else {
            cell.remainedCountLabel.textColor = UIColor.red
        }
        
        cell.addSwipeTrigger(forState: .state(0, .right), withMode: .toggle, swipeView: UIView(), swipeColor: UIColor.green) { [unowned self](cell, state, mode) in
            BaseManager.shared.transaction {
                item.remainedCount = item.neededCount
                self.tableView.reloadData()
            }
        }
        return cell
    }
}

extension FridgeViewController: SwipyCellDelegate {
    
    func swipyCellDidStartSwiping(_ cell: SwipyCell) {
        
    }
    func swipyCellDidFinishSwiping(_ cell: SwipyCell) {
        
    }
    func swipyCell(_ cell: SwipyCell, didSwipeWithPercentage percentage: CGFloat) {
        
    }
}
