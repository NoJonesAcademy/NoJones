//
//  DashboardViewController.swift
//  NoJones
//
//  Created by VInicius Mesquita on 20/04/20.
//  Copyright © 2020 NoJones. All rights reserved.
//

import UIKit

class DashboardViewController: UIViewController, UITableViewDataSource {

//    var addictions = [String]()
    var addictions = ["Addiction",
    "Addiction",
    "Addiction",
    "Addiction"]
    
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var userAge: UILabel!
 
    
    @IBOutlet weak var addAddictionButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        if addictions.isEmpty {
            tableView.isScrollEnabled = false
            tableView.backgroundColor = .none
            tableView.separatorStyle = .none
        }
        tableView.rowHeight = 70
        
                
        tableView.dataSource = self
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addictions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "addictionCell")
        
        cell.textLabel?.text = addictions[indexPath.row]
        
        return cell
    }
    
}
