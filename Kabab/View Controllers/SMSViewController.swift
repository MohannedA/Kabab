//
//  SMSViewController.swift
//  Kabab
//
//  Created by mac on 20/10/1439 AH.
//  Copyright © 1439 mac. All rights reserved.
//

import UIKit

class SMSViewController: UIViewController, UITextFieldDelegate {
    //MARK: ~ Properties
    @IBOutlet weak var SMSTextField01: UITextField!
    @IBOutlet weak var SMSTextField02: UITextField!
    @IBOutlet weak var SMSTextField03: UITextField!
    @IBOutlet weak var SMSTextField04: UITextField!
    @IBOutlet weak var resendButton: UIButton!
    
    // MARK: ~ Variables
    var timer = Timer()
    var isTimerFinished = false
    var totalTime = 15.0 // In seconds.
    var timeRemaining = 0.0 // In seconds.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set up the SMS text fields.
        SMSTextField01.delegate = self
        SMSTextField02.delegate = self
        SMSTextField03.delegate = self
        SMSTextField04.delegate = self
        
        // Notify if the keyboard changes its status.
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardUp(nofication:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardDown(nofication:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        // TODO Change back button text from "back" to be "Phone Number"
        // TODO Make the resend button fit the text.
        
        /*
        // Make the resend button fit the text.
        resendButton.titleLabel?.numberOfLines = 0
        resendButton.titleLabel?.adjustsFontSizeToFitWidth = true
        resendButton.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
         */

    }
    
    // Report problem with moving the view with the keyboard.
    /*override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Start the view by making the first text field, first responder.
        //SMSTextField01.becomeFirstResponder()
    }*/
    
    // MARK: ~ TextField Delegate
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if ((textField.text?.count)! < 1) && (string.count > 0) { // If the responder goes forward.
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
            // Enter the string in the text field.
            textField.text = string
            return false
        } else if ((textField.text?.count)! >= 1) && (string.count == 0) { // If the responder goes backword(delete).
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
            // Empty the string in the text field.
            textField.text = ""
            return false
        } else if (textField.text?.count)! >= 1 { // If more than one number are written.
            // Make the text field contains only one number.
            textField.text = string
            return false
        }
        return true
    }
    
    // MARK: ~ Actions
    @IBAction func onClickResend(_ sender: UIButton) {
        playTimer()
    }
    
    
    //MARK: ~ Private Methods
     @objc private func keyboardUp(nofication: NSNotification) {
        // If casting is valid.
        if let _ = ((nofication.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue) {
            let value: CGFloat = (225.0 * view.bounds.height)/736.0 // Note: Linear method is followed.
            view.frame.origin.y = 0
            view.frame.origin.y -= value
        }
    }
    
    @objc private func keyboardDown(nofication: NSNotification) {
        // If casting is valid.
        if let _ = ((nofication.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue) {
            view.frame.origin.y = 0
        }
    }
    
    private func playTimer() {
        resendButton.isEnabled = false
        timeRemaining = totalTime
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerRunning), userInfo: nil, repeats: true)
    }
    
    @objc func timerRunning() {
        timeRemaining -= 1
        let minutesLeft = Int(timeRemaining) / 60 % 60
        let secondsLeft = Int(timeRemaining) % 60
        resendButton.setTitle("\(minutesLeft) : \(secondsLeft)", for: .normal)
        if timeRemaining == 0 {
            timer.invalidate()
            isTimerFinished = true
            resendButton.setTitle("Resend", for: .normal)
            resendButton.isEnabled = true
        }
    }

}
