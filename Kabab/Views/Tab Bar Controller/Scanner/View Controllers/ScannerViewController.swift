//
//  ScannerViewController.swift
//  Kabab
//
//  Created by mac on 03/11/1439 AH.
//  Copyright © 1439 mac. All rights reserved.
//

import UIKit

class ScannerViewController: UIViewController {
    
    // MARK: ~ Properties
    @IBOutlet weak var invitationCodeButton: UIButton!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var QRCodeView: UIView!
    
    // MARK: ~ Variables
    var invitationCodeView = InvitationCodeView()
    var validInvitationCodeView = InvitationCodeValidAndInvalidView()
    var invalidInvitationCodeView = InvitationCodeValidAndInvalidView()
    var checkedInView = CheckedInView()
    
    // Define view model.
    private let viewModel = ScannerViewModel()
    
    // Test variables.
    var invitationCode01 = "0000"
    var invitationCode02 = "1111"
    var i = 0
    
    // QR scanner variaables.
    private var videoLayer: CALayer!
    var QRCodeScanner: QRScanner!
    var videoPreview = UIView()
    
    // MARK: ~ Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Insert Mock up data.
        
        
        // Set up the top and bottom views to have transparent background.
        bottomView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        topView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        

        // Set up the invitation code button border.
        invitationCodeButton.layer.borderWidth = 2
        invitationCodeButton.layer.borderColor = UIColor.white.cgColor
        invitationCodeButton.layer.cornerRadius = 5
        invitationCodeButton.clipsToBounds = true
        
        // Set up QR scanner.
        videoPreview = self.view
        QRCodeScanner = QRScanner()
        QRCodeScanner.delegate = self
        videoLayer = QRCodeScanner.videoPreview
        view.layer.addSublayer(videoLayer)
        
        // Make the top, bottom, and QRCode view on the top of preview view.
        view.bringSubview(toFront: topView)
        view.bringSubview(toFront: bottomView)
        view.bringSubview(toFront: QRCodeView)
        
        // Set up invitation code view.
        invitationCodeView = InvitationCodeView(frame: CGRect(x: 0, y: view.frame.height, width: view.frame.width, height: 497))
        view.addSubview(invitationCodeView)
        view.bringSubview(toFront: invitationCodeView)
        // Set invitation code delegate.
        invitationCodeView.delegate = self
        
        // Set valid invitation code view.
        validInvitationCodeView = InvitationCodeValidAndInvalidView(frame: CGRect(x: 0, y: view.frame.height, width: view.frame.width, height: 436))
        // Assign empty string to validity status label.
        validInvitationCodeView.validityStatus.text = ""
        view.addSubview(validInvitationCodeView)
        view.bringSubview(toFront: validInvitationCodeView)
        
        // Set invalid invitation code view.
        invalidInvitationCodeView = InvitationCodeValidAndInvalidView(frame: CGRect(x: 0, y: view.frame.height, width: view.frame.width, height: 436))
        view.addSubview(invalidInvitationCodeView)
        // Assign error string to validity status label.
        invalidInvitationCodeView.validityStatus.text = "Invitation code is not valid."
        invalidInvitationCodeView.validityStatus.textColor = .red
        
        // Set checked in view.
        checkedInView = CheckedInView(frame: CGRect(x: 0, y: view.frame.height, width: view.frame.width, height: 497))
        view.addSubview(checkedInView)
        view.bringSubview(toFront: checkedInView)
        
        
        
