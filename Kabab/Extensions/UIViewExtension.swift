//
//  UIViewExtension.swift
//  Kabab
//
//  Created by mac on 04/11/1439 AH.
//  Copyright © 1439 mac. All rights reserved.
//

import UIKit

extension UIView{
    
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
}

extension CALayer {
    
    func addBorder(edge: UIRectEdge, color: UIColor, thickness: CGFloat) {
        
        let border = CALayer()
        
        switch edge {
        case .top:
            border.frame = CGRect(x: 0, y: 0, width: frame.width, height: thickness)
            print("W >>>>>>>>> \(frame.width)")
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
