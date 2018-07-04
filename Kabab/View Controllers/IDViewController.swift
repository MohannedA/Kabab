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
    
    //MARK: Properties
    @IBOutlet weak var IDTextField: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Insert Mock Data.
        LocalCRUD.shered.insert(item: Visitor(phoneNumber: MockData.phoneNumber01.rawValue, IDNumber: MockData.IDNumber01.rawValue))
        LocalCRUD.shered.insert(item: Visitor(phoneNumber: MockData.phoneNumber02.rawValue, IDNumber: MockData.IDNumber02.rawValue))
    }
    
    //MARK: Actions
    @IBAction func moveToPhoneNumberVC(_ sender: UIButton) {
        // Constants
        let textFormIDTextField: String = IDTextField.text!
        let isValidIDNumber: Bool = checkIsIDValid(IDNumber: textFormIDTextField)
        
        // Check if ID is valid or not.
        if isValidIDNumber { // Go to phone number view controller.
            let PNViewController = storyboard?.instantiateViewController(withIdentifier: "PhoneNumberViewControllerID") as! PhoneNumberViewController
            present(PNViewController, animated: true, completion: nil)
        } else { // Nofify the user that invalid ID was entered.
            let errorTitle = "Error"
            let errorSubtitle = "Invalid ID numebr"
            let banner = NotificationBanner(title: errorTitle, subtitle: errorSubtitle, style: .warning)
            banner.show()
            
            // Debugging
            print("Invalid ID numebr")
        }
    }
    
    //MARK: Private Methods
    private func checkIsIDValid(IDNumber: String) -> Bool {
        if let _ = LocalCRUD.shered.getByIDNumber(IDNumber: IDNumber) {
            return true
        } else {
            return false
        }
    }


}

