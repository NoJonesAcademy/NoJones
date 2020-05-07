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
    let userDao = CoreDao<User>(with: "User")
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTextField?.delegate = self
    }
    
    @IBAction func saveData(_ sender: Any) {
        if nameTextField.text == "" {
            nameTextField.layer.borderWidth = 1.0
            nameTextField.layer.borderColor = UIColor.red.cgColor
            let alertController = UIAlertController(title: "Oops", message:
                "Você esqueceu de inserir seu nome", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Entendi", style: .default))

            self.present(alertController, animated: true, completion: nil)
        }
        else {
            performSegue(withIdentifier: "segue", sender: nil)
            UserDefaultsManager.setUser(name: nameTextField.text, bornDate: bornDate?.date)
            let user = userDao.new()
            user.name = nameTextField.text
            userDao.save()
            
        }
    }
}

extension InitialScreenViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nameTextField.resignFirstResponder()
        
        return true
    }
}
