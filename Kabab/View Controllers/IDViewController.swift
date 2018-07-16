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
        // Insert Mock Ip data.
        LocalCRUD.shered.insert(item: Visitor(phoneNumber: MockData.phoneNumber01.rawValue, IDNumber: MockData.IDNumber01.rawValue))
        LocalCRUD.shered.insert(item: Visitor(phoneNumber: MockData.phoneNumber03.rawValue, IDNumber: MockData.IDNumber03.rawValue))
        
        // Make the navigation view controller translucent.
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
    }
    
    //MARK: Actions
    @IBAction func moveToPhoneNumberVC(_ sender: UIButton) {
        // Constants
        let textFormIDTextField: String = IDTextField.text!
        let isValidIDNumber: Bool = checkIsIDValid(IDNumber: textFormIDTextField)
        
        // Check if ID is valid or not.
        if isValidIDNumber { // Go to phone number view controller.
            // Define stroyboard.
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let PNViewController = storyboard.instantiateViewController(withIdentifier: "PhoneNumberViewControllerID") as! PhoneNumberViewController
            navigationController?.pushViewController(PNViewController, animated: true)
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
