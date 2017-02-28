//
//  MealViewController.swift
//  WeeklyFoodPlan
//
//  Created by vulgur on 2017/2/22.
//  Copyright © 2017年 MAD. All rights reserved.
//

import UIKit
import RealmSwift

class MealViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    let mealHeaderViewCellIdentifier = "MealHeaderViewCell"
    let mealSectionViewCellIdentifier = "MealSectionViewCell"
    let mealOptionViewCellIdentifier = "MealOptionViewCell"
    let mealTagViewCellIdentifier = "MealTagViewCell"
    let mealListViewCellIdentifier = "MealListViewCell"
    
    let headerViewRow = 0
    let optionViewRow = 2
    let tagViewRow = 4
    let ingredientViewRow = 6
    let tipViewRow = 8
    let whenOptions = ["Breakfast", "Lunch", "Dinner"]
    
    // MARK: Meal info
    var meal: Meal?
    var tagList = [String]()
    var ingredientList = [String]()
    var tipList = [String]()
    var whenList = [String]()
    
    var isFavored = false
    var mealName: String?
    var mealImage: UIImage?
    
    // MARK: Private properties
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.isNavigationBarHidden = false
        configMeal()
        configTableView()
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        updateHeader()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func configMeal() {
        if let meal = self.meal {
            mealName = meal.name
            isFavored = meal.isFavored
            for tag in meal.tags {
                tagList.append(tag.name)
            }
            for ingredient in meal.ingredients {
                ingredientList.append(ingredient.name)
            }
            for tip in meal.tips {
                tipList.append(tip.content)
            }
            for when in meal.whenList {
                whenList.append(when)
            }
        }
    }
    
    private func configTableView() {
        tableView.register(UINib.init(nibName: mealHeaderViewCellIdentifier, bundle: nil), forCellReuseIdentifier: mealHeaderViewCellIdentifier)
        tableView.register(UINib.init(nibName: mealSectionViewCellIdentifier, bundle: nil), forCellReuseIdentifier: mealSectionViewCellIdentifier)
        tableView.register(UINib.init(nibName: mealOptionViewCellIdentifier, bundle: nil), forCellReuseIdentifier: mealOptionViewCellIdentifier)
        tableView.register(UINib.init(nibName: mealTagViewCellIdentifier, bundle: nil), forCellReuseIdentifier: mealTagViewCellIdentifier)
        tableView.register(UINib.init(nibName: mealListViewCellIdentifier, bundle: nil), forCellReuseIdentifier: mealListViewCellIdentifier)
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 50
        tableView.separatorColor = UIColor.clear
        tableView.tableFooterView = UIView()
    }
    
    private func indexPathsOfMealInfo() -> [IndexPath] {
        let headerViewIndexPath = IndexPath(row: headerViewRow, section: 0)
        let optionViewIndexPath = IndexPath(row: optionViewRow, section: 0)
        let tagViewIndexPath = IndexPath(row: tagViewRow, section: 0)
        let ingredientViewIndePath = IndexPath(row: ingredientViewRow, section: 0)
        let tipViewIndexPath = IndexPath(row: tipViewRow, section: 0)
        
        if let meal = self.meal {
            switch meal.type {
            case .eatingOut, .takeOut:
                return [headerViewIndexPath, optionViewIndexPath, tagViewIndexPath]
            case .homeCook:
                return [headerViewIndexPath, optionViewIndexPath,
                tagViewIndexPath, ingredientViewIndePath, tipViewIndexPath]
            }
        }
        return []
    }
    
    private func listOfTags() -> List<Tag> {
        let tags = List<Tag>()
        for title in tagList {
            let tag = Tag()
            tag.name = title
            tags.append(tag)
        }
        return tags
    }
    
    private func listOfIngredients() -> List<Ingredient> {
        let ingredients = List<Ingredient>()
        for title in ingredientList {
            let ingredient = Ingredient()
            ingredient.name = title
            ingredients.append(ingredient)
        }
        return ingredients
    }
    
    private func listOfTips() -> List<Tip> {
        let tips = List<Tip>()
        for title in tipList {
            let tip = Tip()
            tip.content = title
            tips.append(tip)
        }
        return tips
    }
    
    private func listOfWhenObjects() -> List<WhenObject> {
        let list = List<WhenObject>()
        for option in whenList {
            let when = WhenObject()
            when.value = option
            list.append(when)
        }
        return list
    }
    
    func updateCells() {
        tableView.reloadRows(at: indexPathsOfMealInfo(), with: .none)
    }
    
    @IBAction func saveMeal(_ sender: UIBarButtonItem) {
        
        guard let mealName = self.mealName else {
            showAlert(message: "请输入美食名称")
            return
        }
        if mealName.isEmpty {
            showAlert(message: "请输入美食名称")
            return
        }
        
        let mealToSave = Meal()
        if let originalMeal = self.meal {
            mealToSave.id = originalMeal.id
            mealToSave.typeRawValue = originalMeal.typeRawValue
        }
        mealToSave.name = mealName
        mealToSave.isFavored = isFavored
        mealToSave.whenObjects = listOfWhenObjects()
        mealToSave.tags = listOfTags()
        mealToSave.ingredients = listOfIngredients()
        mealToSave.tips = listOfTips()
        BaseManager.shared.save(object: mealToSave)
 
        _ = navigationController?.popViewController(animated: true)
    }
    
    // MARK: Private methods
    func showAlert(message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Okay", style: .cancel, handler: { (action) in
            
        })
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }
}

