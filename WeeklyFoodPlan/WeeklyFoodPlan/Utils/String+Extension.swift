//
//  String+Extension.swift
//  WeeklyFoodPlan
//
//  Created by vulgur on 2017/2/9.
//  Copyright © 2017年 MAD. All rights reserved.
//

import UIKit

extension String {
    func localized(withComment comment: String = "") -> String {
        return NSLocalizedString(self, comment: comment)
    }
    
    func widthWithConstrainedHeight(height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect,
                                            options: .usesLineFragmentOrigin,
                                            attributes: [NSFontAttributeName: font],
                                            context: nil)
        return boundingBox.width
    }
    
    func trimmedString() -> String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
