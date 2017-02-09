//
//  EditView.swift
//  WeeklyFoodPlan
//
//  Created by vulgur on 2017/2/8.
//  Copyright © 2017年 MAD. All rights reserved.
//

import UIKit
import SnapKit

class EditView: UIView {

    let headerViewHeight: CGFloat = 50
    
    var headerView: UIView
    var headerLabel: UILabel
    var headerButton: UIButton
    var contentView: UIView
    var headerIconView: UIImageView
    
    override init(frame: CGRect) {
        headerView = UIView()
        headerLabel = UILabel()
        headerIconView = UIImageView()
        headerButton = UIButton()
        contentView = UIView()

        super.init(frame: frame)
        
        self.setupSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        headerView = UIView()
        headerLabel = UILabel()
        headerIconView = UIImageView()
        headerButton = UIButton()
        contentView = UIView()
        
        super.init(coder: aDecoder)
        
        self.setupSubviews()
    }
    
    func setupSubviews() {
        self.backgroundColor = UIColor.lightGray
        
        self.headerView.addSubview(headerIconView)
        self.headerView.addSubview(headerLabel)
        self.headerView.addSubview(headerButton)
        self.addSubview(headerView)
        self.addSubview(contentView)
        
        headerView.backgroundColor = UIColor.blue
        headerView.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
            make.height.equalTo(50)
            make.top.equalToSuperview()
            make.left.equalToSuperview()
        }
        
        headerIconView.backgroundColor = UIColor.red
        headerIconView.snp.makeConstraints { (make) in
            make.height.width.equalTo(40)
            make.centerY.equalToSuperview()
            make.leftMargin.equalTo(8)
        }
        
        headerLabel.text = "TEST"
        headerLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalTo(headerIconView.snp.right).offset(10)
        }
        
        headerButton.setTitle("Click", for: .normal)
        headerButton.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.rightMargin.equalTo(-8)
        }
        
        contentView.backgroundColor = UIColor.yellow
        contentView.snp.makeConstraints { (make) in
//            make.height.equalTo(100)
            make.width.equalToSuperview()
            make.left.equalToSuperview()
            make.top.equalTo(headerView.snp.bottom).offset(3)
        }
    }
}
