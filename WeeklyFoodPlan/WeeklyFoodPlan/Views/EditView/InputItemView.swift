//
//  AddItemView.swift
//  WeeklyFoodPlan
//
//  Created by vulgur on 2017/2/11.
//  Copyright © 2017年 MAD. All rights reserved.
//

import UIKit

protocol InputItemViewDelegate {

    func done(item: String, style: InputItemView.Style)
}

class InputItemView: UIView {
    
    enum Style {
        case AddTag
        case AddTip
        case AddIngredient
    }
    
    private let leftMargin: CGFloat = 20
    private let topMargin: CGFloat = 80
    private let contentViewHeight: CGFloat = 200
    private let buttonMargin: CGFloat = 20
    private let textFieldVerticalMargin: CGFloat = 30
    private let screenHeight = UIScreen.main.bounds.height

    private var backgroundBlurView: UIVisualEffectView
    private var headerImageView: UIImageView
    private var headerLabel: UILabel
    private var contentView: UIView
    private var textField: UITextField
    private var hintTableView: UITableView?
    private var hintCollectionView: UICollectionView?
    private var cancelButton: UIButton
    private var doneButton: UIButton
    private var style: Style = .AddTag
    var delegate: InputItemViewDelegate?
    
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
        self.style = style
        setupSubviews()
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
            make.height.equalTo(30)
            make.width.equalToSuperview().offset(-buttonMargin * 2)
        }
        
        cancelButton.setBackgroundImage(#imageLiteral(resourceName: "button_cancel"), for: .normal)
        cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        cancelButton.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-buttonMargin)
            make.left.equalToSuperview().offset(buttonMargin)
        }
        
        doneButton.setBackgroundImage(#imageLiteral(resourceName: "button_done"), for: .normal)
        doneButton.addTarget(self, action: #selector(doneButtonTapped), for: .touchUpInside)
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
    
    // MARK: Actions
    @objc private func cancelButtonTapped() {
        hide()
        self.removeFromSuperview()
    }
    
    @objc private func doneButtonTapped() {
        if let item = textField.text {
            delegate?.done(item: item, style: self.style)
        }
        hide()
    }
}
