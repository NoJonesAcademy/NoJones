//
//  InfoTableViewController.swift
//  NoJones
//
//  Created by Mateus Nobre Ferreira on 05/05/20.
//  Copyright © 2020 NoJones. All rights reserved.
//

import UIKit

class InfoTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        tableView.reloadRows(at: [IndexPath(item: 0, section: 0)], with: UITableView.RowAnimation.fade)
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     
        switch section {
        case 1:
            return 1
        default:
            return 1
        }
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell?
        
        if(indexPath.section == 0){
            cell = tableView.dequeueReusableCell(withIdentifier: "InfoCollectionTableViewCell") as! InfoCollectionTableViewCell
        }else {
            cell = tableView.dequeueReusableCell(withIdentifier: "infoAppCell")
        }
        
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(indexPath.section == 0 ){
            return 250
        }else{
            return 128
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let returnView = UITableViewHeaderFooterView()

        if(section == 0){
            returnView.textLabel?.text = "Entenda Mais"
        }else{
            returnView.textLabel?.text = "Saiba Mais sobre nosso App"
        }
    
        returnView.backgroundView = UIView()
        
        return returnView
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let returnView = UIView()
        returnView.backgroundColor = .clear
        
        return returnView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(36)
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat(12)
    }
}
