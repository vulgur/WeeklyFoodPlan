//
//  FoodTagViewCell.swift
//  WeeklyFoodPlan
//
//  Created by vulgur on 2017/2/22.
//  Copyright © 2017年 MAD. All rights reserved.
//

import UIKit

protocol FoodTagViewCellDelegate {
    func didRemoveTag(tag: String)
}

class FoodTagViewCell: UITableViewCell{

    @IBOutlet var collectionView: UICollectionView!
    
    let tagFontSize: CGFloat = 11
    let tagHeight: CGFloat = 30
    let cellIdentifier = "FoodTagCell"
    var delegate: FoodTagViewCellDelegate?
    var tagList = [String]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        collectionView.setCollectionViewLayout(DGCollectionViewLeftAlignFlowLayout(), animated: false)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib.init(nibName: cellIdentifier, bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
        collectionView.isScrollEnabled = false
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePan(gestureRecognizer:)))
        pan.delegate = self
        collectionView.addGestureRecognizer(pan)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
        if tagList.count > 0 {
            collectionView.frame = CGRect(x: 0, y: 0, width: self.bounds.width, height: CGFloat.leastNormalMagnitude)
            collectionView.layoutIfNeeded()
            return collectionView.collectionViewLayout.collectionViewContentSize
        } else {
            return CGSize(width: self.bounds.width, height: 50)
        }
    }
    
    // MARK: Actions
    private var draggedTagView: TagView?
    private var originalTagView: FoodTagCell?
    private var indexPathOfRemovedTag: IndexPath?
    private let maxDraggingDistance: Double = 80
    
    @objc private func handlePan(gestureRecognizer: UIPanGestureRecognizer) {
        let location  = gestureRecognizer.location(in: self.collectionView)
        switch gestureRecognizer.state {
        case .began:
            guard let indexPath = self.collectionView.indexPathForItem(at: location) else {
                print("Not in collection view")
                return
            }
            
            self.indexPathOfRemovedTag = indexPath
            if let originalTagView = self.collectionView.cellForItem(at: indexPath) as? FoodTagCell,
                let parentView = self.superview {
                self.originalTagView = originalTagView
                let tagTitle = self.tagList[indexPath.row]
                draggedTagView = TagView(title: tagTitle)
                parentView.addSubview(draggedTagView!)
                draggedTagView?.alpha = 0
                draggedTagView?.snp.makeConstraints({ (make) in
                    make.size.equalTo(originalTagView)
                })
            }
        case .changed:
            if let originalTagView = originalTagView {
                if originalTagView.alpha > 0 {
                    originalTagView.alpha = 0
                }
            }
            
            if let draggedTagView = draggedTagView,
                let parentView = self.superview {
                if draggedTagView.alpha < 1 {
                    draggedTagView.alpha = 1
                }
                let convertedLocation = collectionView.convert(location, to: parentView)
                draggedTagView.center = convertedLocation
            }
        case .ended:
            if let originalTagView = self.originalTagView,
                let draggedTagView = self.draggedTagView {
                
                let convertedCenter = collectionView.convert(originalTagView.center, to: self.superview)
                if distanceBetween(pointA: draggedTagView.center, pointB: convertedCenter) > maxDraggingDistance {
                    // remove tag and re-generate tag views
                    UIView.animate(withDuration: 0.3, animations: {
                        draggedTagView.alpha = 0
                    }, completion: { (_) in
                        draggedTagView.removeFromSuperview()
                        originalTagView.removeFromSuperview()
                        if let indexPathOfRemovedTag = self.indexPathOfRemovedTag {
                            let removedTag = self.tagList[indexPathOfRemovedTag.row]
                            self.tagList.remove(at: indexPathOfRemovedTag.row)
                            
                            self.collectionView.performBatchUpdates({ 
                                self.collectionView.deleteItems(at: [indexPathOfRemovedTag])
                            }, completion: { (_) in
                                self.delegate?.didRemoveTag(tag: removedTag)
                            })
                            
                        }
                        self.collectionView.reloadData()
                        self.layoutIfNeeded()
                        self.indexPathOfRemovedTag = nil
                    })
                } else {
                    UIView.animate(withDuration: 0.3, animations: {
                        draggedTagView.center = convertedCenter
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
        default:
            return
        }
    }
    
    private func distanceBetween(pointA: CGPoint, pointB: CGPoint) -> Double {
        let distanceX = Double(pointA.x - pointB.x)
        let distanceY = Double(pointA.y - pointB.y)
        return sqrt(distanceX * distanceX + distanceY * distanceY)
    }
}

extension FoodTagViewCell: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.tagList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! FoodTagCell
        let title = self.tagList[indexPath.row]
        cell.tagLabel.text = title
//        cell.layer.shouldRasterize = true
//        cell.layer.rasterizationScale = UIScreen.main.scale
        return cell
    }
}

// MARK: UICollectionViewDelegateFlowLayout
extension FoodTagViewCell: UICollectionViewDelegateFlowLayout {


}
