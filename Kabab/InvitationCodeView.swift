//
//  InvitationCodeView.swift
//  Kabab
//
//  Created by mac on 04/11/1439 AH.
//  Copyright © 1439 mac. All rights reserved.
//

import UIKit

class InvitationCodeView: UIView, UITextFieldDelegate {
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
        
        // Set up invitation code text fields delegates.
        invitationCodeTextField01.delegate = self
        invitationCodeTextField02.delegate = self
        invitationCodeTextField03.delegate = self
        invitationCodeTextField04.delegate = self
        
        // Define radius for the content view.
        contentView.layer.cornerRadius = 50
        
        // Notify if the keyboard changes its status.
        //NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardUp(nofication:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        //NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardDown(nofication:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
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
            return false
        } else if (textField.text?.count)! >= 1 { // If more than one number are written.
            // Make the text field contains only one number.
            textField.text = string
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
    
    /*To handle the view when the keyboard is up*/
    @objc private func keyboardUp(nofication: NSNotification) {
        // If casting is valid.
        if let _ = ((nofication.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue) {
            let value: CGFloat = (225.0 * contentView.bounds.height)/736.0 // Note: Linear method is followed.
            contentView.frame.origin.y = 0
            contentView.frame.origin.y -= value
        }
    }
    /*To handle the view when the keyboard is down*/
    @objc private func keyboardDown(nofication: NSNotification) {
        // If casting is valid.
        if let _ = ((nofication.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue) {
            contentView.frame.origin.y = 0
        }
    }
    

}