        // Add tab gesture recognizer to resign the first responder. 
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(view.endEditing(_:)))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
        
        // Add action when doneButton in invitation code view is pressed.
        invitationCodeView.doneImageButton.addTarget(self, action: #selector(onClickDoneInvitationCodeView(sender:)))
        
        // Add action when doneButton in valid invitation code view is pressed.
        validInvitationCodeView.doneImageButton.addTarget(self, action: #selector(onClickDoneValidInvitationCodeView(sender:)))
        
        // Add action when doneButton in invalid invitation code view is pressed.
        invalidInvitationCodeView.doneImageButton.addTarget(self, action: #selector(onClickDoneInvalidInvitationCodeView(sender:)))
        
        
        // Make the navigation view controller translucent.
        self.navigationController?.addTranslucentEffect()
        

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // Set up QR scanner size.
        videoLayer.frame = videoPreview.bounds
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Start code scanner.
        QRCodeScanner.startScanning { (code) in
            print(code)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Stop code scanner.
        QRCodeScanner.stopScanning()
    }
    
    // MARK: ~ Actions
    @IBAction func onClickInvitationCode(_ sender: UIButton) {
        // Reset all invitation code view
        // Reset invitation code view color to default.
        invitationCodeView.contentView.backgroundColor = .white
        emptyInvitationCodeText()
        view.addBlurEffect(20)
        view.bringSubview(toFront: invitationCodeView)
        // Show invitation code view.
        invitationCodeView.animateShowFromBottom(completion: { (isCompleted) in
            // Make the invitation code first text field, first responder.
            self.invitationCodeView.invitationCodeTextField01.becomeFirstResponder()
            })
    }
    
    @objc func onClickDoneInvitationCodeView(sender: UITapGestureRecognizer) {
        invitationCodeView.animateHideToBottom{ (true) in
            // Remove blur effect.
            self.view.viewWithTag(20)?.removeFromSuperview()
        }
        view.endEditing(true)
        // Resign the invitation code text fields responders.
        invitationCodeView.invitationCodeTextField01.resignFirstResponder()
        invitationCodeView.invitationCodeTextField02.resignFirstResponder()
        invitationCodeView.invitationCodeTextField03.resignFirstResponder()
        invitationCodeView.invitationCodeTextField04.resignFirstResponder()
    }
    
    @objc func onClickDoneValidInvitationCodeView(sender: UITapGestureRecognizer) {
        print("Got here 1")
        validInvitationCodeView.animateHideToBottom{ (true) in
            // Remove blur effect.
            self.view.viewWithTag(20)?.removeFromSuperview()
        }
    }
    
    @objc func onClickDoneInvalidInvitationCodeView(sender: UITapGestureRecognizer) {
        print("Got here 2")
        invalidInvitationCodeView.animateHideToBottom{ (true) in
            // Remove blur effect.
            self.view.viewWithTag(20)?.removeFromSuperview()
        }
    }
    
    // MARK: ~ Private Methods
    /*To empty all the invitation code text*/
    private func emptyInvitationCodeText() {
        // Empty all invitation code text fields.
        invitationCodeView.invitationCodeTextField01.text = ""
        invitationCodeView.invitationCodeTextField02.text = ""
        invitationCodeView.invitationCodeTextField03.text = ""
        invitationCodeView.invitationCodeTextField04.text = ""
        // Empty the invitation code string
        invitationCodeView.invitationCodeString = ""
    }
    
    /*To show check in view*/
    private func showCheckedInView() {
        checkedInView.animateShowFromBottom(completion: nil)
    }
    
    /*To show an error message*/
    private func showErrorMessage() {
        
    }
    
}
// MARK: ~ QRScanner Delegate Methods
extension ScannerViewController: QRScannerDelegate {
    func getCodeStringValue(_ codeStringValue: String) {
        let isQRCodeValid = self.viewModel.checkIsQRCodeValid(code: codeStringValue)
        if isQRCodeValid {
            showCheckedInView()
            // TODO: Refresh visitors data.
        } else {
            showErrorMessage()
        }
    }
    
    func setPreviewView() -> UIView {
        return self.view
    }
    
    func drawBoundingSquares(codeStringValue: String) -> (label: String?, labelPosition: SquareLabelPositions, labelColor: UIColor?, color: CGColor?)? {
        return nil
    }
    // TODO: Make the scanner more accurate by changing the frame that scanner scans in.
    // Suggestion: Use ".frame" insted of ".bounds".
    func getCodeBounds(_ codeBounds: CGRect, _ codeStringValue: String) {
        print("QRCodeView maxX \(codeBounds.maxX) and \(QRCodeView.bounds.maxX)")
        print("QRCodeView maxY \(codeBounds.maxY) and \(QRCodeView.bounds.maxY)")
        print("topView maxX \(codeBounds.maxX) and \(topView.bounds.maxX)")
        print("topView maxY \(codeBounds.maxY) and \(topView.bounds.maxY)")
        print("bottomView maxX \(codeBounds.maxX) and \(bottomView.bounds.maxX)")
        print("bottomView maxY \(codeBounds.maxY) and \(bottomView.bounds.maxY)")
        /*if codeBounds.maxY >= QRCodeView.bounds.maxY &&
         codeBounds.maxX <= QRCodeView.bounds.maxX &&
         codeBounds.height <= QRCodeView.bounds.height &&
         codeBounds.width <= QRCodeView.bounds.width &&
         codeBounds.maxY >= topView.bounds.maxY &&
         codeBounds.maxX  <= topView.bounds.maxX &&
         codeBounds.maxY >= bottomView.bounds.maxY &&
         codeBounds.maxX <= bottomView.bounds.maxX {
         i += 1
         print("Good \(i)")
         }*/
        // Between 350 and 200 is the the range where the QRcode view exist.
        if codeBounds.maxY >= 350 && codeBounds.maxX >= 200 {
            i += 1
            print("Good \(i)")
        }
    }
}
// MARK: ~ Invitation Code View Delegate Methods
extension ScannerViewController: InvitationCodeViewDelegate {
    func checkInvitationCode() {
        let isInvitationCodeValid = self.viewModel.checkIsInvitationCodeValid(code: invitationCodeView.invitationCodeString)
        if isInvitationCodeValid {
            // Hide invitation code view.
            invitationCodeView.animateHideToBottom(completion: nil)
            // Bring the invalid invitation code view to the front of the blur effect.
            view.bringSubview(toFront: validInvitationCodeView)
            // Animate valid invitation code view.
            validInvitationCodeView.animateShowFromBottom(completion: nil)
        } else {
            // Hide invitation code view.
            invitationCodeView.animateHideToBottom(completion: nil)
            // Bring the invalid invitation code view to the front of the blur effect.
            view.bringSubview(toFront: invalidInvitationCodeView)
            // Animate invalid invitation code view.
            invalidInvitationCodeView.animateShowFromBottom(completion: nil)
            
            
            // Make the first invitation code text field, the first responder.
            //invitationCodeView.invitationCodeTextField01.becomeFirstResponder()
            //emptyInvitationCodeText()
            
        }
    }
}
