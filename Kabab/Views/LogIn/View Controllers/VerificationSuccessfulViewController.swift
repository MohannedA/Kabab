//
//  VerificationSuccessfulViewController.swift
//  Kabab
//
//  Created by mac on 10/11/1439 AH.
//  Copyright © 1439 mac. All rights reserved.
//

import UIKit

class VerificationSuccessfulViewController: UIViewController {
    
    // MARK: ~ Variables
    // To indicate if the operation is completed or not.
    var isCompleted = false
    var activityIndicator = UIActivityIndicatorView()
    
    // Define view model.
    private let viewModel = VerificationSuccessfulViewModel()

    // MARK: ~ Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Define activity indicator.
        activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
        
        // Position activity indicator in the center of the main view.
        activityIndicator.center = view.center
        
        // To hide when stoped.
        activityIndicator.hidesWhenStopped = true
        
        activityIndicator.color = .black
        
        // Start activity indicator.
        activityIndicator.startAnimating()
        
        view.addSubview(activityIndicator)
        

    }
    
    // MARK: ~ Actions
    @IBAction func onClickCompleteButton(_ sender: UIButton) {
        // For testing.
        isCompleted = self.viewModel.checkIsVerificationCompleted() 
        if isCompleted {
            // Stop activity indicator.
            activityIndicator.stopAnimating()
            
            let storyboard = UIStoryboard(name: "TabBarController", bundle: nil)
            let tabViewController = storyboard.instantiateViewController(withIdentifier: "TabBarController") as! TabBarController
            present(tabViewController, animated: true, completion: nil)
        }
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
