//
//  ChecksTableViewViewController.swift
//  Kabab
//  Tutorial link: https://medium.com/swift-programming/swift-enums-and-uitableview-sections-1806b74b8138
//  Created by mac on 21/10/1439 AH.
//  Copyright © 1439 mac. All rights reserved.
//

import UIKit

let MovieData = [
    ["title": "Jason Bourne", "cast": "CheckedIn", "genre": "action"],
    ["title": "Suicide Squad", "cast": "Margot Robbie, Jared Leto, Will Smith", "genre": "action"],
    ["title": "Star Trek Beyond", "cast": "Chris Pine, Zachary Quinto, Zoe Saldana", "genre": "action"],
    ["title": "Deadpool", "cast": "Ryan Reynolds, Morena Baccarin, Gina Carano", "genre": "action"],
    ["title": "London Has Fallen", "cast": "Gerard Butler, Aaron Eckhart, Morgan Freeman, Angela Bassett", "genre": "action"],
    ["title": "Ghostbusters", "cast": "Kate McKinnon, Leslie Jones, Melissa McCarthy, Kristen Wiig", "genre": "comedy"],
    ["title": "Central Intelligence", "cast": "Dwayne Johnson, Kevin Hart", "genre": "comedy"],
    ["title": "Bad Moms", "cast": "Mila Kunis, Kristen Bell, Kathryn Hahn, Christina Applegate", "genre": "comedy"],
    ["title": "Keanu", "cast": "Jordan Peele, Keegan-Michael Key", "genre": "comedy"],
    ["title": "Neighbors 2: Sorority Rising", "cast": "Seth Rogen, Rose Byrne", "genre": "comedy"],
    ["title": "The Shallows", "cast": "Blake Lively", "genre": "drama"],
    ["title": "The Finest Hours", "cast": "Chris Pine, Casey Affleck, Holliday Grainger", "genre": "drama"],
    ["title": "10 Cloverfield Lane", "cast": "Mary Elizabeth Winstead, John Goodman, John Gallagher Jr.", "genre": "drama"],
    ["title": "A Hologram for the King", "cast": "Tom Hanks, Sarita Choudhury", "genre": "drama"],
    ["title": "Miracles from Heaven", "cast": "Jennifer Garner, Kylie Rogers, Martin Henderson", "genre": "drama"],
]

class VisitorsViewController: UIViewController {
    //MARK: ~ Properties
    @IBOutlet weak var tableView: UITableView!
    
    var checkedInView = CheckedInView()
    var checkedOutView = CheckedOutView()
    
    //MARK: ~ Variables
    var isCheckedIn: Bool = false
    
    // The magic enum to end our pain and suffering!
    // For the most part the order of our cases do not matter.
    // What is important is that our first case is set to 0, and that our last case is always `total`.
    enum TableSection: Int {
        case expected = 0, checkedIN, checkedOut, all, total
    }
    
    // This is the size of our header sections that we will use later on.
    let SectionHeaderHeight: CGFloat = 25
    
    // Data variable to track our sorted data.
    var data = [TableSection: [[String: String]]]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sortData()
        
        // Define checked in view.
        checkedInView = CheckedInView(frame: CGRect(x: 0, y: view.frame.height, width: view.frame.width, height: 497))
        self.view.addSubview(checkedInView)
        checkedInView.doneImageButton.addTarget(self, action: #selector(onClickCheckedInDoneImage(sender:)))
        
        // Define checked out view.
        checkedOutView = CheckedOutView(frame: CGRect(x: 0, y: view.frame.height, width: view.frame.width, height: 497))
        self.view.addSubview(checkedOutView)
        checkedOutView.doneImageButton.addTarget(self, action: #selector(onClickCheckedOutDoneImage(sender:)))
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }
    
    // When generating sorted table data we can easily use our TableSection to make look up simple and easy to read.
    func sortData() {
        data[.expected] = MovieData.filter({ $0["genre"] == "action" })
        data[.checkedIN] = MovieData.filter({ $0["genre"] == "comedy" })
        data[.checkedOut] = MovieData.filter({ $0["genre"] == "drama" })
        data[.all] = MovieData.filter({ $0["genre"] == "indie" })
    }
    
    //MARK: Actions
    @IBAction func checkIn(_ sender: UIButton) {
        isCheckedIn = true
        tableView.reloadData()
    }
    
    @objc func onClickCheckedInDoneImage(sender: UITapGestureRecognizer!) {
        checkedInView.animateHideToBottom { (true) in
            self.view.viewWithTag(30)?.removeFromSuperview()
        }
    }
    
    
    @objc func onClickCheckedOutDoneImage(sender: UITapGestureRecognizer!) {
        checkedOutView.animateHideToBottom{ (true) in
            self.view.viewWithTag(40)?.removeFromSuperview()
        }
    }
    
    
}

extension VisitorsViewController: UITableViewDataSource, UITableViewDelegate {
    
    // As long as `total` is the last case in our TableSection enum,
    // this method will always be dynamically correct no mater how many table sections we add or remove.
    func numberOfSections(in tableView: UITableView) -> Int {
        return TableSection.total.rawValue
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Using Swift's optional lookup we first check if there is a valid section of table.
        // Then we check that for the section there is data that goes with.
        if let tableSection = TableSection(rawValue: section), let movieData = data[tableSection] {
            if isCheckedIn {
                if section == 1 {
                    return movieData.count
                }
                else {
                    return 0
                }
            } else {
                return movieData.count
            }
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        // If we wanted to always show a section header regardless of whether or not there were rows in it,
        // then uncomment this line below:
        //return SectionHeaderHeight
        
        // First check if there is a valid section of table.
        // Then we check that for the section there is more than 1 row.
        if let tableSection = TableSection(rawValue: section), let movieData = data[tableSection], movieData.count > 0 {
            if isCheckedIn {
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
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: SectionHeaderHeight))
        view.backgroundColor = UIColor.lightGray//UIColor(red: 253.0/255.0, green: 240.0/255.0, blue: 196.0/255.0, alpha: 1)
        let label = UILabel(frame: CGRect(x: 15, y: 0, width: tableView.bounds.width - 30, height: SectionHeaderHeight))
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = UIColor.white
        if let tableSection = TableSection(rawValue: section) {
            switch tableSection {
            case .expected:
                label.text = "Expected"
            case .checkedIN:
                label.text = "Checked In"
            case .checkedOut:
                label.text = "Checked Out"
            case .all:
                label.text = "All"
            default:
                label.text = ""
            }
        }
        view.addSubview(label)
        return view
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        // Similar to above, first check if there is a valid section of table.
        // Then we check that for the section there is a row.
        if let tableSection = TableSection(rawValue: indexPath.section), let movie = data[tableSection]?[indexPath.row] {
            if let titleLabel = cell.viewWithTag(10) as? UILabel {
                titleLabel.text = movie["title"]
            }
            if let subtitleLabel = cell.viewWithTag(20) as? UILabel {
                subtitleLabel.text = movie["cast"]
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentCell = tableView.cellForRow(at: indexPath)
        if let subtitle = currentCell?.viewWithTag(20) as? UILabel {
            switch indexPath.section {
            case 0: // Expected.
                break
            case 1: // Checked In.
                view.addBlurEffect(30)
                // // To make the checked out view over the blur effect.
                view.bringSubview(toFront: checkedInView)
                checkedInView.animateShowFromBottom(completion: nil)
                break
            case 2: // Checked Out.
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

}
