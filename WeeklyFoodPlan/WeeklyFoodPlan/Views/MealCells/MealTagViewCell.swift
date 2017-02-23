//
//  MealTagViewCell.swift
//  WeeklyFoodPlan
//
//  Created by vulgur on 2017/2/22.
//  Copyright © 2017年 MAD. All rights reserved.
//

import UIKit

protocol MealTagViewCellDelegate {
    func didRemoveTag(tag: String)
}

class MealTagViewCell: UITableViewCell{

    @IBOutlet var collectionView: UICollectionView!
    
    let tagFontSize: CGFloat = 11
    let tagHeight: CGFloat = 30
    let cellIdentifier = "MealTagCell"
    var delegate: MealTagViewCellDelegate?
    var tagTitles = [String]()
    
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
        collectionView.frame = CGRect(x: 0, y: 0, width: self.bounds.width, height: CGFloat.leastNormalMagnitude)
        collectionView.layoutIfNeeded()
        
        return collectionView.collectionViewLayout.collectionViewContentSize
    }
    
    // MARK: Actions
    private var draggedTagView: TagView?
    private var originalTagView: MealTagCell?
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
            if let originalTagView = self.collectionView.cellForItem(at: indexPath) as? MealTagCell,
                let parentView = self.superview {
                self.originalTagView = originalTagView
                let tagTitle = tagTitles[indexPath.row]
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
                            let removedTag = self.tagTitles[indexPathOfRemovedTag.row]
                            self.tagTitles.remove(at: indexPathOfRemovedTag.row)
                            
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
//        cell.layer.shouldRasterize = true
//        cell.layer.rasterizationScale = UIScreen.main.scale
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
