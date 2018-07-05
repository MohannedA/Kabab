//
//  SMSViewController.swift
//  Kabab
//
//  Created by mac on 20/10/1439 AH.
//  Copyright © 1439 mac. All rights reserved.
//

import UIKit

class SMSViewController: UIViewController, UITextFieldDelegate {
    //MARK: Properties
    @IBOutlet weak var SMSTextField01: UITextField!
    @IBOutlet weak var SMSTextField02: UITextField!
    @IBOutlet weak var SMSTextField03: UITextField!
    @IBOutlet weak var SMSTextField04: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set up the SMS text fields.
        SMSTextField01.delegate = self
        SMSTextField02.delegate = self
        SMSTextField03.delegate = self
        SMSTextField04.delegate = self
        
        // Notify if the keyboard changes its status.
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardUp(nofication:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardDown(nofication:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
    }
    // Make problem with moving the view with the keyboard.
    /*override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Start the view by making the first text field, first responder.
        //SMSTextField01.becomeFirstResponder()
    }*/
    
    //MARK: Actions
    @IBAction func goBackToPhoneNumber(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if ((textField.text?.count)! < 1) && (string.count > 0) { // If the responder goes forward.
            switch textField {
            case SMSTextField01:
                SMSTextField02.becomeFirstResponder()
            case SMSTextField02:
                SMSTextField03.becomeFirstResponder()
            case SMSTextField03:
                SMSTextField04.becomeFirstResponder()
            case SMSTextField04:
                SMSTextField04.resignFirstResponder()
            default:
                break
            }
            // Enter the string in the text field.
            textField.text = string
            return false
        } else if ((textField.text?.count)! >= 1) && (string.count == 0) { // If the responder goes backword(delete).
            switch textField {
            case SMSTextField02:
                SMSTextField01.becomeFirstResponder()
            case SMSTextField03:
                SMSTextField02.becomeFirstResponder()
            case SMSTextField04:
                SMSTextField03.becomeFirstResponder()
            case SMSTextField01:
                SMSTextField01.resignFirstResponder()
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
    
    //MARK: Private Methods
     @objc private func keyboardUp(nofication: NSNotification) {
        //?????
        if let _ = ((nofication.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue) {
            let value: CGFloat = (225.0 * view.bounds.height)/736.0
            view.frame.origin.y = 0
            view.frame.origin.y -= value
        }
    }
    
    @objc private func keyboardDown(nofication: NSNotification) {
        //?????
        if let _ = ((nofication.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue) {
            view.frame.origin.y = 0
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
