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
    
    //MARK: Properties    
    @IBOutlet weak var phoneNumberTextField: UITextField!
    
    let backItem = UIBarButtonItem()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationItem.backBarButtonItem?.title = "1111"
    }
    
    
    @IBAction func logIn(_ sender: UIButton) {
        // Constants
        let textFormPhoneNumberTextField: String = phoneNumberTextField.text!
        let isValidPhoneNumber: Bool = checkIsPhoneNumberValid(phoneNumber: textFormPhoneNumberTextField)
        
        // Check if phone number is valid or not.
        if isValidPhoneNumber { // Go to phone number view controller.
            // Define stroyboard.
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let SMSViewController = storyboard.instantiateViewController(withIdentifier: "SMSViewControllerID") as! SMSViewController
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
    
    //MARK: Private Methods
    private func checkIsPhoneNumberValid(phoneNumber: String) -> Bool {
        if let _ = LocalCRUD.shered.getByPhoneNumber(phoneNumber: phoneNumber) {
            return true
        } else {
            return false
        }
    }
}
