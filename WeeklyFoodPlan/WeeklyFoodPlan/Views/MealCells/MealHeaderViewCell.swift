//
//  MealHeaderViewCell.swift
//  WeeklyFoodPlan
//
//  Created by vulgur on 2017/2/19.
//  Copyright © 2017年 MAD. All rights reserved.
//

import UIKit
import ImagePicker

protocol MealHeaderViewCellDelegate {
    func didInputName(_ name: String)
    func didToggleFavorButton(_ isFavored: Bool)
    func didTapHeaderImageView(_ imageView: UIImageView)
}

class MealHeaderViewCell: UITableViewCell {

    @IBOutlet var headerImageView: UIImageView!
    @IBOutlet var headerLabel: UILabel!
    @IBOutlet var favorButton: UIButton!
    
    var isFavored = false
    var delegate: MealHeaderViewCellDelegate?
    private var headerTextField: UITextField = UITextField()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let tapLabel = UITapGestureRecognizer(target: self, action: #selector(headerLabelTapped))
        headerLabel.addGestureRecognizer(tapLabel)
        headerLabel.isUserInteractionEnabled = true
        headerImageView.isUserInteractionEnabled = true
        
        let tapImageView = UITapGestureRecognizer(target: self, action: #selector(headerImageViewTapped))
        headerImageView.addGestureRecognizer(tapImageView)
        
        favorButton.addTarget(self, action: #selector(toggleButton), for: .touchUpInside)
        if isFavored {
            favorButton.setImage(#imageLiteral(resourceName: "heart"), for: .normal)
        } else {
            favorButton.setImage(#imageLiteral(resourceName: "unheart"), for: .normal)
        }
    }

    @objc private func toggleButton() {
        isFavored = !isFavored
        if isFavored {
            favorButton.setImage(#imageLiteral(resourceName: "heart"), for: .normal)
        } else {
            favorButton.setImage(#imageLiteral(resourceName: "unheart"), for: .normal)
        }
        delegate?.didToggleFavorButton(isFavored)
    }
    
    @objc private func headerImageViewTapped() {
        delegate?.didTapHeaderImageView(headerImageView)
    }
    
    @objc private func headerLabelTapped() {
        let frame = headerLabel.frame
        headerLabel.isHidden = true
        self.addSubview(headerTextField)
        headerTextField.frame = frame
        headerTextField.backgroundColor = UIColor.white
        headerTextField.textAlignment = .center
        headerTextField.delegate = self
        headerTextField.becomeFirstResponder()
    }
}

extension MealHeaderViewCell: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = headerLabel.text ?? ""
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let text = textField.text {
            headerLabel.text = text
            headerLabel.isHidden = false
            textField.removeFromSuperview()
            delegate?.didInputName(text)
        }
        return true
    }
}
