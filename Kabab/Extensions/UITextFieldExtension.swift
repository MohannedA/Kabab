//
//  UITextFieldExtension.swift
//  Kabab
//
//  Created by mac on 13/11/1439 AH.
//  Copyright © 1439 mac. All rights reserved.
//

import UIKit

extension UITextField {
    /*To add clear button with an image*/
    func clearButtonWithImage(_ image: UIImage) {
        let clearButton = UIButton()
        clearButton.setImage(image, for: .normal)
        clearButton.frame = CGRect(x: 0, y: 0, width: 15, height: 15)
        clearButton.contentMode = .scaleAspectFit
        clearButton.addTarget(self, action: #selector(self.clear(sender:)), for: .touchUpInside)
        self.rightView = clearButton
        self.rightViewMode = .always
    }
    /*To clear the text field*/
    @objc func clear(sender: AnyObject) {
        self.text = ""
    }
}
