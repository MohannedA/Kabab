//
//  EmptySearchView.swift
//  Kabab
//
//  Created by mac on 12/11/1439 AH.
//  Copyright © 1439 mac. All rights reserved.
//

import UIKit

class EmptySearchView: UIView {
    
    // MARK: ~ Variables
    var emptyView = UIView()
    var imageView = UIView()
    var messageLabel = UILabel()
    
    // MARK: ~ Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Set the empty view.
        emptyView = UIView(frame: frame)
        emptyView.sizeToFit()
        
        // Set image view.
        setImageView()
        
        // Set message label view.
        setMessageLabel()
        
        addSubview(emptyView)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: ~ Private Methods
    private func setImageView() {
        let imageView = UIView(frame: CGRect(origin: CGPoint(x: (self.center.x) - 250/2,y : (self.center.y) - 250/2 - 200 ), size: CGSize(width: 250, height: 250)))
        imageView.backgroundColor = .blue
        imageView.sizeToFit()
        emptyView.addSubview(imageView)
        emptyView.bringSubview(toFront: imageView)
    }
    
    private func setMessageLabel() {
        let rect = CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: 250  , height: 178))
        messageLabel = UILabel(frame: rect)
        emptyView.addSubview(messageLabel)
        emptyView.bringSubview(toFront: messageLabel)
        // Add message label constraints.
        messageLabel.snp.makeConstraints { (make) in
            make.center.equalTo(emptyView.snp.center)
        }
        // Add message label properties.
        messageLabel.text = "Result is not found"
        messageLabel.textColor = UIColor.black
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = .center;
        messageLabel.font = UIFont(name: "TrebuchetMS", size: 15)
        messageLabel.sizeToFit()
    }

}
