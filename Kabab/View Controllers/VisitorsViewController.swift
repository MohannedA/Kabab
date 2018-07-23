//
//  ChecksTableViewViewController.swift
//  Kabab
//  Created by mac on 21/10/1439 AH.
//  Copyright © 1439 mac. All rights reserved.
//

import UIKit

class VisitorsViewController: UIViewController {
    //MARK: ~ Properties
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: ~ Variables
    var isCheckedIn: Bool = false
    var checkedInView = CheckedInView()
    var checkedOutView = CheckedOutView()
    
    // Define mock up data.
    var visitorsData: [[[String: String]]] = [[["Name": "Ghostbusters",  "Section": "Expected"],
                                                    ["Name": "Keanu",  "Section": "Expected"]],[["Name": "Jason Bourne",  "Section": "CheckedIn"], ["Name": "Suicide Squad",  "Section": "CheckedIn"]], [["Name": "Star Trek Beyond",  "Section": "CheckedOut"], ["Name": "London Has Fallen",  "Section": "CheckedOut"]]]
    // Define table sections.
    var tableSections = [0, 1, 2]
    
    // Define section height.
    let SectionHeaderHeight: CGFloat = 25
    
    // MARK: ~ Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Define checked in view.
        checkedInView = CheckedInView(frame: CGRect(x: 0, y: view.frame.height, width: view.frame.width, height: 497))
        self.view.addSubview(checkedInView)
        checkedInView.doneImageButton.addTarget(self, action: #selector(onClickCheckedInDoneImage(sender:)))
        
        // Define checked out view.
        checkedOutView = CheckedOutView(frame: CGRect(x: 0, y: view.frame.height, width: view.frame.width, height: 497))
        self.view.addSubview(checkedOutView)
        checkedOutView.doneImageButton.addTarget(self, action: #selector(onClickCheckedOutDoneImage(sender:)))
        
        // Make the navigation view controller translucent.
        self.navigationController?.addTranslucentEffect()

        // Add search bar item. 
        let searchItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(onClickSearchButton(_:)))
        self.navigationItem.rightBarButtonItem = searchItem
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // Load visitors table data.
        tableView.reloadData()
    }
    
    //MARK: Actions
    @IBAction func checkIn(_ sender: UIButton) {
        isCheckedIn = true
        // For testing.
        let section = 1
        visitorsData[section].append(["Name": "Test",  "Section": "CheckedIn"])
        // Load visitors table data.
        tableView.reloadData()
    }
    
    @objc func onClickCheckedInDoneImage(sender: UITapGestureRecognizer!) {
        checkedInView.animateHideToBottom { (true) in
            // Remove blur effect.
            self.view.viewWithTag(30)?.removeFromSuperview()
        }
    }
    
    
    @objc func onClickCheckedOutDoneImage(sender: UITapGestureRecognizer!) {
        checkedOutView.animateHideToBottom{ (true) in
            // Remove blur effect.
            self.view.viewWithTag(40)?.removeFromSuperview()
        }
    }
    
    @objc func onClickSearchButton(_ sender: UIBarButtonItem) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let searchViewController = storyboard.instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
        //navigationController?.pushViewController(vc, animated: true)
        //show(vc, sender: self)
        searchViewController.visitorsData = visitorsData
        navigationController?.pushViewController(searchViewController, animated: true)
        //present(vc, animated: true, completion: nil)
        //performSegue(withIdentifier: "segue", sender: self)
    }
    
    // MARK: ~ Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let searchViewController = segue.destination as! SearchViewController
        searchViewController.visitorsData = visitorsData
    }
    
    
}

extension VisitorsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableSections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isCheckedIn { // If checked in button is clicked.
            if section == 1 {
                return visitorsData[section].count
            }
            else {
                return 0
            }
        } else {
            return visitorsData[section].count
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if visitorsData[section].count > 0 {
            if isCheckedIn { // If checked in button is clicked.
                if section == 1 {
                    return SectionHeaderHeight
                }
                else {
                    return 0.0
                }
            } else {
                return SectionHeaderHeight
            }
        }
        
        return 0
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        // Add section properties.
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: SectionHeaderHeight))
        view.backgroundColor = UIColor.lightGray//UIColor(red: 253.0/255.0, green: 240.0/255.0, blue: 196.0/255.0, alpha: 1)
        let label = UILabel(frame: CGRect(x: 15, y: 0, width: tableView.bounds.width - 30, height: SectionHeaderHeight))
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = UIColor.white
        // Add section label.
        switch tableSections[section] {
        case 0:
            label.text = "Expected"
        case 1:
            label.text = "Checked In"
        case 2:
            label.text = "Checked Out"
        default:
            label.text = ""
        }
        view.addSubview(label)
        return view
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if let titleLabel = cell.viewWithTag(10) as? UILabel {
            titleLabel.text = visitorsData[indexPath.section][indexPath.row]["Name"]
        }
        if let subtitleLabel = cell.viewWithTag(20) as? UILabel {
            subtitleLabel.text = visitorsData[indexPath.section][indexPath.row]["Section"]
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0: // Item is clicked in expected section.
            break
        case 1: // Item is clicked in checked in section.
            view.addBlurEffect(30)
            // // To make the checked out view over the blur effect.
            view.bringSubview(toFront: checkedInView)
            checkedInView.animateShowFromBottom(completion: nil)
            break
        case 2: // Item is clicked in checked out section.
            view.addBlurEffect(40)
            // To make the checked out view over the blur effect.
            view.bringSubview(toFront: checkedOutView)
            checkedOutView.animateShowFromBottom(completion: nil)
            break
        default:
            break
        }
    }

}
