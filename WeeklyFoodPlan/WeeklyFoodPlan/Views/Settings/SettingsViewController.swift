//
//  SettingsViewController.swift
//  WeeklyFoodPlan
//
//  Created by vulgur on 2017/3/22.
//  Copyright © 2017年 MAD. All rights reserved.
//

import UIKit
import SwiftDate

class SettingsViewController: UITableViewController {
    let firstWeekdayKey = "First Weekday"

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: UITableViewDelegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)!
        switch indexPath.row {
        case 0:
            let alertController = UIAlertController(title: nil, message: "Choose the first week day", preferredStyle: .actionSheet)
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            let mondayAction = UIAlertAction(title: "Monday", style: .default, handler: { [unowned self] (action) in
                UserDefaults.init().set(WeekDay.monday.rawValue, forKey: self.firstWeekdayKey)
                cell.detailTextLabel?.text = "Monday"
            })
            let sundayAction = UIAlertAction(title: "Sunday", style: .default, handler: { [unowned self](action) in
                UserDefaults.init().set(WeekDay.sunday.rawValue, forKey: self.firstWeekdayKey)
                cell.detailTextLabel?.text = "Sunday"
            })
            let saturdayAction = UIAlertAction(title: "Saturday", style: .default, handler: { [unowned self](action) in
                UserDefaults.init().set(WeekDay.saturday.rawValue, forKey: self.firstWeekdayKey)
                cell.detailTextLabel?.text = "Saturday"
            })
            alertController.addAction(mondayAction)
            alertController.addAction(sundayAction)
            alertController.addAction(saturdayAction)
            alertController.addAction(cancelAction)
            present(alertController, animated: true, completion: nil)
        default:
            return
        }
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
