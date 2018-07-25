//
//  CheckSectionView.swift
//  Kabab
//
//  Created by mac on 12/11/1439 AH.
//  Copyright © 1439 mac. All rights reserved.
//

import UIKit

class CheckSectionView: UIView {
    

    // MARK: ~ Variables
    var checkSectionView = UIView()
    var sectionLabel = UILabel()
    
    // MARK: ~ Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Set up section view.
        checkSectionView = UIView(frame: frame)
        checkSectionView.backgroundColor = UIColor.lightGray//UIColor(red: 253.0/255.0, green: 240.0/255.0, blue: 196.0/255.0, alpha: 1)
        
        // Set up section label.
        sectionLabel = UILabel(frame: CGRect(x: 15, y: 0, width: self.bounds.width - 30, height: self.bounds.height))
        sectionLabel.font = UIFont.boldSystemFont(ofSize: 15)
        sectionLabel.textColor = UIColor.white
        
        // Add section label.
        checkSectionView.addSubview(sectionLabel)

        
        addSubview(checkSectionView)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: ~ Public Methods
    
}
