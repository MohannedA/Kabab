//
//  AccountViewController.swift
//  Kabab
//
//  Created by mac on 03/11/1439 AH.
//  Copyright © 1439 mac. All rights reserved.
//

import UIKit

class AccountViewController: UIViewController {
    // MARK: ~ Properties
    @IBOutlet weak var fullNameView: UIView!
    @IBOutlet weak var IDNumberView: UIView!
    @IBOutlet weak var mobileNumberView: UIView!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var IDNumberLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    
    
    // MARK: ~ Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up views borders.
        fullNameView.layoutIfNeeded()
        fullNameView.layer.addBorder(edge: .top, color: UIColor.darkGray, thickness: 2)
        IDNumberView.layoutIfNeeded()
        IDNumberView.layer.addBorder(edge: .top, color: UIColor.darkGray, thickness: 2)
        mobileNumberView.layoutIfNeeded()
        mobileNumberView.layer.addBorder(edge: .top, color: UIColor.darkGray, thickness: 2)
        emailView.layoutIfNeeded()
        emailView.layer.addBorder(edge: .top, color: UIColor.darkGray, thickness: 2)
        
        
        // Assign account data.
        let employee = EmployeeLocalCRUD.shered.getAll().first
        fullNameLabel.text = employee?.fullName
        IDNumberLabel.text = employee?.IDNumber
        phoneNumberLabel.text = employee?.phoneNumber
        emailLabel.text = employee?.email
        
        
        // Make the navigation view controller translucent.
        self.navigationController?.addTranslucentEffect()
    }
    
    // MARK: ~ Actions
    @IBAction func onClickLogOut(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let IDViewController = storyboard.instantiateViewController(withIdentifier: "IDViewController") as! IDViewController
        
        let logInNavigationController = UINavigationController(rootViewController: IDViewController)
        present(logInNavigationController, animated: true, completion: nil)
        //present(navigationController!, animated: true, completion: nil)
        
    }
    

}
