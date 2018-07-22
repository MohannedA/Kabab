//
//  UIViewExtension.swift
//  Kabab
//
//  Created by mac on 04/11/1439 AH.
//  Copyright © 1439 mac. All rights reserved.
//

import UIKit

extension UIView {
    
    // MARK: ~ Animations
    /*To animate the displaying of view from the bottom*/
    func animateShowFromBottom(completion: ((Bool) -> Void)?)  {
        UIView.animate(withDuration: 1, animations: {
            self.frame.origin.y -= self.bounds.height
        }, completion: completion)
    }
    
    /*To animate the hiding of view to the bottom*/
    func animateHideToBottom(completion: ((Bool) -> Void)?) {
        UIView.animate(withDuration: 1, animations: {
            self.frame.origin.y += self.bounds.height
        }, completion: completion)
    }
    // MARK: ~ Visual Effects
    /*To add blur effect to view*/
    func addBlurEffect(_ tag: Int) {
        // If the user hasn't disabled transparency effects, applay.
        if !UIAccessibilityIsReduceTransparencyEnabled() {
            let blurEffect = UIBlurEffect(style: .light)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            // Add the blur effect to all the view parts.
            blurEffectView.frame = self.bounds
            blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            // Give tag to the created view.
            blurEffectView.tag = tag
            self.addSubview(blurEffectView) // Dev Note: If you have more UIViews, use an insertSubview API to place it where needed.
        } else { // It is disabled.
            self.backgroundColor = .black
        }
    }
}

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
}
