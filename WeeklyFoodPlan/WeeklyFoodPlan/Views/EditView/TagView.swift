//
//  TagView.swift
//  WeeklyFoodPlan
//
//  Created by vulgur on 2017/2/9.
//  Copyright © 2017年 MAD. All rights reserved.
//

import UIKit
import SnapKit

class TagView: UIView {
    static let tagFontSize: CGFloat = 11
    static let tagHeight: CGFloat = 20
    
    var backgroundImageView = UIImageView()
    var titleLabel = UILabel()

    init(title: String) {
        super.init(frame: CGRect.zero)
        setupSubviews()
        self.titleLabel.text = title
        self.titleLabel.font = UIFont.systemFont(ofSize: TagView.tagFontSize)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func tagWidth() -> CGFloat {
        var tagWidth: CGFloat = 0
        let font = UIFont.systemFont(ofSize: TagView.tagFontSize)
        if let title = self.titleLabel.text {
            tagWidth = title.widthWithConstrainedHeight(height: TagView.tagHeight, font: font) + 15
        }
        return tagWidth
    }
    
    private func setupSubviews() {
        self.backgroundColor = UIColor.darkGray
        self.addSubview(backgroundImageView)
        self.addSubview(titleLabel)
        
        titleLabel.textAlignment = .right
        
        backgroundImageView.image = #imageLiteral(resourceName: "tag_background")
        backgroundImageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(UIEdgeInsetsMake(0, 0, 0, 5))
        }
    }
    
}
