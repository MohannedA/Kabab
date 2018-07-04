//
//  ViewController.swift
//  Kabab
//
//  Created by mac on 18/10/1439 AH.
//  Copyright © 1439 mac. All rights reserved.
//

import UIKit

class IDViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    //MARK: Actions
    @IBAction func moveToPhoneNumberVC(_ sender: UIButton) {
        let newViewController = storyboard?.instantiateViewController(withIdentifier: "PhoneNumberViewControllerID") as! PhoneNumberViewController
        present(newViewController, animated: true, completion: nil)
    }
    
    


}

