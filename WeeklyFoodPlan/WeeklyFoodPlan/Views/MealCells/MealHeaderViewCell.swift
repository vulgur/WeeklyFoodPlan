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
    func didToggleFavorButton()
    func didTapHeaderImageView(_ imageView: UIImageView)
}

class MealHeaderViewCell: UITableViewCell {

    @IBOutlet var headerImageView: UIImageView!
    @IBOutlet var headerLabel: UILabel!
    @IBOutlet var favorButton: UIButton!
    
    static let placeholderText = "输入美食名称".localized()
    var delegate: MealHeaderViewCellDelegate?
    private var headerTextField: UITextField = UITextField()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let tapLabel = UITapGestureRecognizer(target: self, action: #selector(headerLabelTapped))
        headerLabel.addGestureRecognizer(tapLabel)
        headerLabel.isUserInteractionEnabled = true
        headerLabel.isHidden = false
        headerImageView.isUserInteractionEnabled = true
        
        let tapImageView = UITapGestureRecognizer(target: self, action: #selector(headerImageViewTapped))
        headerImageView.addGestureRecognizer(tapImageView)
        
        favorButton.addTarget(self, action: #selector(toggleButton), for: .touchUpInside)
        headerTextField.isHidden = true
    }
    
    func setFavorButtonState(_ isFavored: Bool) {
        if isFavored {
            favorButton.setImage(#imageLiteral(resourceName: "heart"), for: .normal)
        } else {
            favorButton.setImage(#imageLiteral(resourceName: "unheart"), for: .normal)
        }
    }

    @objc private func toggleButton() {
        delegate?.didToggleFavorButton()
    }
    
    @objc private func headerImageViewTapped() {
        delegate?.didTapHeaderImageView(headerImageView)
    }
    
    @objc private func headerLabelTapped() {
        let frame = headerLabel.frame
        headerLabel.isHidden = true
        self.contentView.addSubview(headerTextField)
        headerTextField.frame = frame
        headerTextField.backgroundColor = UIColor.white
        headerTextField.textAlignment = .center
        headerTextField.delegate = self
        headerTextField.isHidden = false
        headerTextField.becomeFirstResponder()
    }
}

extension MealHeaderViewCell: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if headerLabel.text == MealHeaderViewCell.placeholderText {
            textField.text = ""
        } else {
            textField.text = headerLabel.text
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("text field should return")
        headerLabel.isHidden = false
        if let text = textField.text {
            if text.isEmpty {
                headerLabel.text = MealHeaderViewCell.placeholderText
            } else {
                headerLabel.text = text
                delegate?.didInputName(text)
            }
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("text field did end editing")
        headerLabel.isHidden = false
        if let text = textField.text {
            if text.isEmpty {
                headerLabel.text = MealHeaderViewCell.placeholderText
            } else {
                headerLabel.text = text
                delegate?.didInputName(text)
            }
        }
        textField.removeFromSuperview()
    }
}
