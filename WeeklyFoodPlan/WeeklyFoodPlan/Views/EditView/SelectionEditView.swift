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
    func didSelect(index: Int)
    func didUnselect(index: Int)
}

class SelectionEditView: EditView {

    let maxItemsInRow = 3
    let margin:CGFloat = 8
    let gap:CGFloat = 5
    let labelHeight: CGFloat = 20
    
    var delegate: SelectionEditViewDelegate?
    private var selectionLabels = [(UILabel, Bool)]()
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
    }
    
    private func toggleLabelState(index: Int, isSelected: Bool) {
        var label = self.selectionLabels[index].0
        if isSelected {
            label.backgroundColor = UIColor.brown
        } else {
            label.backgroundColor = UIColor.green
        }
        self.selectionLabels[index].1 = isSelected
    }

    @objc private func labelTapped(gesture: UITapGestureRecognizer) {
        if let selectedLabel = gesture.view as? UILabel {
            for (index, tuple) in self.selectionLabels.enumerated() {
                if tuple.0 == selectedLabel {
                    toggleLabelState(index: index, isSelected: !tuple.1)
                    if tuple.1 {
                        delegate?.didUnselect(index: index)
                    } else {
                        delegate?.didSelect(index: index)
                    }
                }
            }
        }
    }
    
    func generate() {
        // generate labels
        
        for title in self.selectionTitles {
            let label = UILabel()
            label.text = title
            label.backgroundColor = UIColor.green
            label.textAlignment = .center
            label.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer(target: self, action: #selector(labelTapped(gesture:)))
            label.addGestureRecognizer(tap)
            self.selectionLabels.append((label, false))
        }
        // add labels to superview
        let itemsCount = CGFloat(maxItemsInRow)
        let labelWidth = (self.bounds.width - gap * (itemsCount - 1) - margin * 2) / itemsCount
        let rows = self.selectionTitles.count / maxItemsInRow + 1
        for i in 0..<rows {
            for j in 0..<maxItemsInRow {
                if (i * maxItemsInRow + j) == selectionTitles.count {
                    break
                }
                let label = selectionLabels[maxItemsInRow*i+j].0
                self.contentView.addSubview(label)
                label.snp.makeConstraints({ (make) in
                    make.width.equalTo(labelWidth)
                    make.height.equalTo(labelHeight)
                    let index = CGFloat(j)
                    make.left.equalToSuperview().offset(margin + index * labelWidth + index * gap)
                    make.top.equalToSuperview().offset(gap * CGFloat(i+1) + labelHeight * CGFloat(i))
                })
            }
        }
        
        let contentViewHeight = gap * CGFloat(rows + 1) + CGFloat(rows) * labelHeight
        // change view height
        self.contentView.snp.makeConstraints { (make) in
            make.height.equalTo(contentViewHeight)
        }
        
        self.snp.updateConstraints { (make) in
            make.height.equalTo(contentViewHeight + headerViewHeight + verticalSpacing)
        }
        
        self.updateConstraints()
    }
}
