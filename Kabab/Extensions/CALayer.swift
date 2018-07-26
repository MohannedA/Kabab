//
//  CALayer.swift
//  Kabab
//
//  Created by mac on 13/11/1439 AH.
//  Copyright © 1439 mac. All rights reserved.
//

import UIKit

extension CALayer {
    /*To add border to one side in view*/
    func addBorder(edge: UIRectEdge, color: UIColor, thickness: CGFloat) {
        
        let border = CALayer()
        
        switch edge {
        case .top:
            border.frame = CGRect(x: 0, y: 0, width: frame.width, height: thickness)
        case .bottom:
            border.frame = CGRect(x: 0, y: frame.height - thickness, width: frame.width, height: thickness)
        case .left:
            border.frame = CGRect(x: 0, y: 0, width: thickness, height: frame.height)
        case .right:
            border.frame = CGRect(x: frame.width - thickness, y: 0, width: thickness, height: frame.height)
        default:
            break
        }
        
        border.backgroundColor = color.cgColor;
        
        addSublayer(border)
    }
    
    /*To add border to bottom side in view*/
    func addShadowBottomBorder(color: UIColor) {
        self.backgroundColor = UIColor.white.cgColor
        self.masksToBounds = false
        self.shadowColor = color.cgColor
        self.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.shadowOpacity = 1.0
        self.shadowRadius = 0.0
    }
}
