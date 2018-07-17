//
//  InvitationCodeView.swift
//  Kabab
//
//  Created by mac on 04/11/1439 AH.
//  Copyright © 1439 mac. All rights reserved.
//

import UIKit

protocol InvitationCodeViewDelegate: class {
    /*To check when typing is completed*/
    func checkInvitationCode()
}

class InvitationCodeView: UIView, UITextFieldDelegate {
    // MARK: ~ Properties
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var invitationCodeTextField01: UITextField!
    @IBOutlet weak var invitationCodeTextField02: UITextField!
    @IBOutlet weak var invitationCodeTextField03: UITextField!
    @IBOutlet weak var invitationCodeTextField04: UITextField!
    
    // MARK: ~ Variables
    weak var delegate: InvitationCodeViewDelegate?
    var invitationCodeString = ""
    
    // MARK: ~ Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
        
        // Set up invitation code text fields delegates.
        invitationCodeTextField01.delegate = self
        invitationCodeTextField02.delegate = self
        invitationCodeTextField03.delegate = self
        invitationCodeTextField04.delegate = self
        
        // Define radius for the content view.
        contentView.layer.cornerRadius = 50
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    // MARK: TextField Delegate Methods
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if ((textField.text?.count)! < 1) && (string.count > 0) { // If the responder goes forward.
            switch textField {
            case invitationCodeTextField01:
                invitationCodeTextField02.becomeFirstResponder()
            case invitationCodeTextField02:
                invitationCodeTextField03.becomeFirstResponder()
            case invitationCodeTextField03:
                invitationCodeTextField04.becomeFirstResponder()
            case invitationCodeTextField04:
                invitationCodeTextField04.resignFirstResponder()
            default:
                break
            }
            // Enter the string in the text field.
            textField.text = string
            invitationCodeString += string
            if invitationCodeString.count == 4 { // 4 is the number of text fields.
                delegate?.checkInvitationCode()
            }
            return false
        } else if ((textField.text?.count)! >= 1) && (string.count == 0) { // If the responder goes backword(delete).
            switch textField {
            case invitationCodeTextField02:
                invitationCodeTextField01.becomeFirstResponder()
            case invitationCodeTextField03:
                invitationCodeTextField02.becomeFirstResponder()
            case invitationCodeTextField04:
                invitationCodeTextField03.becomeFirstResponder()
            case invitationCodeTextField01:
                invitationCodeTextField01.resignFirstResponder()
            default:
                break
            }
            // Empty the string in the text field.
            textField.text = ""
            invitationCodeString = ""
            return false
        } else if (textField.text?.count)! >= 1 { // If more than one number are written.
            // Make the text field contains only one number.
            textField.text = string
            //invitationCodeString.append(string)
            return false
        }
        return true

    }
    
    
    // MARK: ~ Private Methods
    /*To define xib*/
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
