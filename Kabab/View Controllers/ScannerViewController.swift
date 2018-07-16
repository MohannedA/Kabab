//
//  ScannerViewController.swift
//  Kabab
//
//  Created by mac on 03/11/1439 AH.
//  Copyright © 1439 mac. All rights reserved.
//

import UIKit

class ScannerViewController: UIViewController {

    @IBOutlet weak var invitationCodeButton: UIButton!
    @IBOutlet weak var previewView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Set up the invitation code button border.
        invitationCodeButton.layer.borderWidth = 2
        invitationCodeButton.layer.borderColor = UIColor.white.cgColor
        invitationCodeButton.layer.cornerRadius = 5
        invitationCodeButton.clipsToBounds = true
        
    }
    
    // MARK: ~ Actions
    @IBAction func onClickInvitationCode(_ sender: UIButton) {
    }
    

}
