//
//  TagEditView.swift
//  WeeklyFoodPlan
//
//  Created by vulgur on 2017/2/9.
//  Copyright © 2017年 MAD. All rights reserved.
//

import UIKit
import SnapKit

protocol TagEditViewDelegate {
    func didAddTag(title: String)
    func didRemoveTag(title: String)
}

class TagEditView: EditView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, InputItemViewDelegate {
    
    // MARK: Properties
    private let cellSpacing: CGFloat = 5
    private let cellHeight: CGFloat = 30
    private let cellIdentifier = "TagCell"
    private let tagFontSize: CGFloat = 11
    
    var delegate: TagEditViewDelegate?
    var tagTitles = [String]()
    private var collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
//    private var flowLayout = UICollectionViewFlowLayout()

    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        commonInit()
    }
    
    // MARK: Private methods
    private func commonInit() {
        self.headerLabel.text = "Tags".localized()
        self.headerIconView.image = #imageLiteral(resourceName: "hashtag")
        self.headerButton.setBackgroundImage(#imageLiteral(resourceName: "add_button"), for: .normal)
        self.headerButton.setBackgroundImage(#imageLiteral(resourceName: "add_button_highlight"), for: .highlighted)
        self.headerButton.addTarget(self, action: #selector(headerButtonTapped), for: .touchUpInside)
        
        let flowLayout = DGCollectionViewLeftAlignFlowLayout()
        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout)
        self.contentView.addSubview(collectionView)
        
        collectionView.register(UINib.init(nibName: cellIdentifier, bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
        collectionView.backgroundColor = UIColor.white
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePanTag(gestureRecognizer:)))
        collectionView.addGestureRecognizer(pan)
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func resizeContentView() {
        if self.tagTitles.count > 0 {
            let size = collectionView.collectionViewLayout.collectionViewContentSize
            contentView.snp.makeConstraints { (make) in
                make.size.equalTo(size)
            }
        } else {
            let size = CGSize(width: self.headerView.frame.width, height: 100)
            contentView.snp.makeConstraints { (make) in
                make.size.equalTo(size)
            }
        }
        self.updateConstraints()
    }
    
    @objc private func headerButtonTapped() {
        let styles = [InputItemView.Style.AddIngredient, InputItemView.Style.AddTag, InputItemView.Style.AddTip]
        let randomIndex = Int(arc4random_uniform(UInt32(styles.count)))
        let style = styles[randomIndex]
        let inputItemView = InputItemView(style: style)
        inputItemView.delegate = self
        if let parentView = self.superview {
            parentView.addSubview(inputItemView)
            inputItemView.show()
        }
    }
    
    private func distanceBetween(pointA: CGPoint, pointB: CGPoint) -> Double {
        let distanceX = Double(pointA.x - pointB.x)
        let distanceY = Double(pointA.y - pointB.y)
        return sqrt(distanceX * distanceX + distanceY * distanceY)
    }
    
    private func tagWidthFor(title: String) -> CGFloat {
        let font = UIFont.systemFont(ofSize: tagFontSize)
        let tagWidth = title.widthWithConstrainedHeight(height: TagView.tagHeight, font: font) + 30
        return tagWidth
    }
    
    private var draggedTagView: UIView?
    private var originalTagView: UIView?
    private var indexPathOfRemovedTag: IndexPath?
    
    @objc private func handlePanTag(gestureRecognizer: UIPanGestureRecognizer) {
        let location  = gestureRecognizer.location(in: self.collectionView)
        let movingLocation = self.collectionView.convert(location, to: self)
        if (gestureRecognizer.state == .began) {
            if let indexPathOfRemovedTag = self.collectionView.indexPathForItem(at: location) {
                print("drag start")
                self.indexPathOfRemovedTag = indexPathOfRemovedTag
                originalTagView = self.collectionView.cellForItem(at: indexPathOfRemovedTag)
                let tagTitle = tagTitles[indexPathOfRemovedTag.row]
                draggedTagView = TagView(title: tagTitle)
                self.addSubview(draggedTagView!)
                draggedTagView?.alpha = 0
                
                draggedTagView?.snp.makeConstraints({ (make) in
                    make.size.equalTo(originalTagView!)
                })

            } else {
                return
            }
        }
        
        if (gestureRecognizer.state == .changed) {
            if let originalTagView = originalTagView {
                if originalTagView.alpha > 0 {
                    UIView.animate(withDuration: 0.1) {
                        originalTagView.alpha = 0
                    }
                }
            }
            
            if let draggedTagView = draggedTagView {
                if draggedTagView.alpha < 1 {
                    UIView.animate(withDuration: 0.1, animations: {
                        draggedTagView.alpha = 1
                    })
                }
                draggedTagView.center = movingLocation
            }
        }
        
        if (gestureRecognizer.state == .ended) {
            
            if let originalTagView = self.originalTagView,
                let draggedTagView = self.draggedTagView {
                print("drag ended")
                if distanceBetween(pointA: draggedTagView.center, pointB: originalTagView.center) > 50 {
                    // remove tag and re-generate tag views
                    UIView.animate(withDuration: 0.3, animations: {
                        draggedTagView.alpha = 0
                    }, completion: { (_) in
                        draggedTagView.removeFromSuperview()
                        originalTagView.removeFromSuperview()
                        if let indexPathOfRemovedTag = self.indexPathOfRemovedTag {
                            let removedTagTitle = self.tagTitles[indexPathOfRemovedTag.row]
                            self.tagTitles.remove(at: indexPathOfRemovedTag.row)
                            self.delegate?.didRemoveTag(title: removedTagTitle)
                            self.collectionView.deleteItems(at: [indexPathOfRemovedTag])
                        }
                        self.collectionView.reloadData()
                        self.indexPathOfRemovedTag = nil
                    })
                } else {
                    UIView.animate(withDuration: 0.3, animations: {
                        let destCenter = self.contentView.convert(originalTagView.center, to: self)
                        draggedTagView.center = destCenter
                    }, completion: { (_) in
                        draggedTagView.removeFromSuperview()
                        originalTagView.alpha = 1
                    })
                }

            } else {
                return
            }
        }
    }
    
    // MARK: Public methods
    func reloadData() {
        collectionView.reloadData()
        self.layoutIfNeeded()
        resizeContentView()
    }
    
    // MARK: UICollectionViewDataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.tagTitles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! TagCell
        cell.tagLabel.text = self.tagTitles[indexPath.row]
        return cell
    }
    // MARK: UICollectionViewDelegate
    
    // MARK: UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let title = self.tagTitles[indexPath.row]
        let cellWidth = tagWidthFor(title: title)
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(5, 5, 5, 5)
    }
    
    // MARK: InputItemViewDelegate
    func done(item: String, style: InputItemView.Style) {
        if style == .AddTag {
            self.tagTitles.append(item)
            reloadData()
        }
    }
}
