//
//  UIButtonExtension.swift
//  Kabab
//
//  Created by mac on 13/11/1439 AH.
//  Copyright © 1439 mac. All rights reserved.
//

import UIKit

extension UIButton {
    /*To add bottom corner radius*/
    func addBottomCornerRadius(_ radius: CGFloat) {
        self.clipsToBounds = true
        self.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        self.layer.cornerRadius = radius
    }
}
