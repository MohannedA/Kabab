//
//  SMSViewController.swift
//  Kabab
//  TODO Change back button text from "back" to be "Phone Number"
//  TODO Make the resend button fit the text.
//  TODO Solve the problem of making keyboard active when view satrts.
//

import UIKit

class SMSViewController: UIViewController {
    //MARK: ~ Properties
    @IBOutlet weak var SMSTextField01: UITextField!
    @IBOutlet weak var SMSTextField02: UITextField!
    @IBOutlet weak var SMSTextField03: UITextField!
    @IBOutlet weak var SMSTextField04: UITextField!
    @IBOutlet weak var resendButton: UIButton!
    @IBOutlet weak var resendText: UILabel!
    @IBOutlet weak var resendView: UIView!
    
    // MARK: ~ Variables
    var SMSText = ""
    var IDNumebr = ""
    var phoneNumber = ""
    var isKeyboardAppear = false
    var isResendViewMoveUp = false
    // Timer variables.
    var timer = Timer()
    var isTimerFinished = false
    var totalTime = 15.0 // In seconds.
    var timeRemaining = 0.0 // In seconds.
    
    // Define view model.
    private let viewModel = SMSViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set up the SMS text fields delegates.
        SMSTextField01.delegate = self
        SMSTextField02.delegate = self
        SMSTextField03.delegate = self
        SMSTextField04.delegate = self
        
        SMSTextField04.layer.cornerRadius = SMSTextField01.bounds.width/2
        SMSTextField04.isHidden = true
        
        
        // Notify if the keyboard changes its status.
        //NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardUp(nofication:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        //NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardDown(nofication:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)

    }
    
    //TODO Solve the problem of making keyboard active when view satrts.
    // Report problem with moving the view with the keyboard.
    /*override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Start the view by making the first text field, first responder.
        //SMSTextField01.becomeFirstResponder()
    }*/
    
    
    // MARK: ~ Actions
    @IBAction func onClickResend(_ sender: UIButton) {
        // Start SMS resend timer.
        playTimer()
    }
    
    //MARK: ~ Private Methods
    /*To handle the view when the keyboard is up*/
     @objc private func keyboardUp(nofication: NSNotification) {
        if !isKeyboardAppear {
            // If casting is valid.
            if let keyboardSize = ((nofication.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue) {
      
                let value = (225.0 * view.bounds.height)/736.0 // Note: Linear method is followed.
                view.frame.origin.y = 0
                //view.frame.origin.y -= (resendView.frame.maxY - keyboardSize.origin.y) + 10
                print("... W")
                if !isResendViewMoveUp {
                    print("... M")
                    view.frame.origin.y -= value//(resendView.frame.maxY - keyboardSize.origin.y) + 10
                    isResendViewMoveUp = true
                }
            }
            isKeyboardAppear = true
        }
    }
    
    /*To handle the view when the keyboard is down*/
    @objc private func keyboardDown(nofication: NSNotification) {
        if isKeyboardAppear {
            // If casting is valid.
            if let _ = ((nofication.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue) {
                if isResendViewMoveUp {
                    resendView.frame.origin.y = 0
                    isResendViewMoveUp = false
                }
            }
            isKeyboardAppear = false
        }
    }
    
    /*To start the timer*/
    private func playTimer() {
        // Set the timer.
        resendText.text = "You can resend the code in"
        resendButton.isEnabled = false // Disable the button while the timer is running.
        timeRemaining = totalTime
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerRunning), userInfo: nil, repeats: true)
    }
    
    /*To handle the timer while the time is running*/
    @objc private func timerRunning() {
        timeRemaining -= 1
        let minutesLeft = Int(timeRemaining) / 60 % 60
        let secondsLeft = Int(timeRemaining) % 60
        resendButton.setTitle("\(minutesLeft) : \(secondsLeft)", for: .normal)
        if timeRemaining == 0 { // If the timer ended.
            timer.invalidate()
            isTimerFinished = true
            resendText.text = "Didn't receive a code yet?"
            resendButton.setTitle("Resend", for: .normal)
            resendButton.isEnabled = true
        }
    }
    
    /*To show an error message*/
    private func showErrorMessage() {}
    
    /*To move the verification successful view controller*/
    private func moveToVerificationSuccessfulViewController() {
        // Move to verification successful view controller.
        let verificationSuccessfulViewController = storyboard?.instantiateViewController(withIdentifier: "VerificationSuccessfulViewController") as! VerificationSuccessfulViewController
        // Delete all object(Employee) data.
        EmployeeLocalCRUD.shered.deleteAll()
        // Insert Employee account data.
        EmployeeLocalCRUD.shered.insert(item: Employee(fullName: "Anything", IDNumber: IDNumebr, phoneNumber: phoneNumber, email: "anything@dopravo.com"))
        present(verificationSuccessfulViewController, animated: true, completion: nil)
    }
    
}

// MARK: ~ TextField Delegate Methods
extension SMSViewController: UITextFieldDelegate {
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
            SMSText += string
            print("----> \(SMSTextField04.text)")
            if SMSText.count == 4 { // 4 is the number of SMS text fields.
                let isSMSValid = self.viewModel.checkISSMSNumberValid(SMSText: SMSText)
                if isSMSValid {
                    moveToVerificationSuccessfulViewController()
                } else { // Show error message.
                    showErrorMessage()
                }
            }
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
            print("----> \(SMSTextField04.text)")
            // Empty the string in the text field.
            textField.text = ""
            return false
            
        } else if (textField.text?.count)! >= 1 { // If more than one number are written.
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
            print("----> \(SMSTextField04.text)")
            // Make the text field contains only one number.
            textField.text = string
            return false
        }
        return true
    }
}
