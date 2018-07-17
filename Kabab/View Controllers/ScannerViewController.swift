//
//  ScannerViewController.swift
//  Kabab
//
//  Created by mac on 03/11/1439 AH.
//  Copyright © 1439 mac. All rights reserved.
//

import UIKit

class ScannerViewController: UIViewController, QRScannerDelegate {
    
    
    // MARK: ~ Properties
    @IBOutlet weak var invitationCodeButton: UIButton!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var topView: UIView!
    
    // MARK: ~ Variables
    var invitationCodeView = InvitationCodeView()
    
    // MARK: ~ Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up the top and bottom views to have transparent background.
        bottomView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        topView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        

        // Set up the invitation code button border.
        invitationCodeButton.layer.borderWidth = 2
        invitationCodeButton.layer.borderColor = UIColor.white.cgColor
        invitationCodeButton.layer.cornerRadius = 5
        invitationCodeButton.clipsToBounds = true
        
        // Set up QR scanner.
        let QRScannerVC = QRScannerViewController()
        QRScannerVC.delegate = self
        present(QRScannerVC, animated: true, completion: nil)
        
        // Make the top and bottom view on the top of preview view.
        view.bringSubview(toFront: topView)
        view.bringSubview(toFront: bottomView)
        
        // Set up invitation code view.
        invitationCodeView = InvitationCodeView(frame: CGRect(x: 0, y: view.frame.height, width: view.frame.width, height: 497))
        view.addSubview(invitationCodeView)
        view.bringSubview(toFront: invitationCodeView)
        // Add action when doneButton in invitation code view is pressed.
        invitationCodeView.doneButton.addTarget(self, action: #selector(onClickDone(sender:)), for: UIControlEvents.touchUpInside)
        
    }
    
    // MARK: ~ Actions
    @IBAction func onClickInvitationCode(_ sender: UIButton) {
        // Show invitation code view.
        invitationCodeView.animateShowFromBottom(completion: { (isCompleted) in
            // Make the invitation code first text field, first responder.
            self.invitationCodeView.invitationCodeTextField01.becomeFirstResponder()
            })
    }
    
    @objc func onClickDone(sender: UIButton) {
        invitationCodeView.animateHideToBottom(completion: nil)
        // Resign the invitation code text fields responders.
        invitationCodeView.invitationCodeTextField01.resignFirstResponder()
        invitationCodeView.invitationCodeTextField02.resignFirstResponder()
        invitationCodeView.invitationCodeTextField03.resignFirstResponder()
        invitationCodeView.invitationCodeTextField04.resignFirstResponder()
    }
    
    // MARK: ~ QRScanner Delegate Methods
    func getCodeStringValue(_ codeStringValue: String) {
        print(codeStringValue)
    }
    
    func setPreviewView() -> UIView {
        return self.view
    }
    
    func drawBoundingSquares(codeStringValue: String) -> (label: String?, labelPosition: SquareLabelPositions, labelColor: UIColor?, color: CGColor?) {
        return ("Valid", .Top, UIColor.black, UIColor.green.cgColor) 
    }
    
}
