//
//  CircleTextField View.swift
//  Kabab
//
//  Created by mac on 16/11/1439 AH.
//  Copyright © 1439 mac. All rights reserved.
//

import UIKit
import SnapKit

class CircleTextFieldView: UIView {
    var textField = UITextField()
    var circleView = UIView()
    var label = UILabel()
    var mainView = UIView()
    
    @IBOutlet var contentView: UIView!
    
    
    // MARK: ~ Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        //self.commonInit()
        
        mainView = UIView(frame: frame)
        
        // Set up circle view.
        circleView = UIView(frame: CGRect(x: self.center.x, y: self.center.y, width: self.bounds.width, height: self.bounds.height))
        circleView.layer.cornerRadius = circleView.bounds.width/2
        //circleView.clipsToBounds = false
        circleView.center = self.center
        circleView.backgroundColor = UIColor.clear
        circleView.layer.borderColor = UIColor.blue.cgColor
        circleView.layer.borderWidth = 5.0
        mainView.addSubview(circleView)
        
        
        // Set up label.
        label = UILabel(frame: CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: self.bounds.width, height: self.bounds.height))
        label.font = UIFont.boldSystemFont(ofSize: 50)
        label.center = self.center
        label.textAlignment = .center
        label.textColor = UIColor.black
        
        // Set up text field.
        textField = UITextField(frame: CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: self.bounds.width, height: self.bounds.height))
        textField.center = self.center
        textField.borderStyle = UITextBorderStyle.none
        textField.backgroundColor = UIColor.white
        textField.textColor = UIColor.black
        textField.isHidden = true
        mainView.addSubview(textField)
        textField.addTarget(self, action: #selector(editingChanged(_:)), for: .editingChanged)
        
        
        addSubview(mainView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //commonInit()
    }
    
    /*To set up the view when text is entered*/
    @objc private func editingChanged(_ textField: UITextField) {
        if textField.text != "" {
            circleView.removeFromSuperview()
            label.text = textField.text
            mainView.addSubview(label)
        } else {
            label.removeFromSuperview()
            mainView.addSubview(circleView)
        }
    }
    
    /*To define xib*/
    private func commonInit() {
        // Load xib.
        Bundle.main.loadNibNamed("CircleTextFieldView", owner: self, options: nil)
        // Add the xib view to this view as subview.
        addSubview(contentView)
        // Make the xib view size the same as this view size.
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    

}
