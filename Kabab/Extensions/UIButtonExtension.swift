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
    
    /*To define color view as an image*/
    private func imageWithColor(color: UIColor) -> UIImage? {
        let rect = CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
    
    /*To set background color*/
    func setBackgroundColor(_ color: UIColor, for state: UIControlState) {
        self.setBackgroundImage(imageWithColor(color: color), for: state)
    }
}
