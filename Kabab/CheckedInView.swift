//
//  CheckedInView.swift
//  Kabab
//
//  Created by mac on 04/11/1439 AH.
//  Copyright © 1439 mac. All rights reserved.
//

import UIKit

protocol CheckedInViewDelegate: class {
    /*To check when typing is completed*/
    func checkInvitationCode()
}

class CheckedInView: UIView, UITextFieldDelegate {
    // MARK: ~ Properties
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var fullNameNameLabel: UILabel!
    @IBOutlet weak var hostedByLabel: UILabel!
    @IBOutlet weak var hostedByNameLabel: UILabel!
    @IBOutlet var doneImageButton: UITapGestureRecognizer!
    @IBOutlet weak var doneImage: UIImageView!
    
    // MARK: ~ Variables
    weak var delegate: CheckedInViewDelegate?
    
    // MARK: ~ Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    // MARK: Actions
    @IBAction func onClickDoneImage(_ sender: UITapGestureRecognizer) {
    }
    
    
    // MARK: ~ Private Methods
    /*To define xib*/
    private func commonInit() {
        // Load xib.
        Bundle.main.loadNibNamed("CheckedInView", owner: self, options: nil)
        // Add the xib view to this view as subview.
        addSubview(contentView)
        // Make the xib view size the same as this view size.
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    
}
