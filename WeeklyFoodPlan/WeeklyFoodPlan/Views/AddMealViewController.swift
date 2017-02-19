//
//  AddMealViewController.swift
//  WeeklyFoodPlan
//
//  Created by vulgur on 2017/2/9.
//  Copyright © 2017年 MAD. All rights reserved.
//

import UIKit

class AddMealViewController: UIViewController {
    @IBOutlet var collectionView: UICollectionView!

    let mealHeaderViewCellIdentifier = "MealHeaderViewCell"
    let mealSectionViewCellIdentifier = "MealSectionViewCell"
    let mealTagViewCellIdentifier = "MealTagViewCell"
    let mealOptionViewCellIdentifier = "MealOptionViewCell"
    
    let screenWidth = UIScreen.main.bounds.width
    let tagFontSize: CGFloat = 11
    let headerHeight: CGFloat = 175
    let sectionHeight: CGFloat = 40
    let optionHeight: CGFloat = 30
    let tagHeight: CGFloat = 30
    
    let cellSelectedColor = UIColor.green
    let cellDeselectedColor = UIColor.yellow
    
    var selectedIndex = [Int]()
    var selectionTitles = ["Breakfast", "Lunch", "Dinner"]
    var tagTitles = ["this is a dynamic answer that should work", "Best", "Veg", " answer that should",  "Apple", "Diet", "Must Every Week", "大块肉", "尖椒土豆丝", "蝙蝠侠大战超人", "家乡捞单呢吗这位您的二位"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.setCollectionViewLayout(DGCollectionViewLeftAlignFlowLayout(), animated: false)
        collectionView.register(UINib.init(nibName: mealHeaderViewCellIdentifier, bundle: nil), forCellWithReuseIdentifier: mealHeaderViewCellIdentifier)
        collectionView.register(UINib.init(nibName: mealSectionViewCellIdentifier, bundle: nil), forCellWithReuseIdentifier: mealSectionViewCellIdentifier)
        collectionView.register(UINib.init(nibName: mealTagViewCellIdentifier, bundle: nil), forCellWithReuseIdentifier: mealTagViewCellIdentifier)
        collectionView.register(UINib.init(nibName: mealOptionViewCellIdentifier, bundle: nil), forCellWithReuseIdentifier: mealOptionViewCellIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePanTag(gestureRecognizer:)))
        collectionView.addGestureRecognizer(pan)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: TagEditViewDelegate
    
    func didAddTag(title: String) {
        self.tagTitles.append(title)
    }
    
    func didRemoveTag(title: String) {
        if let index = tagTitles.index(of: title) {
            tagTitles.remove(at: index)
        }
    }
    
    // MARK: SelectionEditViewDelegate
    func didSelectItem(index: Int) {
        selectedIndex.append(index)
    }
    
    func didDeselectItem(index: Int) {
        if let removedItemIndex = selectedIndex.index(of: index) {
            selectedIndex.remove(at: removedItemIndex)
        }
    }
    
    // MARK: Private methods
    private var draggedTagView: TagView?
    private var originalTagView: MealTagViewCell?
    private var indexPathOfRemovedTag: IndexPath?
    
    @objc private func handlePanTag(gestureRecognizer: UIPanGestureRecognizer) {
        let location  = gestureRecognizer.location(in: self.collectionView)

        if (gestureRecognizer.state == .began) {
            guard let indexPath = self.collectionView.indexPathForItem(at: location) else {
                print("Not in collection view")
                return
            }
            if indexPath.section != 4 {
                return
            }
            self.indexPathOfRemovedTag = indexPath
            if let originalTagView = self.collectionView.cellForItem(at: indexPath) as? MealTagViewCell {
                self.originalTagView = originalTagView
                let tagTitle = tagTitles[indexPath.row]
                draggedTagView = TagView(title: tagTitle)
                self.collectionView.addSubview(draggedTagView!)
                draggedTagView?.alpha = 0
                draggedTagView?.snp.makeConstraints({ (make) in
                    make.size.equalTo(originalTagView)
                })
            }
    
        }
        if (gestureRecognizer.state == .changed) {
            if let originalTagView = originalTagView {
                if originalTagView.alpha > 0 {
                    originalTagView.alpha = 0
                }
            }
            
            if let draggedTagView = draggedTagView {
                if draggedTagView.alpha < 1 {
                    draggedTagView.alpha = 1
                }
                draggedTagView.center = location
            }
        }
        
        if (gestureRecognizer.state == .ended) {
            if let originalTagView = self.originalTagView,
                let draggedTagView = self.draggedTagView {
                if distanceBetween(pointA: draggedTagView.center, pointB: originalTagView.center) > 50 {
                    // remove tag and re-generate tag views
                    UIView.animate(withDuration: 0.3, animations: {
                        draggedTagView.alpha = 0
                    }, completion: { (_) in
                        draggedTagView.removeFromSuperview()
                        originalTagView.removeFromSuperview()
                        if let indexPathOfRemovedTag = self.indexPathOfRemovedTag {
                            self.tagTitles.remove(at: indexPathOfRemovedTag.row)
                            self.collectionView.deleteItems(at: [indexPathOfRemovedTag])
                        }
                        self.collectionView.reloadData()
                        self.indexPathOfRemovedTag = nil
                    })
                } else {
                    UIView.animate(withDuration: 0.3, animations: {
                        draggedTagView.center = originalTagView.center
                    }, completion: { (_) in
                        draggedTagView.removeFromSuperview()
                        originalTagView.alpha = 1
                    })
                }
                
            } else {
                return
            }
            self.draggedTagView = nil
            self.originalTagView = nil
        }
    }

