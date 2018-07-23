//
//  CheckedInView.swift
//  Kabab
//
//  Created by mac on 04/11/1439 AH.
//  Copyright © 1439 mac. All rights reserved.
//

import UIKit

protocol InvitationCodeValidAndInvalidViewDelegate: class {
}

class InvitationCodeValidAndInvalidView: UIView {
    // MARK: ~ Properties
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var fullNameNameLabel: UILabel!
    @IBOutlet weak var hostedByNameLabel: UILabel!
    @IBOutlet weak var validityStatus: UILabel!
    @IBOutlet var doneImageButton: UITapGestureRecognizer!
    @IBOutlet weak var doneImage: UIImageView!
    @IBOutlet weak var mainImage: UIImageView!
    
    // MARK: ~ Variables
    weak var delegate: InvitationCodeValidAndInvalidViewDelegate?
    
    // MARK: ~ Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    // MARK: ~ Private Methods
    /*To define xib*/
    private func commonInit() {
        // Load xib.
        Bundle.main.loadNibNamed("InvitationCodeValidAndInvalidView", owner: self, options: nil)
        // Add the xib view to this view as subview.
        addSubview(contentView)
        // Make the xib view size the same as this view size.
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    
}
