//
//  FoodSearchViewController.swift
//  WeeklyFoodPlan
//
//  Created by vulgur on 2017/3/16.
//  Copyright © 2017年 MAD. All rights reserved.
//

import UIKit

protocol FoodSearchViewControllerDelegate {
    func didChoose(food: Food, when: Food.When)
}

class FoodSearchViewController: UIViewController {

    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var tableView: UITableView!
    
    let cellIdentifier = "FoodSearchCell"
    
    var delegate: FoodSearchViewControllerDelegate?
    var when: Food.When?
    var searchResults = [Food]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        searchFoods()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    private func searchFoods() {
        if let when = when {
            searchResults = FoodManager.shared.allFoods(of: when)
            tableView.reloadData()
        }
    }
}

extension FoodSearchViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! FoodSearchCell
        let food = searchResults[indexPath.row]
        cell.foodLabel.text = food.name
        // TODO: set food image
        return cell
    }
}

extension FoodSearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let food = searchResults[indexPath.row]
        delegate?.didChoose(food: food, when: when!)
        _ = navigationController?.popViewController(animated: true)
    }
}
