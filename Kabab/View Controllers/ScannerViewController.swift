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
    @IBOutlet weak var previewView: UIView!
    
    // MARK: ~ Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Set up the invitation code button border.
        invitationCodeButton.layer.borderWidth = 2
        invitationCodeButton.layer.borderColor = UIColor.white.cgColor
        invitationCodeButton.layer.cornerRadius = 5
        invitationCodeButton.clipsToBounds = true
        
        // Set up QR scanner.
        let QRScannerVC = QRScannerViewController()
        QRScannerVC.delegate = self
        present(QRScannerVC, animated: true, completion: nil)
        
    }
    
    // MARK: ~ Actions
    @IBAction func onClickInvitationCode(_ sender: UIButton) {
    }
    
    // MARK: ~ QRScanner Delegate Methods
    func getCodeStringValue(_ codeStringValue: String) {
        print(codeStringValue)
    }
    
    func setPreviewView() -> UIView {
        return previewView
    }
    
    func drawBoundingSquares(codeStringValue: String) -> (label: String?, labelPosition: SquareLabelPositions, labelColor: UIColor?, color: CGColor?) {
        return ("Valid", .Top, UIColor.black, UIColor.green.cgColor) 
    }
    
    

}
