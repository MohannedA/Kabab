//
//  TabBarController.swift
//  Kabab
//
//  Created by mac on 03/11/1439 AH.
//  Copyright © 1439 mac. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    // MARK: ~ Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Define storyboard.
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        // TODO Fix TabBar and Scanner Problem.
        // Define scanner view controller.
        //let scannerViewController = storyboard.instantiateViewController(withIdentifier: "ScannerViewController") as! ScannerViewController
        // Add bar item to the scanner view controller.
        //scannerViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .downloads, tag: 0)
        
        // Define checks table view view controller.
        let checksTableViewViewController = storyboard.instantiateViewController(withIdentifier: "ChecksTableViewViewController") as! ChecksTableViewViewController//ChecksTableViewViewController()
        // Add bar item to the checks table view view controller.
        checksTableViewViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 1)
        
        // Define account view controller.
        let accountViewControllers = storyboard.instantiateViewController(withIdentifier: "AccountViewController") as! AccountViewController//AccountViewController()
        // Add bar item to the account view controller.
        accountViewControllers.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 2)
        
        // Define tab bar view controllers list.
        //let viewControllerList = [ scannerViewController, checksTableViewViewController, accountViewControllers ]
        let viewControllerList = [
            checksTableViewViewController, accountViewControllers ]
        // Create navigation controller. 
        viewControllers = viewControllerList.map { UINavigationController(rootViewController: $0) }
    }

}
