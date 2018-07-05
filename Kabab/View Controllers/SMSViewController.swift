//
//  SMSViewController.swift
//  Kabab
//
//  Created by mac on 20/10/1439 AH.
//  Copyright © 1439 mac. All rights reserved.
//

import UIKit

class SMSViewController: UIViewController, UITextFieldDelegate {
    //MARK: ...
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
        
        /*SMSTextField01.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: UIControlEvents.editingChanged)
        SMSTextField02.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: UIControlEvents.editingChanged)
        SMSTextField03.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: UIControlEvents.editingChanged)
        SMSTextField04.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: UIControlEvents.editingChanged)*/
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        SMSTextField01.becomeFirstResponder()
    }
    
    //MARK: Actions
    @IBAction func goBackToPhoneNumber(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    
    //MARK: Private Methods
    /*@objc func textFieldDidChange(textField: UITextField) {
        let text = textField.text

        if text?.utf16.count == 1 { // If the number of characters = 1
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
        } else { // If the number of characters != 1
            print("There are more than or less than one character in the text field.")
        }
    }*/
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if ((textField.text?.count)! < 1) && (string.count > 0) {
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
            textField.text = string
            return false
        } else if ((textField.text?.count)! >= 1) && (string.count == 0) {
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
            textField.text = ""
            return false
        } else if (textField.text?.count)! >= 1 {
            textField.text = string
            return false
        }
        return true
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
