//
//  TabBarController.swift
//  Kabab
//
//  Created by mac on 03/11/1439 AH.
//  Copyright © 1439 mac. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController, UITabBarControllerDelegate{

    // MARK: ~ Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up tab controller delegate. 
        self.delegate = self
        
        // Define storyboard.
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        // Define scanner view controller.
        let scannerViewController = storyboard.instantiateViewController(withIdentifier: "ScannerViewController") as! ScannerViewController
        scannerViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .downloads, tag: 0)
        
        // Define checks table view view controller.
        let checksTableViewViewController = storyboard.instantiateViewController(withIdentifier: "ChecksTableViewViewController") as! ChecksTableViewViewController//ChecksTableViewViewController()
        // Add bar item to the checks table view view controller.
        checksTableViewViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 1)
        
        // Define account view controller.
        let accountViewControllers = storyboard.instantiateViewController(withIdentifier: "AccountViewController") as! AccountViewController
        // Add bar item to the account view controller.
        accountViewControllers.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 2)
        
        // Define tab bar view controllers list.
        let viewControllerList = [ scannerViewController, checksTableViewViewController, accountViewControllers ]
        // Create navigation controller.
        viewControllers = viewControllerList.map { UINavigationController(rootViewController: $0) }
        
        // Select the second view controller(checksTableViewViewController).
        self.selectedViewController = self.viewControllers?[1]

    }
    
    

}
