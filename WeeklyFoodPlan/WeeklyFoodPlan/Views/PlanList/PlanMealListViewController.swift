//
//  WeeklyFoodListViewController.swift
//  WeeklyFoodPlan
//
//  Created by vulgur on 2017/1/3.
//  Copyright © 2017年 MAD. All rights reserved.
//

import UIKit
import RealmSwift

class PlanMealListViewController: UIViewController {
    
    @IBOutlet var collectionView: UICollectionView!
    let cellIdentifier = "PlanCell"
    var plans = [DailyPlan]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        collectionView.dataSource = self
        collectionView.delegate = self
        loadPlans()
//        generateFakeData()        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.automaticallyAdjustsScrollViewInsets = false
        navigationItem.title = "美食计划".localized()
        collectionView.reloadData()
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        collectionView.reloadData()
//    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func loadPlans() {
        plans = WeeklyPlanManager.shared.nextWeeklyPlan()
    }
    private func generateFakeData() {
        plans.append(DailyPlanManager.shared.fakePlan())
//        plans.append(DailyPlanManager.shared.fakePlan())
//        plans.append(DailyPlanManager.shared.fakePlan())
//        plans.append(DailyPlanManager.shared.fakePlan())
//        plans.append(DailyPlanManager.shared.fakePlan())
    }
    
    @IBAction func barButtonTapped(sender: UIBarButtonItem) {
        let oldPlans = plans
        BaseManager.shared.delete(objects: oldPlans)
        let newPlans = WeeklyPlanManager.shared.fakeWeeklyPlan()
        plans = newPlans
        BaseManager.shared.save(objects: plans)
        collectionView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
        if segue.identifier == "ShowMeals",
            let button = sender as? UIButton{
            let destinationVC = segue.destination as! MealViewController
            destinationVC.dailyPlan = plans[button.tag]
        }
    }
}

extension PlanMealListViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return plans.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! PlanCell
        let plan = plans[indexPath.section]
        cell.plan = plan
        cell.dateLabel.text = plan.date.dateAndWeekday()
        cell.editButton.tag = indexPath.section
        cell.pickButton.tag = indexPath.section
        cell.pickButton.addTarget(self, action: #selector(pickNewPlan(sender:)), for: .touchUpInside)
        cell.tableView.reloadData()
        return cell
    }
    

    @objc private func pickNewPlan(sender: UIButton) {
        let section = sender.tag
        let plan = plans[section]
        for meal in plan.meals {
            BaseManager.shared.transaction {
                meal.foods.removeAll()
                let when = Food.When(rawValue: meal.name)
                for _ in 0..<defaultNumbersOfFoodInAMeal {
                    let food = FoodManager.shared.randomFood(of: when!)
                    meal.foods.append(food)
                }

            }
            
        }
        collectionView.reloadItems(at: [IndexPath(row: 0, section: section)])
    }
}

extension PlanMealListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let headerHeight: CGFloat = navigationController!.navigationBar.bounds.height + UIApplication.shared.statusBarFrame.height
        let footerHeight: CGFloat = tabBarController!.tabBar.bounds.height
        return CGSize(width: self.view.bounds.width, height: self.view.bounds.height - headerHeight - footerHeight)
//        return self.view.bounds.size
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
}

