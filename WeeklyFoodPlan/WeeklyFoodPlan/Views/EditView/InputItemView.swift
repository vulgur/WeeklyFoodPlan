//
//  AddItemView.swift
//  WeeklyFoodPlan
//
//  Created by vulgur on 2017/2/11.
//  Copyright © 2017年 MAD. All rights reserved.
//

import UIKit

protocol InputItemViewDelegate {
    
    func cancel()
    func done(item: String)
}

class InputItemView: UIView {
    
    enum Style {
        case AddTag
        case AddTip
    }
    
    private let leftMargin: CGFloat = 20
    private let topMargin: CGFloat = 100
    private let contentViewHeight: CGFloat = 200
    private let buttonMargin: CGFloat = 20
    private let textFieldVerticalMargin: CGFloat = 30
    private let screenHeight = UIScreen.main.bounds.height

    var backgroundBlurView: UIVisualEffectView
    var headerImageView: UIImageView
    var headerLabel: UILabel
    var contentView: UIView
    var textField: UITextField
    var cancelButton: UIButton
    var doneButton: UIButton
    var style: Style = .AddTag
    var delegat: UITextInputDelegate?
    
    init(style: Style) {
        let blurEffect = UIBlurEffect(style: .extraLight)
        backgroundBlurView = UIVisualEffectView(effect: blurEffect)
        headerImageView = UIImageView()
        headerLabel = UILabel()
        contentView = UIView()
        textField = UITextField()
        cancelButton = UIButton()
        doneButton = UIButton()
        
        let screenRect = UIScreen.main.bounds
        super.init(frame: screenRect)
        
        setupSubviews()
        self.style = style
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupSubviews() {
//        self.alpha = 0
        self.addSubview(backgroundBlurView)
        headerImageView.addSubview(headerLabel)
        contentView.addSubview(headerImageView)
        contentView.addSubview(textField)
        contentView.addSubview(cancelButton)
        contentView.addSubview(doneButton)
        self.addSubview(contentView)
        
        
        backgroundBlurView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hide))
        backgroundBlurView.addGestureRecognizer(tapGesture)
        
        let contentViewWidth = UIScreen.main.bounds.width - leftMargin * 2
        contentView.backgroundColor = UIColor.white
        contentView.layer.cornerRadius = 6
        contentView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(topMargin)
            make.width.equalTo(contentViewWidth)
            make.height.equalTo(contentViewHeight)
            make.centerX.equalToSuperview()
        }
        
        headerImageView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(contentView.snp.top)
        }
        
        headerLabel.textAlignment = .center
        headerLabel.snp.makeConstraints { (make) in
            make.centerWithinMargins.equalTo(0)
        }
        
        textField.backgroundColor = UIColor.lightGray
        textField.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.width.equalToSuperview().offset(-buttonMargin * 2)
        }
        
        cancelButton.setBackgroundImage(#imageLiteral(resourceName: "button_cancel"), for: .normal)
        
        cancelButton.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-buttonMargin)
            make.left.equalToSuperview().offset(buttonMargin)
        }
        
        doneButton.setBackgroundImage(#imageLiteral(resourceName: "button_done"), for: .normal)
        
        doneButton.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-buttonMargin)
            make.right.equalToSuperview().offset(-buttonMargin)
        }
        
        switch self.style {
        case .AddTag:
            headerImageView.image = #imageLiteral(resourceName: "title_tag")
            headerLabel.text = "TAG"
        default:
            headerImageView.image = #imageLiteral(resourceName: "title_tip")
            headerLabel.text = "TIP"
        }
    }
    
    @objc private func hide() {
        UIView.animate(withDuration: 0.3, animations: { 
            self.frame.origin.y = self.screenHeight
        }) { (_) in
            self.removeFromSuperview()
        }
    }
    
    // MARK: Public methods
    func show() {
        
        self.frame.origin.y = screenHeight
        UIView.animate(withDuration: 0.3) { 
            self.frame.origin.y = 0
        }
    }
}
