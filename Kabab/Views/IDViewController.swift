//
//  ViewController.swift
//  Kabab
//
//  Created by mac on 18/10/1439 AH.
//  Copyright © 1439 mac. All rights reserved.
//

import UIKit

class IDViewController: UIViewController {
    
    //MARK: Properties
    @IBOutlet weak var IDTextField: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Insert Mock Data.
        LocalCRUD.shered.insert(item: Visitor(phoneNumber: MockData.phoneNumber01.rawValue, ID: MockData.ID01.rawValue))
        LocalCRUD.shered.insert(item: Visitor(phoneNumber: MockData.phoneNumber02.rawValue, ID: MockData.ID02.rawValue))
    }
    
    //MARK: Actions
    @IBAction func moveToPhoneNumberVC(_ sender: UIButton) {
        // Var.
        let textFormIDTextField: String = IDTextField.text!
        let isValidID: Bool = checkIsIDValid(ID: textFormIDTextField)
        
        // Check if ID is valid or not.
        if isValidID { // Go to phone number view controller.
            let PhoneNumberViewController = storyboard?.instantiateViewController(withIdentifier: "PhoneNumberViewControllerID") as! PhoneNumberViewController
            present(PhoneNumberViewController, animated: true, completion: nil)
        } else { // Nofify the user that invalid ID was entered.
            print("invalid ID")
        }
    }
    
    //MARK: Private Methods
    private func checkIsIDValid(ID: String) -> Bool {
        return false
    }


}

