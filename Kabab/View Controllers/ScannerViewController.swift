//
//  ScannerViewController.swift
//  Kabab
//
//  Created by mac on 03/11/1439 AH.
//  Copyright © 1439 mac. All rights reserved.
//

import UIKit

class ScannerViewController: UIViewController, QRScannerDelegate, InvitationCodeViewDelegate {
    
    // MARK: ~ Properties
    @IBOutlet weak var invitationCodeButton: UIButton!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var QRCodeView: UIView!
    
    // MARK: ~ Variables
    var invitationCodeView = InvitationCodeView()
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
        
        // Add action when doneButton in invitation code view is pressed.
        //invitationCodeView.doneButton.addTarget(self, action: #selector(onClickDone(sender:)), for: UIControlEvents.touchUpInside)
        

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
    
    func drawBoundingSquares(codeStringValue: String) -> (label: String?, labelPosition: SquareLabelPositions, labelColor: UIColor?, color: CGColor?)? {
        return nil
    }
    // TODO Make the scanner more accurate.
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
    
    // MARK: ~ Invitation Code View Delegate Methods
    func checkInvitationCode() {
        if invitationCodeView.invitationCodeString == invitationCode01 {
            invitationCodeView.contentView.backgroundColor = .cyan
            invitationCodeView.animateHideToBottom(completion: nil)
        } else {
            invitationCodeView.contentView.backgroundColor = .red
            // Make the first invitation code text field, the first responder.
            invitationCodeView.invitationCodeTextField01.becomeFirstResponder()
            emptyInvitationCodeText()
            
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
    
}
