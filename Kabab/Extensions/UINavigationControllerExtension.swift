//
//  UINavigationControllerExtension.swift
//  Kabab
//
//  Created by mac on 10/11/1439 AH.
//  Copyright © 1439 mac. All rights reserved.
//

import Foundation
import UIKit

extension UINavigationController {
    func addTranslucentEffect() {
        self.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationBar.shadowImage = UIImage()
        self.navigationBar.isTranslucent = true
        self.view.backgroundColor = .clear
    }
}
