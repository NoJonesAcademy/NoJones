//
//  HabitDetailsViewController.swift
//  NoJones
//
//  Created by VInicius Mesquita on 28/04/20.
//  Copyright © 2020 NoJones. All rights reserved.
//

import UIKit

class HabitDetailsViewController: UIViewController {

    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var borderView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        borderView.layer.borderColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        let views = stackView.arrangedSubviews
        
        for view in views {
            view.layer.cornerRadius = 12.5
        }
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
