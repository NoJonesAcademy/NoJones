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
        
        nameTextField?.delegate = self
    }
    
    @IBAction func saveData(_ sender: Any) {
        if nameTextField.text == "" {
            nameTextField.layer.borderWidth = 1.0
            nameTextField.layer.borderColor = UIColor.red.cgColor
        }
        else {
            performSegue(withIdentifier: "segue", sender: nil)
            userData.set(nameTextField.text, forKey: "userName")
            userData.set(bornDate.date, forKey: "bornDate")
        }
    }
}

extension InitialScreenViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nameTextField.resignFirstResponder()
        
        return true
    }
}
