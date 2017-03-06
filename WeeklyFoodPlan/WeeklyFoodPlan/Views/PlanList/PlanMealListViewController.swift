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
        self.automaticallyAdjustsScrollViewInsets = false
        
        collectionView.dataSource = self
        collectionView.delegate = self
//        collectionView.register(UINib.init(nibName: cellIdentifier, bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
        generateFakeData()
        collectionView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func generateFakeData() {
        plans.append(DailyPlanManager.shared.fakePlan())
//        plans.append(DailyPlanManager.shared.fakePlan())
//        plans.append(DailyPlanManager.shared.fakePlan())
//        plans.append(DailyPlanManager.shared.fakePlan())
//        plans.append(DailyPlanManager.shared.fakePlan())
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
        cell.plan = plans[indexPath.section]
        cell.tableView.reloadData()
        return cell
    }
    
    @IBAction func barButtonTapped(sender: UIBarButtonItem) {
        let newPlans = WeeklyPlanManager.shared.fakePlan()
        plans = newPlans
        collectionView.reloadData()
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
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
}

