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
    func animateShowFromBottom() {
        UIView.animate(withDuration: 1, animations: {
            self.frame.origin.y -= self.bounds.height
        }, completion: nil)
    }
    
    /*To animate the hiding of view to the bottom*/
    func animateHideToBottom() {
        UIView.animate(withDuration: 1, animations: {
            self.frame.origin.y += self.bounds.height
        }, completion: nil)
    }
}
