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
    
    private func distanceBetween(pointA: CGPoint, pointB: CGPoint) -> Double {
        let distanceX = Double(pointA.x - pointB.x)
        let distanceY = Double(pointA.y - pointB.y)
        return sqrt(distanceX * distanceX + distanceY * distanceY)
    }
    
    // MARK: Public methods
    public func generate() {
        for view in self.tagViews {
            view.removeFromSuperview()
        }
        
        tagViews.removeAll()
        
        for title in self.tagTitles {
            let tagView = TagView(title: title)
            self.contentView.addSubview(tagView)
            self.tagViews.append(tagView)
        }
        
        let maxWidth = self.bounds.width - margin * 2
        var row: CGFloat = 1
        var currentMaxWidth: CGFloat = 0
        for tag in self.tagViews {
            let tagWidth = tag.tagWidth()
            if currentMaxWidth + tagWidth > maxWidth {
                row += 1
                currentMaxWidth = 0
            }
            
            tag.snp.remakeConstraints({ (make) in
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
    
    // MARK: Touch
    private var draggedTagView: TagView?
    private var originalTagView: TagView?
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self.contentView)
            for tag in self.tagViews {
                if tag.frame.contains(location) {
                    originalTagView = tag
//                    tag.isHidden = true
                    draggedTagView = TagView(title: (tag.titleLabel.text)!)
                    self.addSubview(draggedTagView!)
                    draggedTagView?.alpha = 0
                    let tagWidth = tag.tagWidth()
                    draggedTagView?.snp.makeConstraints({ (make) in
                        make.width.equalTo(tagWidth)
                        make.height.equalTo(TagView.tagHeight)
                    })
                    break
                }
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let originalTagView = originalTagView,
            let draggedTagView = draggedTagView {
            
            if distanceBetween(pointA: draggedTagView.center, pointB: originalTagView.center) > 50 {
                // remove tag and re-generate tag views
                UIView.animate(withDuration: 0.3, animations: { 
                    draggedTagView.alpha = 0
                }, completion: { (_) in
                    let title = draggedTagView.titleLabel.text!
                    draggedTagView.removeFromSuperview()
                    originalTagView.removeFromSuperview()
                    self.tagTitles.remove(at: self.tagTitles.index(of: title)!)
                    self.generate()
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
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
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
            if let touch = touches.first {
                let location = touch.location(in: self)
                draggedTagView.center = location
            }
        }

        
    }
}
