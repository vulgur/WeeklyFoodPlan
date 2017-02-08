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

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        commonInit()
    }
    
    func commonInit() {
        self.headerLabel.text = "When you want to enjoy?".localized()
        self.headerIconView.image = #imageLiteral(resourceName: "clock")
        self.headerButton.isHidden = true
    }

    func labelTapped(gesture: UITapGestureRecognizer) {
        if let selectedLabel = gesture.view as? UILabel {
            print("Selected: ", selectedLabel.text ?? "unknown")
        }
        
    }
    
    func generate() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(labelTapped(gesture:)))
        for title in self.selectionTitles {
            let label = UILabel()
            label.text = title
            label.backgroundColor = UIColor.green
            label.textAlignment = .center
            label.addGestureRecognizer(tap)
            self.selectionLabels.append((label, false))
        }
        
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
    }
}
