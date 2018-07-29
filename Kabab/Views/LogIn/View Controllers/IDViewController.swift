//
//  ViewController.swift
//  Kabab
//
//  Created by mac on 18/10/1439 AH.
//  Copyright © 1439 mac. All rights reserved.
//

import UIKit
import NotificationBannerSwift
import ScreenType

class IDViewController: UIViewController {
    
    // MARK: ~ Properties
    @IBOutlet weak var IDTextField: UITextField!
    @IBOutlet var keyboardHeightLayoutConstraint: NSLayoutConstraint?
    
    @IBOutlet weak var contactUsButton: UIButton!
    @IBOutlet weak var poweredByLabel: UILabel!
    @IBOutlet weak var needHelpLabel: UILabel!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var errorMessageLabel: UILabel!
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
        
        // Set labels font size.
        //contactUsButton.titleLabel?.adjustsFontSizeToFitWidth = true
        //contactUsButton.sizeToFit()
        //poweredByLabel.adjustsFontSizeToFitWidth = true
        //needHelpLabel.adjustsFontSizeToFitWidth = true
        
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
        IDTextField.layer.addShadowBottomBorder(color: #colorLiteral(red: 0.8550000191, green: 0.8550000191, blue: 0.8550000191, alpha: 1))
        //IDTextField.layoutIfNeeded()
        
        // Assign text field clear button image.
        let clearImage = UIImage(named: "delete-sign.png")
        IDTextField.clearButtonWithImage(clearImage!)
        
        // Set next button.
        nextButton.addBottomCornerRadius(10)
        nextButton.setBackgroundColor(#colorLiteral(red: 1, green: 0.5839999914, blue: 0, alpha: 1), for: .normal)
        nextButton.setBackgroundColor(#colorLiteral(red: 0.8000000119, green: 0.8000000119, blue: 0.8000000119, alpha: 1), for: .disabled)
        // By default, set it to disabled since text field is empty.
        nextButton.isEnabled = false
        
        // Add action when phone number text field changes.
        IDTextField.addTarget(self, action: #selector(editingChanged(_:)), for: .editingChanged)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Change back button to have "Phone Number" title.
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
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
        // Set valid status.
        IDTextField.textColor = .black
        IDTextField.layer.shadowColor = #colorLiteral(red: 0.8550000191, green: 0.8550000191, blue: 0.8550000191, alpha: 1)
        errorMessageLabel.textColor = .white
        // Define stroyboard.
        let storyboard = UIStoryboard(name: "LogIn", bundle: nil)
        // Define phone number view controller.
        let phoneNumberViewController = storyboard.instantiateViewController(withIdentifier: "PhoneNumberViewController3") as! PhoneNumberViewController
        phoneNumberViewController.IDNumber = IDTextField.text ?? ""
        view.endEditing(true)
        navigationController?.pushViewController(phoneNumberViewController, animated: true)
    }
    
    /*To show wn error message*/
    private func showErrorMessage() {
        IDTextField.textColor = .red
        IDTextField.layer.shadowColor = UIColor.red.cgColor
        errorMessageLabel.textColor = .red
        
        /*
        let errorTitle = "Error"
        let errorSubtitle = "Invalid ID numebr"
        let banner = NotificationBanner(title: errorTitle, subtitle: errorSubtitle, style: .warning)
        banner.show()
         */
    }
    
    /*To handle the view when the keyboard is up*/
    @objc private func keyboardUp(nofication: NSNotification) {
        if !isKeyboardAppear {
            // If casting is valid.
            if let keyboardSize = (nofication.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                let textFieldFrame = view.convert(IDTextField.frame, from: mainView)
                if self.view.frame.origin.y ==  0 {
                    self.view.frame.origin.y -= ((textFieldFrame.maxY) - keyboardSize.origin.y) + 125
                }
                /*
                if keyboardSize.minY < (textFieldFrame.maxY) {
                   if self.view.frame.origin.y ==  0 {
                    self.view.frame.origin.y -= ((textFieldFrame.maxY) - keyboardSize.origin.y) + 10
                    }
                }
                */
            }
        }
        isKeyboardAppear = true
    }
    
    /*To handle the view when the keyboard is down*/
    @objc private func keyboardDown(nofication: NSNotification) {
        if isKeyboardAppear {
            // If casting is valid.
            if let keyboardSize = (nofication.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
                let textFieldFrame = view.convert(IDTextField.frame, from: mainView)
                if self.view.frame.origin.y !=  0{
                    self.view.frame.origin.y += (textFieldFrame.maxY - keyboardSize.origin.y) + 125
                }
                /*
                if keyboardSize.minY < textFieldFrame.maxY {
                    if self.view.frame.origin.y !=  0{
                        self.view.frame.origin.y += (textFieldFrame.maxY - keyboardSize.origin.y) + 10
                    }
                }
                 */
            }
            isKeyboardAppear = false
        }
    }
    
    /*To enable text field when it is not empty*/
    @objc func editingChanged(_ textField: UITextField) {
        if textField.text != "" {
            nextButton.isEnabled = true
        } else {
            nextButton.isEnabled = false
        }
    }

}

// MARK: ~ Text Field Delegate Methods
extension IDViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        IDTextField.layer.addShadowBottomBorder(color: .black)
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        view.endEditing(true)
        if textField.text != "" {
            nextButton.isEnabled = true
        }
    }
}

