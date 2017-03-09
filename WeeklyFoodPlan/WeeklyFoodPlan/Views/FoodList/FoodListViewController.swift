//
//  FoodListViewController.swift
//  WeeklyFoodPlan
//
//  Created by vulgur on 2017/2/4.
//  Copyright © 2017年 MAD. All rights reserved.
//

import UIKit

class FoodListViewController: UIViewController {

    let cellIdentifier = "FoodItemCell"
    let segueIdentifier = "ShowFood"
    @IBOutlet var tableView: UITableView!
    
    var foods = [Food]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.view.backgroundColor = UIColor.white
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 80
        tableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
        foods = BaseManager.shared.queryAllFoods()
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueIdentifier {
            if let cell = sender as? UITableViewCell,
                let indexPath = tableView.indexPath(for: cell) {
                let food = foods[indexPath.row]
                let destinationVC = segue.destination as! FoodViewController
                destinationVC.food = food
            }
        }
    }

    @IBAction func showFoodTypeOptions(_ sender: UIBarButtonItem) {
        let blurEffect = UIBlurEffect(style: .regular)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = self.view.frame
        
        let alertController = UIAlertController(title: "Choose food type", message: nil, preferredStyle: .alert)
        let homeCookAction = UIAlertAction(title: "HomeCook", style: .default) { [unowned self] (action) in
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FoodViewController") as! FoodViewController
            vc.foodType = .homeCook
            blurView.removeFromSuperview()
            self.navigationController?.pushViewController(vc, animated: true)
        }
        let takeOutAction = UIAlertAction(title: "TakeOut", style: .default) { [unowned self] (action) in
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FoodViewController") as! FoodViewController
            vc.foodType = .takeOut
            blurView.removeFromSuperview()
            self.navigationController?.pushViewController(vc, animated: true)
        }
        let eatingOutAction = UIAlertAction(title: "EatingOut", style: .default) { [unowned self] (action) in
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FoodViewController") as! FoodViewController
            vc.foodType = .eatingOut
            blurView.removeFromSuperview()
            self.navigationController?.pushViewController(vc, animated: true)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            blurView.removeFromSuperview()
        }
        alertController.addAction(homeCookAction)
        alertController.addAction(takeOutAction)
        alertController.addAction(eatingOutAction)
        alertController.addAction(cancelAction)
        
        self.view.addSubview(blurView)
        self.present(alertController, animated: true, completion: nil)
    }
}

extension FoodListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foods.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! FoodItemCell
        let food = foods[indexPath.row]
        cell.foodNameLabel.text = food.name
        let whenString = food.whenObjects.reduce("") { (string, when) -> String in
            string + " " + when.value
        }
        cell.foodWhenLabel.text = whenString
        cell.foodTypeLabel.text = food.typeRawValue
        if food.isFavored {
            cell.foodFavorImageView.isHidden = false
            cell.foodFavorImageView.image = #imageLiteral(resourceName: "heart")
        } else {
            cell.foodFavorImageView.isHidden = true
        }
        return cell
    }
}

extension FoodListViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let food = foods[indexPath.row]
//        performSegue(withIdentifier: segueIdentifier, sender: food)
//    }
}
