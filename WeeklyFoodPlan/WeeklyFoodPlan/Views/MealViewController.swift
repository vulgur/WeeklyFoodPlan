//
//  MealViewController.swift
//  WeeklyFoodPlan
//
//  Created by vulgur on 2017/2/22.
//  Copyright © 2017年 MAD. All rights reserved.
//

import UIKit

class MealViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    let mealHeaderViewCellIdentifier = "MealHeaderViewCell"
    let mealSectionViewCellIdentifier = "MealSectionViewCell"
    let mealOptionViewCellIdentifier = "MealOptionViewCell"
    let mealTagViewCellIdentifier = "MealTagViewCell"
    
    let optionViewRow = 2
    let tagViewRow = 4
    let ingredientViewRow = 6
    let tipViewRow = 8
    
    var tagTitles = ["this is a dynamic answer that should work", "Best", "Veg", " answer that should",  "Apple", "Diet", "Must Every Week", "大块肉", "尖椒土豆丝", "蝙蝠侠大战超人", "家乡捞单呢吗这位您的二位"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib.init(nibName: mealHeaderViewCellIdentifier, bundle: nil), forCellReuseIdentifier: mealHeaderViewCellIdentifier)
        tableView.register(UINib.init(nibName: mealSectionViewCellIdentifier, bundle: nil), forCellReuseIdentifier: mealSectionViewCellIdentifier)
        tableView.register(UINib.init(nibName: mealOptionViewCellIdentifier, bundle: nil), forCellReuseIdentifier: mealOptionViewCellIdentifier)
        tableView.register(UINib.init(nibName: mealTagViewCellIdentifier, bundle: nil), forCellReuseIdentifier: mealTagViewCellIdentifier)
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 50
        tableView.separatorColor = UIColor.clear
        
        tableView.tableFooterView = UIView()
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension MealViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: mealHeaderViewCellIdentifier, for: indexPath) as! MealHeaderViewCell
            cell.backgroundColor = UIColor.lightGray
            cell.headerLabel.text = "Big Mac"
            cell.headerImageView.image = #imageLiteral(resourceName: "hamburger")
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: mealSectionViewCellIdentifier, for: indexPath) as! MealSectionViewCell
            cell.backgroundColor = UIColor.cyan
            cell.sectionImageView.image = #imageLiteral(resourceName: "clock")
            cell.sectionLabel.text = "When do you want to enjoy?"
            cell.sectionButton.isHidden = true
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: mealOptionViewCellIdentifier, for: indexPath) as! MealOptionViewCell
            cell.collectionView.reloadData()
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: mealSectionViewCellIdentifier, for: indexPath) as! MealSectionViewCell
            cell.backgroundColor = UIColor.cyan
            cell.sectionImageView.image = #imageLiteral(resourceName: "hashtag")
            cell.sectionLabel.text = "Tags"
            cell.sectionButton.addTarget(self, action: #selector(sectionButtonTapped(sender:)), for: .touchUpInside)
            cell.sectionButton.isHidden = false
            cell.sectionButton.tag = MealSectionViewCell.ButtonType.AddTag.rawValue
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: mealTagViewCellIdentifier, for: indexPath) as! MealTagViewCell
            cell.delegate = self
            cell.tagTitles = tagTitles
            cell.collectionView.reloadData()
            return cell
        case 5:
            let cell = tableView.dequeueReusableCell(withIdentifier: mealSectionViewCellIdentifier, for: indexPath) as! MealSectionViewCell
            cell.backgroundColor = UIColor.cyan
            cell.sectionLabel.text = "Ingredients"
            cell.sectionImageView.image = #imageLiteral(resourceName: "list")
            cell.sectionButton.addTarget(self, action: #selector(sectionButtonTapped(sender:)), for: .touchUpInside)
            cell.sectionButton.isHidden = false
            cell.sectionButton.tag = MealSectionViewCell.ButtonType.AddIngredient.rawValue
            return cell
        default:
            fatalError()
        }
    }
    
    @objc private func sectionButtonTapped(sender: UIButton) {
        if let buttonType = MealSectionViewCell.ButtonType(rawValue: sender.tag) {
            var style: InputItemView.Style
            switch buttonType {
            case .AddTag:
                style = .AddTag
            case .AddIngredient:
                style = .AddIngredient
            case .AddTip:
                style = .AddTip
            }
            let inputItemView = InputItemView(style: style)
            inputItemView.delegate = self
            
            if let keyWindow = UIApplication.shared.keyWindow {
                keyWindow.addSubview(inputItemView)
                inputItemView.show()
            }
        }
    }

}

// MARK: InputItemViewDelegate
extension MealViewController: InputItemViewDelegate {
    func done(item: String, style: InputItemView.Style) {
        switch style {
        case .AddTag:
            tagTitles.append(item)
            let indexPath = IndexPath(row: tagViewRow, section: 0)
            tableView.reloadRows(at: [indexPath], with: .none)
        default:
            return
        }
    }
}

// MARK: MealTagViewCellDelegate
extension MealViewController: MealTagViewCellDelegate {
    func didRemoveTag(tag: String) {
        if let index = tagTitles.index(of: tag) {
            tagTitles.remove(at: index)
            let indexPath = IndexPath(row: tagViewRow, section: 0)
            tableView.reloadRows(at: [indexPath], with: .none)
        }
    }
}
