//
//  InvitationCodeView.swift
//  Kabab
//
//  Created by mac on 04/11/1439 AH.
//  Copyright © 1439 mac. All rights reserved.
//

import UIKit

class InvitationCodeView: UIView {
    // MARK: ~ Properties
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var invitationCodeTextField01: UITextField!
    @IBOutlet weak var invitationCodeTextField02: UITextField!
    @IBOutlet weak var invitationCodeTextField03: UITextField!
    @IBOutlet weak var invitationCodeTextField04: UITextField!
    @IBOutlet weak var doneButton: UIButton!
    
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
    private func commonInit() {
        // Load xib.
        Bundle.main.loadNibNamed("InvitationCodeView", owner: self, options: nil)
        // Add the xib view to this view as subview.
        addSubview(contentView)
        // Make the xib view size the same as this view size.
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }

}
