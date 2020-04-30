//
//  OnBoardingViewController.swift
//  NoJones
//
//  Created by Joseph on 22/04/20.
//  Copyright © 2020 NoJones. All rights reserved.
//

import UIKit

class InitialScreenViewController: UIViewController{
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var bornDate: UIDatePicker!
    
    let userData = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func saveData(_ sender: Any) {
        userData.set(nameTextField.text, forKey: "userName")
        userData.set(bornDate.date, forKey: "bornDate")
    }
}