// MARK: UITableViewDataSource
extension MealViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let meal = self.meal {
            switch meal.type {
            case .eatingOut, .takeOut:
                return 5
            case .homeCook:
                return 9
            }
        }
        return 9
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: mealHeaderViewCellIdentifier, for: indexPath) as! MealHeaderViewCell
            cell.backgroundColor = UIColor.white 
            cell.delegate = self
            cell.headerLabel.text = mealName ?? MealHeaderViewCell.placeholderText
            cell.headerImageView.image = mealImage
            cell.setFavorButtonState(isFavored)
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
            cell.optionTitles = whenOptions
            cell.selectedOptions = whenList
            cell.delegate = self
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
            cell.tagList = tagList
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
        case 6:
            let cell = tableView.dequeueReusableCell(withIdentifier: mealListViewCellIdentifier, for: indexPath) as! MealListViewCell
            cell.delegate = self
            cell.itemType = .Ingredient
            cell.items = ingredientList
            cell.tableView.reloadData()
            return cell
        case 7:
            let cell = tableView.dequeueReusableCell(withIdentifier: mealSectionViewCellIdentifier, for: indexPath) as! MealSectionViewCell
            cell.backgroundColor = UIColor.cyan
            cell.sectionLabel.text = "Tips"
            cell.sectionImageView.image = #imageLiteral(resourceName: "tip")
            cell.sectionButton.addTarget(self, action: #selector(sectionButtonTapped(sender:)), for: .touchUpInside)
            cell.sectionButton.isHidden = false
            cell.sectionButton.tag = MealSectionViewCell.ButtonType.AddTip.rawValue
            return cell
        case 8:
            let cell = tableView.dequeueReusableCell(withIdentifier: mealListViewCellIdentifier, for: indexPath) as! MealListViewCell
            cell.delegate = self
            cell.itemType = .Tip
            cell.items = tipList
            cell.tableView.reloadData()
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
            tagList.append(item)
            
        case .AddIngredient:
            ingredientList.append(item)
            
        case .AddTip:
            tipList.append(item)
            
        }
        updateCells()
    }
}

// MARK: MealTagViewCellDelegate
extension MealViewController: MealTagViewCellDelegate {
    func didRemoveTag(tag: String) {
        if let index = tagList.index(of: tag) {
            tagList.remove(at: index)
            updateCells()
        }
    }
}

// MARK: MealListViewCellDelegate
extension MealViewController: MealListViewCellDelegate {
    func didRemoveItem(_ item: String, type: MealListViewCell.ItemType) {
        switch type {
        case .Ingredient:
            if let index = ingredientList.index(of: item) {
                ingredientList.remove(at: index)
            }
        case .Tip:
            if let index = tipList.index(of: item) {
                tipList.remove(at: index)
            }
        }
        updateCells()
    }
}

// MARK: MealHeaderViewCellDelegate
extension MealViewController: MealHeaderViewCellDelegate {
    func didInputName(_ name: String) {
        self.mealName = name
        updateCells()
    }
    func didToggleFavorButton() {
        isFavored = !isFavored
        updateCells()
    }
    func didTapHeaderImageView(_ imageView: UIImageView) {
        let alertController = UIAlertController.init(title: "选择照片", message: nil, preferredStyle: .actionSheet)
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let action = UIAlertAction.init(title: "拍照", style: .default, handler: { (_) in
                let picker = UIImagePickerController()
                picker.delegate = self
                picker.sourceType = .camera
                picker.allowsEditing = false
                self.present(picker, animated: true, completion: nil)
            })
            alertController.addAction(action)
        }
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let action = UIAlertAction.init(title: "照片", style: .default, handler: { (_) in
                let picker = UIImagePickerController()
                picker.delegate = self
                picker.sourceType = .photoLibrary
                picker.allowsEditing = false
                self.present(picker, animated: true, completion: nil)
            })
            alertController.addAction(action)
        }
        
        let cancelAction = UIAlertAction(title: "取消", style: .cancel) { (_) in
            
        }
        
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
}

// MARK: UIImagePickerControllerDelegate
extension MealViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        picker.dismiss(animated: true, completion: nil)
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.mealImage = image
            updateCells()
        }
    }
}

// MARK: MealOptionViewDelegate
extension MealViewController: MealOptionCellDelegate {
    func didAddOption(_ option: String) {
        whenList.append(option)
    }
    func didRemoveOption(_ option: String) {
        if let index = whenList.index(of: option) {
            whenList.remove(at: index)
        }
    }
}
