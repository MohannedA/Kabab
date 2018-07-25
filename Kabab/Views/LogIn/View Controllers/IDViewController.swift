//
//  ViewController.swift
//  Kabab
//
//  Created by mac on 18/10/1439 AH.
//  Copyright © 1439 mac. All rights reserved.
//

import UIKit
import NotificationBannerSwift

class IDViewController: UIViewController {
    
    // MARK: ~ Properties
    @IBOutlet weak var IDTextField: UITextField!
    @IBOutlet var keyboardHeightLayoutConstraint: NSLayoutConstraint?
    
    // Define view model.
    private let viewModel = IDViewModel()
    
    // Flags. 
    var isKeyboardAppear = false
    
    // MARK: ~ Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Insert Mock Ip data.
        VisitorLocalCRUD.shered.insert(item: Visitor(phoneNumber: LogInMockData.phoneNumber01.rawValue, IDNumber: LogInMockData.IDNumber01.rawValue))
        VisitorLocalCRUD.shered.insert(item: Visitor(phoneNumber: LogInMockData.phoneNumber03.rawValue, IDNumber: LogInMockData.IDNumber03.rawValue))
        
        // Make the navigation view controller translucent.
        self.navigationController?.addTranslucentEffect()
        
        // Notify if the keyboard changes its status.
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardUp(nofication:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDown(nofication:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        // Set ID text field delegate.
        IDTextField.delegate = self
    }
    
    //MARK: ~ Actions
    @IBAction func moveToPhoneNumberVC(_ sender: UIButton) {
        // Constants
        let textFormIDTextField = IDTextField.text!
        let isValidIDNumber = self.viewModel.checkIsIDValid(IDNumber: textFormIDTextField)
        
        // Check if ID is valid or not.
        if isValidIDNumber { // Go to phone number view controller.
            moveToPhoneNumebrViewController()
        } else { // Nofify the user that invalid ID was entered.
            showErrorMessage()
        }
    }
    
    //MARK: ~ Private Methods
    
    /*To move the phone number view controller*/
    private func moveToPhoneNumebrViewController() {
        // Define stroyboard.
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        // Define phone number view controller.
        let phoneNumberViewController = storyboard.instantiateViewController(withIdentifier: "PhoneNumberViewControllerID") as! PhoneNumberViewController
        phoneNumberViewController.IDNumber = IDTextField.text ?? ""
        view.endEditing(true)
        navigationController?.pushViewController(phoneNumberViewController, animated: true)
    }
    
    /*To show wn error message*/
    private func showErrorMessage() {
        let errorTitle = "Error"
        let errorSubtitle = "Invalid ID numebr"
        let banner = NotificationBanner(title: errorTitle, subtitle: errorSubtitle, style: .warning)
        banner.show()
    }
    
    /*To handle the view when the keyboard is up*/
    @objc private func keyboardUp(nofication: NSNotification) {
        if !isKeyboardAppear {
            // If casting is valid.
            if let keyboardSize = (nofication.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                if keyboardSize.minY < IDTextField.frame.maxY {
                   if self.view.frame.origin.y ==  0 {
                        self.view.frame.origin.y -= (IDTextField.frame.maxY - keyboardSize.origin.y) + 10
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
                if keyboardSize.minY < IDTextField.frame.maxY {
                    if self.view.frame.origin.y !=  0{
                        self.view.frame.origin.y += (IDTextField.frame.maxY - keyboardSize.origin.y) + 10
                    }
                }
            }
            isKeyboardAppear = false
        }
    }

}

// MARK: ~ Text Field Delegate Methods
extension IDViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        view.endEditing(true)
    }
}

