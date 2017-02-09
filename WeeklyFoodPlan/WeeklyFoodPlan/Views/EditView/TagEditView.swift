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

class TagEditView: EditView {
    // MARK: Properties

    private let gap: CGFloat = 5
    private let margin: CGFloat = 8
    
    var delegate: TagEditViewDelegate?
    var tagTitles = [String]()
    private var tagViews = [TagView]()

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
    }
    
    // MARK: Public methods
    public func generate() {
        for title in self.tagTitles {
            let tagView = TagView(title: title)
            tagView.titleLabel.font = UIFont.systemFont(ofSize: TagView.tagFontSize)
            self.contentView.addSubview(tagView)
            self.tagViews.append(tagView)
        }
        
        let maxWidth = self.bounds.width - margin * 2
        var row: CGFloat = 1
        var currentMaxWidth: CGFloat = 0
        for tag in self.tagViews {
            let font = UIFont.systemFont(ofSize: TagView.tagFontSize)
            let tagWidth = tag.titleLabel.text!.widthWithConstrainedHeight(height: TagView.tagHeight, font: font) + 15
            if currentMaxWidth + tagWidth > maxWidth {
                row += 1
                currentMaxWidth = 0
            }
            
            tag.snp.makeConstraints({ (make) in
                make.width.equalTo(tagWidth)
                make.height.equalTo(TagView.tagHeight)
                make.left.equalToSuperview().offset(currentMaxWidth + margin)
                make.top.equalToSuperview().offset((row - 1)  * TagView.tagHeight + (row - 1) * (gap + 1))
            })
            currentMaxWidth += tagWidth + gap
        }
        
        
        let contentViewHeight = row * TagView.tagHeight + row * (gap + 1)
        print("Content View Height:", contentViewHeight)
        
        self.contentView.snp.makeConstraints { (make) in
            make.height.equalTo(contentViewHeight)
        }
        
        self.snp.updateConstraints { (make) in
            make.height.equalTo(contentViewHeight + headerViewHeight + verticalSpacing)
        }
        
        
        self.updateConstraints()
    }
}