    private func distanceBetween(pointA: CGPoint, pointB: CGPoint) -> Double {
        let distanceX = Double(pointA.x - pointB.x)
        let distanceY = Double(pointA.y - pointB.y)
        return sqrt(distanceX * distanceX + distanceY * distanceY)
    }
}

extension AddMealViewController: InputItemViewDelegate {
    func done(item: String, style: InputItemView.Style) {
        switch style {
        case .AddTag:
            self.tagTitles.append(item)
            self.collectionView.reloadData()
        default:
            fatalError()
        }
    }
}

extension AddMealViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 2 {
            return self.selectionTitles.count
        } else if section == 4 {
            return self.tagTitles.count
        } else {
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: mealHeaderViewCellIdentifier, for: indexPath) as! MealHeaderViewCell
            cell.backgroundColor = UIColor.lightGray
            cell.headerLabel.text = "Big Mac"
            cell.headerImageView.image = #imageLiteral(resourceName: "hamburger")
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: mealSectionViewCellIdentifier, for: indexPath) as! MealSectionViewCell
            cell.backgroundColor = UIColor.cyan
            cell.sectionImageView.image = #imageLiteral(resourceName: "clock")
            cell.sectionLabel.text = "When do you want to enjoy?"
            cell.sectionButton.isHidden = true
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: mealOptionViewCellIdentifier, for: indexPath) as! MealOptionViewCell
            let title = self.selectionTitles[indexPath.row]
            cell.optionLabel.text = title
            cell.backgroundColor = UIColor.green
            return cell
        case 3:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: mealSectionViewCellIdentifier, for: indexPath) as! MealSectionViewCell
            cell.backgroundColor = UIColor.cyan
            cell.sectionImageView.image = #imageLiteral(resourceName: "hashtag")
            cell.sectionLabel.text = "Tags"
            cell.sectionButton.addTarget(self, action: #selector(addTagButtonTapped), for: .touchUpInside)
            return cell
        case 4:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: mealTagViewCellIdentifier, for: indexPath) as! MealTagViewCell
            let title = self.tagTitles[indexPath.row]
            cell.tagLabel.text = title
            return cell
        case 5:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: mealSectionViewCellIdentifier, for: indexPath) as! MealSectionViewCell
            cell.backgroundColor = UIColor.cyan
            cell.sectionLabel.text = "Ingredients"
            cell.sectionImageView.image = #imageLiteral(resourceName: "list")
            cell.sectionButton.addTarget(self, action: #selector(addIngredientButtonTapped), for: .touchUpInside)
            return cell
        default:
            fatalError()
        }
    }
    
    // MARK: Actions
    private func show(inputItemView: InputItemView) {
        if let keyWindow = UIApplication.shared.keyWindow {
            keyWindow.addSubview(inputItemView)
            inputItemView.show()
        }
    }
    @objc private func addTagButtonTapped() {
        let style = InputItemView.Style.AddTag
        let inputItemView = InputItemView(style: style)
        inputItemView.delegate = self
        
        show(inputItemView: inputItemView)
    }
    
    @objc private func addIngredientButtonTapped() {
        let inputItemView = InputItemView(style: .AddIngredient)
        inputItemView.delegate = self
        
        show(inputItemView: inputItemView)
    }
}

extension AddMealViewController: UICollectionViewDelegate {
    
}

extension AddMealViewController: UICollectionViewDelegateFlowLayout {
    // MARK: Private methods
    private func tagWidthFor(title: String) -> CGFloat {
        let font = UIFont.systemFont(ofSize: tagFontSize)
        let tagWidth = title.widthWithConstrainedHeight(height: tagHeight, font: font) + 30
        return tagWidth
    }
    // MARK: UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.section {
        case 0:
            return CGSize(width: screenWidth, height: headerHeight)
        case 1:
            return CGSize(width: screenWidth, height: sectionHeight)
        case 2:
            return CGSize(width: (screenWidth - 8*4)/3, height: optionHeight)
        case 3:
            return CGSize(width: screenWidth, height: sectionHeight)
        case 4:
            let title = self.tagTitles[indexPath.row]
            let tagWidth = tagWidthFor(title: title)
            return CGSize(width: tagWidth, height: tagHeight)
        case 5:
            return CGSize(width: screenWidth, height: sectionHeight)
        default:
            fatalError()
        }
//        let title = self.tagTitles[indexPath.row]
//        let cellWidth = tagWidthFor(title: title)
//        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if section == 2 {
            return UIEdgeInsetsMake(8, 8, 8, 8)
        }
        if section == 4 {
            return UIEdgeInsetsMake(8, 8, 8, 8)
        }
        return UIEdgeInsets.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if section == 2 {
            return 8
        } else if section == 4 {
            return 8
        }
        return 0
    }
}
