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

        configureViews()
    }
    
    func configureViews() {
        borderView.layer.borderColor = UIColor.init(named: "secondaryColor")?.cgColor
        let views = stackView.arrangedSubviews
        
        for view in views {
            view.layer.cornerRadius = 12.5
        }
    }

}
