//
//  PhoneNumberViewController.swift
//  Kabab
//
//  Created by mac on 19/10/1439 AH.
//  Copyright © 1439 mac. All rights reserved.
//

import UIKit
import NotificationBannerSwift

class PhoneNumberViewController: UIViewController {
    
    // MARK: ~ Properties
    @IBOutlet weak var phoneNumberTextField: UITextField!

    // MARK: ~ Variables
    let backItem = UIBarButtonItem()
    var IDNumber = ""
    var isKeyboardAppear = false
    
    // MARK: ~ Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Notify if the keyboard changes its status.
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardUp(nofication:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardDown(nofication:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Phone Number", style: .plain, target: self, action: nil)
    }
    
    // MARK: ~ Actions
    @IBAction func logIn(_ sender: UIButton) {
        // Constants
        let textFormPhoneNumberTextField: String = phoneNumberTextField.text!
        let isValidPhoneNumber: Bool = checkIsPhoneNumberValid(phoneNumber: textFormPhoneNumberTextField)
        
        // Check if phone number is valid or not.
        if isValidPhoneNumber { // Go to phone number view controller.
            // Define stroyboard.
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let SMSViewController = storyboard.instantiateViewController(withIdentifier: "SMSViewControllerID") as! SMSViewController
            SMSViewController.IDNumebr = IDNumber
            SMSViewController.phoneNumber = phoneNumberTextField.text ?? ""
            navigationController?.pushViewController(SMSViewController, animated: true)
        } else { // Nofify the user that invalid phone number was entered.
            let errorTitle = "Error"
            let errorSubtitle = "Invalid ID numebr"
            let banner = NotificationBanner(title: errorTitle, subtitle: errorSubtitle, style: .warning)
            banner.show()
            
            // Debugging
            print("Invalid phone numebr")
        }
    }
    
    // MARK: ~ Private Methods
    private func checkIsPhoneNumberValid(phoneNumber: String) -> Bool {
        if let _ = VisitorLocalCRUD.shered.getByPhoneNumber(phoneNumber: phoneNumber) {
            return true
        } else {
            return false
        }
    }
    
    
    /*To handle the view when the keyboard is up*/
    @objc private func keyboardUp(nofication: NSNotification) {
        if !isKeyboardAppear {
            // If casting is valid.
            if let keyboardSize = (nofication.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                if keyboardSize.minY < phoneNumberTextField.frame.maxY {
                    if self.view.frame.origin.y ==  0 {
                        self.view.frame.origin.y -= (phoneNumberTextField.frame.maxY - keyboardSize.origin.y) + 10
                    }
                }
            }
        }
        isKeyboardAppear = true
    }
    
    /*To handle the view when the keyboard is down*/
    @objc private func keyboardDown(nofication: NSNotification) {
        if isKeyboardAppear {
            // If casting is valid.
            if let keyboardSize = (nofication.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
                if keyboardSize.minY < phoneNumberTextField.frame.maxY {
                    if self.view.frame.origin.y !=  0{
                        self.view.frame.origin.y += (phoneNumberTextField.frame.maxY - keyboardSize.origin.y) + 10
                    }
                }
            }
            isKeyboardAppear = false
        }
    }
    // MARK: ~ Navigation
}
