//
//  MealListViewController.swift
//  WeeklyFoodPlan
//
//  Created by vulgur on 2017/2/4.
//  Copyright © 2017年 MAD. All rights reserved.
//

import UIKit

class MealListViewController: UIViewController {

    let cellIdentifier = "MealListCell"
    let segueIdentifier = "ShowMeal"
    @IBOutlet var tableView: UITableView!
    
    var meals = [Meal]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.view.backgroundColor = UIColor.white
        tableView.register(UINib.init(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        tableView.rowHeight = 80
        tableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        meals = BaseManager.shared.queryAllMeals()
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == segueIdentifier {
            if let meal = sender as? Meal,
                let destinationVC = segue.destination as? MealViewController {
                destinationVC.meal = meal
            }
        }
    }

    @IBAction func showMealTypeOptions(_ sender: UIBarButtonItem) {
        let blurEffect = UIBlurEffect(style: .regular)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = self.view.frame
        
        let alertController = UIAlertController(title: "Choose meal type", message: nil, preferredStyle: .alert)
        let homeCookAction = UIAlertAction(title: "HomeCook", style: .default) { [unowned self] (action) in
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MealViewController") as! MealViewController
            vc.mealType = .homeCook
//            let meal = Meal()
//            meal.typeRawValue = Meal.MealType.homeCook.rawValue
//            vc.meal = meal
            blurView.removeFromSuperview()
            self.navigationController?.pushViewController(vc, animated: true)
        }
        let takeOutAction = UIAlertAction(title: "TakeOut", style: .default) { [unowned self] (action) in
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MealViewController") as! MealViewController
            vc.mealType = .takeOut
//            let meal = Meal()
//            meal.typeRawValue = Meal.MealType.takeOut.rawValue
//            vc.meal = meal
            blurView.removeFromSuperview()
            self.navigationController?.pushViewController(vc, animated: true)
        }
        let eatingOutAction = UIAlertAction(title: "EatingOut", style: .default) { [unowned self] (action) in
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MealViewController") as! MealViewController
            vc.mealType = .eatingOut
//            let meal = Meal()
//            meal.typeRawValue = Meal.MealType.eatingOut.rawValue
//            vc.meal = meal
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

extension MealListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meals.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! MealListCell
        let meal = meals[indexPath.row]
        cell.mealNameLabel.text = meal.name
        let whenString = meal.whenObjects.reduce("") { (string, when) -> String in
            string + " " + when.value
        }
        cell.mealWhenLabel.text = whenString
        cell.mealTypeLabel.text = meal.typeRawValue
        if meal.isFavored {
            cell.mealFavorImageView.isHidden = false
            cell.mealFavorImageView.image = #imageLiteral(resourceName: "heart")
        } else {
            cell.mealFavorImageView.isHidden = true
        }
        return cell
    }
}

extension MealListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let meal = meals[indexPath.row]
        performSegue(withIdentifier: segueIdentifier, sender: meal)
    }
}
