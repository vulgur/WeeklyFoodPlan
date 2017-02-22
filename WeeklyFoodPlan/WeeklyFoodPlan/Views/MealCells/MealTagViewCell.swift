//
//  MealTagViewCell.swift
//  WeeklyFoodPlan
//
//  Created by vulgur on 2017/2/22.
//  Copyright © 2017年 MAD. All rights reserved.
//

import UIKit

class MealTagViewCell: UITableViewCell{

    @IBOutlet var collectionView: UICollectionView!
    
    let tagFontSize: CGFloat = 11
    let tagHeight: CGFloat = 30
    let cellIdentifier = "MealTagCell"
    var tagTitles = ["this is a dynamic answer that should work", "Best", "Veg", " answer that should",  "Apple", "Diet", "Must Every Week", "大块肉", "尖椒土豆丝", "蝙蝠侠大战超人", "家乡捞单呢吗这位您的二位"]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        collectionView.setCollectionViewLayout(DGCollectionViewLeftAlignFlowLayout(), animated: false)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib.init(nibName: cellIdentifier, bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePan(gestureRecognizer:)))
        pan.delegate = self
        collectionView.addGestureRecognizer(pan)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
        collectionView.frame = CGRect(x: 0, y: 0, width: self.bounds.width, height: CGFloat.greatestFiniteMagnitude)
        collectionView.layoutIfNeeded()
        
        return collectionView.collectionViewLayout.collectionViewContentSize
    }
    
    // MARK: Actions
    private var draggedTagView: TagView?
    private var originalTagView: MealTagCell?
    private var indexPathOfRemovedTag: IndexPath?
    
    @objc private func handlePan(gestureRecognizer: UIPanGestureRecognizer) {
        let location  = gestureRecognizer.location(in: self.collectionView)
        
        if (gestureRecognizer.state == .began) {
            guard let indexPath = self.collectionView.indexPathForItem(at: location) else {
                print("Not in collection view")
                return
            }

            self.indexPathOfRemovedTag = indexPath
            if let originalTagView = self.collectionView.cellForItem(at: indexPath) as? MealTagCell {
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

extension MealTagViewCell: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.tagTitles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! MealTagCell
        let title = self.tagTitles[indexPath.row]
        cell.tagLabel.text = title
        return cell
    }
}

extension MealTagViewCell: UICollectionViewDelegateFlowLayout {

    // MARK: Private methods
    private func tagWidthFor(title: String) -> CGFloat {
        let font = UIFont.systemFont(ofSize: tagFontSize)
        let tagWidth = title.widthWithConstrainedHeight(height: tagHeight, font: font) + 30
        return tagWidth
    }
    // MARK: UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let title = self.tagTitles[indexPath.row]
        let tagWidth = tagWidthFor(title: title)
        return CGSize(width: tagWidth, height: tagHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(8, 8, 8, 8)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
}
