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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: Actions
    @IBAction func goBackToID(_ sender: UIButton) {
        // Go back to ID view controller.
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func logIn(_ sender: UIButton) {
        // Constants
        let textFormPhoneNumberTextField: String = phoneNumberTextField.text!
        let isValidPhoneNumber: Bool = checkIsPhoneNumberValid(phoneNumber: textFormPhoneNumberTextField)
        
        // Check if phone number is valid or not.
        if isValidPhoneNumber { // Go to phone number view controller.
            let SMSViewController = storyboard?.instantiateViewController(withIdentifier: "SMSViewControllerID") as! SMSViewController
            present(SMSViewController, animated: true, completion: nil)
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
