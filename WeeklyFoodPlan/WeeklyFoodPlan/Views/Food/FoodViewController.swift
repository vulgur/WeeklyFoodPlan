//
//  FoodViewController.swift
//  WeeklyFoodPlan
//
//  Created by vulgur on 2017/2/22.
//  Copyright © 2017年 MAD. All rights reserved.
//

import UIKit
import RealmSwift

class FoodViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    @IBOutlet var deleteButton: UIButton!
    let foodHeaderViewCellIdentifier = "FoodHeaderViewCell"
    let foodSectionViewCellIdentifier = "FoodSectionViewCell"
    let foodOptionViewCellIdentifier = "FoodOptionViewCell"
    let foodTagViewCellIdentifier = "FoodTagViewCell"
    let foodListViewCellIdentifier = "FoodViewListViewCell"
    
    let headerViewRow = 0
    let optionViewRow = 2
    let tagViewRow = 4
    let ingredientViewRow = 6
    let tipViewRow = 8
    let whenOptions = ["Breakfast", "Lunch", "Dinner"]
    
    // MARK: Food info
    var food: Food?
    var foodType  = Food.FoodType.homeCook
    var tagList = [String]()
    var ingredientList = [String]()
    var tipList = [String]()
    var whenList = [String]()
    
    var isFavored = false
    var foodName: String?
    var foodImage: UIImage?
    
    // MARK: Private properties
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.isNavigationBarHidden = false
        configFood()
        configSubviews()
        tableView.reloadData()
        
        if food != nil {
            navigationItem.title = "修改美食".localized()
        } else {
            navigationItem.title = "新增美食".localized()
        }
        navigationController?.navigationBar.backItem?.title = ""
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
    
    private func configFood() {
        if let food = self.food {
            foodName = food.name
            isFavored = food.isFavored
            for tag in food.tags {
                tagList.append(tag.name)
            }
            for ingredient in food.ingredients {
                ingredientList.append(ingredient.name)
            }
            for tip in food.tips {
                tipList.append(tip.content)
            }
            for when in food.whenList {
                whenList.append(when)
            }
        }
    }
    
    private func configSubviews() {
        // table view
        tableView.register(UINib.init(nibName: foodHeaderViewCellIdentifier, bundle: nil), forCellReuseIdentifier: foodHeaderViewCellIdentifier)
        tableView.register(UINib.init(nibName: foodSectionViewCellIdentifier, bundle: nil), forCellReuseIdentifier: foodSectionViewCellIdentifier)
        tableView.register(UINib.init(nibName: foodOptionViewCellIdentifier, bundle: nil), forCellReuseIdentifier: foodOptionViewCellIdentifier)
        tableView.register(UINib.init(nibName: foodTagViewCellIdentifier, bundle: nil), forCellReuseIdentifier: foodTagViewCellIdentifier)
        tableView.register(UINib.init(nibName: foodListViewCellIdentifier, bundle: nil), forCellReuseIdentifier: foodListViewCellIdentifier)
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 40
        tableView.separatorColor = UIColor.clear
        tableView.tableFooterView = UIView()
        
        // delete button
        if food == nil {
            deleteButton.isHidden = true
        } else {
            deleteButton.isHidden = false
        }
    }
    
    private func indexPathsOfFoodInfo() -> [IndexPath] {
        let headerViewIndexPath = IndexPath(row: headerViewRow, section: 0)
        let optionViewIndexPath = IndexPath(row: optionViewRow, section: 0)
        let tagViewIndexPath = IndexPath(row: tagViewRow, section: 0)
        let ingredientViewIndePath = IndexPath(row: ingredientViewRow, section: 0)
        let tipViewIndexPath = IndexPath(row: tipViewRow, section: 0)
        
        
        switch foodType {
        case .eatingOut, .takeOut:
            return [headerViewIndexPath, optionViewIndexPath, tagViewIndexPath]
        case .homeCook:
            return [headerViewIndexPath, optionViewIndexPath,
            tagViewIndexPath, ingredientViewIndePath, tipViewIndexPath]
        }
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
        tableView.reloadRows(at: indexPathsOfFoodInfo(), with: .none)
    }
    
    @IBAction func saveFood(_ sender: UIBarButtonItem) {
        
        guard let foodName = self.foodName else {
            showAlert(message: "请输入美食名称")
            return
        }
        if foodName.isEmpty {
            showAlert(message: "请输入美食名称")
            return
        }
        
        let foodToSave = Food()
        if let originalFood = self.food {
            foodToSave.id = originalFood.id
            foodToSave.typeRawValue = originalFood.typeRawValue
        } else {
            foodToSave.typeRawValue = foodType.rawValue
        }
        foodToSave.name = foodName
        foodToSave.isFavored = isFavored
        foodToSave.whenObjects = listOfWhenObjects()
        foodToSave.tags = listOfTags()
        foodToSave.ingredients = listOfIngredients()
        foodToSave.tips = listOfTips()
        BaseManager.shared.save(object: foodToSave)
 
        _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func deleteFoodButtonTapped(_ sender: UIButton) {
        let message = "确定要删除吗？".localized()
        let deleteTitle = "删除".localized()
        let cancelTitle = "取消".localized()
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let deleteAction = UIAlertAction(title: deleteTitle, style: .destructive) { [unowned self] (action) in
            if let food = self.food {
                BaseManager.shared.delete(object: food)
                _ = self.navigationController?.popViewController(animated: true)
            }
        }
        let cancelAction = UIAlertAction(title: cancelTitle, style: .cancel, handler: nil)
        alertController.addAction(deleteAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)

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
extension FoodViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch foodType {
        case .eatingOut, .takeOut:
            return 5
        case .homeCook:
            return 9
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: foodHeaderViewCellIdentifier, for: indexPath) as! FoodHeaderViewCell
            cell.backgroundColor = UIColor.white 
            cell.delegate = self
            if foodName == nil || (foodName?.isEmpty)! {
                cell.headerLabel.text = FoodHeaderViewCell.placeholderText
            } else {
                cell.headerLabel.text = foodName
            }
            
            cell.headerImageView.image = foodImage
            cell.setFavorButtonState(isFavored)
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: foodSectionViewCellIdentifier, for: indexPath) as! FoodSectionViewCell
            cell.backgroundColor = UIColor.cyan
            cell.sectionImageView.image = #imageLiteral(resourceName: "clock")
            cell.sectionLabel.text = "When do you want to enjoy?"
            cell.sectionButton.isHidden = true
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: foodOptionViewCellIdentifier, for: indexPath) as! FoodOptionViewCell
            cell.optionTitles = whenOptions
            cell.selectedOptions = whenList
            cell.delegate = self
            cell.collectionView.reloadData()
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: foodSectionViewCellIdentifier, for: indexPath) as! FoodSectionViewCell
            cell.backgroundColor = UIColor.cyan
            cell.sectionImageView.image = #imageLiteral(resourceName: "hashtag")
            cell.sectionLabel.text = "Tags"
            cell.sectionButton.addTarget(self, action: #selector(sectionButtonTapped(sender:)), for: .touchUpInside)
            cell.sectionButton.isHidden = false
            cell.sectionButton.tag = FoodSectionViewCell.ButtonType.AddTag.rawValue
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: foodTagViewCellIdentifier, for: indexPath) as! FoodTagViewCell
            cell.delegate = self
            cell.tagList = tagList
            cell.collectionView.reloadData()
            return cell
        case 5:
            let cell = tableView.dequeueReusableCell(withIdentifier: foodSectionViewCellIdentifier, for: indexPath) as! FoodSectionViewCell
            cell.backgroundColor = UIColor.cyan
            cell.sectionLabel.text = "Ingredients"
            cell.sectionImageView.image = #imageLiteral(resourceName: "list")
            cell.sectionButton.addTarget(self, action: #selector(sectionButtonTapped(sender:)), for: .touchUpInside)
            cell.sectionButton.isHidden = false
            cell.sectionButton.tag = FoodSectionViewCell.ButtonType.AddIngredient.rawValue
            return cell
        case 6:
            let cell = tableView.dequeueReusableCell(withIdentifier: foodListViewCellIdentifier, for: indexPath) as! FoodViewListViewCell
            cell.delegate = self
            cell.itemType = .Ingredient
            cell.items = ingredientList
            cell.tableView.reloadData()
            return cell
        case 7:
            let cell = tableView.dequeueReusableCell(withIdentifier: foodSectionViewCellIdentifier, for: indexPath) as! FoodSectionViewCell
            cell.backgroundColor = UIColor.cyan
            cell.sectionLabel.text = "Tips"
            cell.sectionImageView.image = #imageLiteral(resourceName: "tip")
            cell.sectionButton.addTarget(self, action: #selector(sectionButtonTapped(sender:)), for: .touchUpInside)
            cell.sectionButton.isHidden = false
            cell.sectionButton.tag = FoodSectionViewCell.ButtonType.AddTip.rawValue
            return cell
        case 8:
            let cell = tableView.dequeueReusableCell(withIdentifier: foodListViewCellIdentifier, for: indexPath) as! FoodViewListViewCell
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
        if let buttonType = FoodSectionViewCell.ButtonType(rawValue: sender.tag) {
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
extension FoodViewController: InputItemViewDelegate {
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

// MARK: FoodTagViewCellDelegate
extension FoodViewController: FoodTagViewCellDelegate {
    func didRemoveTag(tag: String) {
        if let index = tagList.index(of: tag) {
            tagList.remove(at: index)
            updateCells()
        }
    }
}

// MARK: FoodViewListViewCellDelegate
extension FoodViewController: FoodViewListViewCellDelegate {
    func didRemoveItem(_ item: String, type: FoodViewListViewCell.ItemType) {
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

// MARK: FoodHeaderViewCellDelegate
extension FoodViewController: FoodHeaderViewCellDelegate {
    func didInputName(_ name: String) {
        self.foodName = name
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
extension FoodViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        picker.dismiss(animated: true, completion: nil)
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.foodImage = image
            updateCells()
        }
    }
}

// MARK: FoodOptionViewDelegate
extension FoodViewController: FoodOptionCellDelegate {
    func didAddOption(_ option: String) {
        whenList.append(option)
    }
    func didRemoveOption(_ option: String) {
        if let index = whenList.index(of: option) {
            whenList.remove(at: index)
        }
    }
}
