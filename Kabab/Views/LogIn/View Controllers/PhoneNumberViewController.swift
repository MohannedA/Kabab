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
    @IBOutlet weak var contactUsButton: UIButton!
    @IBOutlet weak var poweredByLabel: UILabel!
    @IBOutlet weak var needHelpLabel: UILabel!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var errorMessageLabel: UILabel!

    // MARK: ~ Variables
    let backItem = UIBarButtonItem()
    var IDNumber = ""
    var isKeyboardAppear = false
    
    // Define view model
    private let viewModel = PhoneNumebrViewModel()
    
    // MARK: ~ Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set phone number text field delegate.
        phoneNumberTextField.delegate = self
        
        // Set background color.
        view.backgroundColor = #colorLiteral(red: 0.4709999859, green: 0.8740000129, blue: 0.9570000172, alpha: 1)
        
        // Notify if the keyboard changes its status.
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardUp(nofication:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardDown(nofication:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        // Set labels font size.
        if UIScreen.current == .iPhone4_0 {
            poweredByLabel.font = poweredByLabel.font.withSize(10)
            needHelpLabel.font = needHelpLabel.font.withSize(10)
        }
        
        // Add radius to the main view.
        mainView.layer.cornerRadius = 10
        
        // Set background color.
        view.backgroundColor = #colorLiteral(red: 0.4709999859, green: 0.8740000129, blue: 0.9570000172, alpha: 1)
        
        // Add text field bottom border.
        //IDTextField.layer.addBorder(edge: .bottom, color: .black, thickness: 2)
        phoneNumberTextField.layer.addShadowBottomBorder(color: #colorLiteral(red: 0.8550000191, green: 0.8550000191, blue: 0.8550000191, alpha: 1))
        //IDTextField.layoutIfNeeded()
        
        // Assign text field clear button image.
        let clearImage = UIImage(named: "delete-sign.png")
        phoneNumberTextField.clearButtonWithImage(clearImage!)
        
        // Set next button.
        nextButton.addBottomCornerRadius(10)
        nextButton.setBackgroundColor(#colorLiteral(red: 1, green: 0.5839999914, blue: 0, alpha: 1), for: .normal)
        nextButton.setBackgroundColor(#colorLiteral(red: 0.8000000119, green: 0.8000000119, blue: 0.8000000119, alpha: 1), for: .disabled)
        // By default, set it to disabled since text field is empty.
        nextButton.isEnabled = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Change back button to have "Phone Number" title.
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Phone Number", style: .plain, target: self, action: nil)
    }
    
    // MARK: ~ Actions
    @IBAction func logIn(_ sender: UIButton) {
        // Constants
        let textFormPhoneNumberTextField = phoneNumberTextField.text!
        let isValidPhoneNumber = self.viewModel.checkIsPhoneNumberValid(phoneNumber: textFormPhoneNumberTextField)
        
        // Check if phone number is valid or not.
        if isValidPhoneNumber { // Go to phone number view controller.
            moveToSMSViewController()
        } else { // Nofify the user that invalid phone number was entered.
            showErrorMessage()
            
            // Debugging
            print("Invalid phone numebr")
        }
    }
    
    // MARK: ~ Private Methods
    
    
    /*To handle the view when the keyboard is up*/
    @objc private func keyboardUp(nofication: NSNotification) {
        if !isKeyboardAppear {
            // If casting is valid.
            if let keyboardSize = (nofication.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                let textFieldFrame = view.convert(phoneNumberTextField.frame, from: mainView)
                if keyboardSize.minY < (textFieldFrame.maxY) {
                    if self.view.frame.origin.y ==  0 {
                        self.view.frame.origin.y -= ((textFieldFrame.maxY) - keyboardSize.origin.y) + 10
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
                let textFieldFrame = view.convert(phoneNumberTextField.frame, from: mainView)
                if keyboardSize.minY < textFieldFrame.maxY {
                    if self.view.frame.origin.y !=  0{
                        self.view.frame.origin.y += (textFieldFrame.maxY - keyboardSize.origin.y) + 10
                    }
                }
            }
            isKeyboardAppear = false
        }
    }
    
    /*To move the SMS view controller*/
    private func moveToSMSViewController() {
        // Set valid status.
        phoneNumberTextField.textColor = .black
        phoneNumberTextField.layer.shadowColor = #colorLiteral(red: 0.8550000191, green: 0.8550000191, blue: 0.8550000191, alpha: 1)
        errorMessageLabel.textColor = .white
        // Define stroyboard.
        let storyboard = UIStoryboard(name: "LogIn", bundle: nil)
        let SMSViewController = storyboard.instantiateViewController(withIdentifier: "SMSViewControllerID") as! SMSViewController
        SMSViewController.IDNumebr = IDNumber
        SMSViewController.phoneNumber = phoneNumberTextField.text ?? ""
        navigationController?.pushViewController(SMSViewController, animated: true)
    }
    
    /*To show an error message*/
    private func showErrorMessage() {
        phoneNumberTextField.textColor = .red
        phoneNumberTextField.layer.shadowColor = UIColor.red.cgColor
        errorMessageLabel.textColor = .red
        
        /*
         let errorTitle = "Error"
         let errorSubtitle = "Invalid phone numebr"
         let banner = NotificationBanner(title: errorTitle, subtitle: errorSubtitle, style: .warning)
         banner.show()
         */
    }
    
    // MARK: ~ Navigation
}

// MARK: ~ Text Field Delegate Methods
extension PhoneNumberViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        view.endEditing(true)
        if textField.text != "" {
            nextButton.isEnabled = true
        }
    }
}

