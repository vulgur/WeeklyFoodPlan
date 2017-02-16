//
//  SelectionView.swift
//  WeeklyFoodPlan
//
//  Created by vulgur on 2017/2/9.
//  Copyright © 2017年 MAD. All rights reserved.
//

import UIKit
import SnapKit

protocol SelectionEditViewDelegate {
    func didSelectItem(index: Int)
    func didDeselectItem(index: Int)
}

class SelectionEditView: EditView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    private let screenWidth = UIScreen.main.bounds.width
    private let cellSpacing: CGFloat = 8
    private let cellHeight: CGFloat = 30
    private let cellIdentifier = "SelectionCell"
    private let cellSelectedColor = UIColor.green
    private let cellDeselectedColor = UIColor.yellow
    
    private var collectionView: UICollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
    private var flowLayout = UICollectionViewFlowLayout()
    
    var delegate: SelectionEditViewDelegate?
    var selectionTitles = [String]()
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
        self.headerLabel.text = "When you want to enjoy?".localized()
        self.headerIconView.image = #imageLiteral(resourceName: "clock")
        self.headerButton.isHidden = true
        
        flowLayout.minimumLineSpacing = 8
        flowLayout.minimumInteritemSpacing = 5
        flowLayout.sectionInset = UIEdgeInsetsMake(8, 8, 8, 8)
        
        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout)
        self.contentView.addSubview(collectionView)
        collectionView.register(UINib.init(nibName: cellIdentifier, bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
        collectionView.backgroundColor = UIColor.white
        collectionView.allowsMultipleSelection = true
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func resizeContentView() {
        let size: CGSize
        if self.selectionTitles.count > 0 {
            size = collectionView.collectionViewLayout.collectionViewContentSize

        } else {
            size = CGSize(width: self.headerView.frame.width, height: 100)
        }
        contentView.snp.remakeConstraints { (make) in
            make.size.equalTo(size)
            make.top.equalTo(headerView.snp.bottom)
            make.centerX.equalToSuperview()
        }
    }
    
    // MARK: Public methods
    func reloadData() {
        collectionView.reloadData()
        self.layoutIfNeeded()
        resizeContentView()
        self.layoutIfNeeded()
        resizeToFit()
        self.layoutIfNeeded()
    }
    
    // MARK: UICollectionViewDataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.selectionTitles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! SelectionCell
        cell.titleLabel.text = self.selectionTitles[indexPath.row]
        cell.titleLabel.backgroundColor = cellDeselectedColor
        cell.layer.cornerRadius = 5
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! SelectionCell
        cell.titleLabel.backgroundColor = cellSelectedColor
        delegate?.didSelectItem(index: indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! SelectionCell
        cell.titleLabel.backgroundColor = cellDeselectedColor
        delegate?.didDeselectItem(index: indexPath.row)
    }
    // MARK: UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = (screenWidth - 4 * cellSpacing) / 3
        return CGSize(width: cellWidth, height: cellHeight)
    }
}
