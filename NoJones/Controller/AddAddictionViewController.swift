//
//  AddAddictionViewController.swift
//  NoJones
//
//  Created by Albert Rayneer on 22/04/20.
//  Copyright © 2020 NoJones. All rights reserved.
//

import UIKit


class AddAddictionViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var addictionPicker: UIPickerView!
    @IBOutlet weak var addictionNameTextField: UITextField!
    @IBOutlet weak var newHabitTextField: UITextField!
    @IBOutlet weak var fellingsBeforeTextField: UITextField!
    @IBOutlet weak var feelingsAfterTextField: UITextField!
    
    var addictionData = [String]()
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return addictionData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return addictionData[row]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configueTextFields()
        
        self.addictionPicker.delegate = self
        self.addictionPicker.dataSource = self
        addictionData = ["Vezes ao Dia","Minutos","Horas"]
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(dismissModal))

        navigationItem.leftBarButtonItem?.tintColor = UIColor(named: "buttonColor")
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveData))
        
        navigationItem.rightBarButtonItem?.tintColor = UIColor(named: "buttonColor")

    }
    
    
    @objc func dismissModal () {
        self.navigationController?.dismiss(animated: true, completion: {})
        //self.navigationController?
    }
    
    @objc func saveData(){
        print(addictionNameTextField.text ?? "Vazio")
        print(newHabitTextField.text ?? "Vazio")
        print(fellingsBeforeTextField.text ?? "Vazio")
        print(feelingsAfterTextField.text ?? "Vazio")
        print(addictionPicker.selectedRow(inComponent: 0))
    }
}


extension AddAddictionViewController: UITextFieldDelegate {
    
    func configueTextFields() {
        
        self.addictionNameTextField.delegate = self
        self.newHabitTextField.delegate = self
        self.fellingsBeforeTextField.delegate = self
        self.feelingsAfterTextField.delegate = self
        self.newHabitTextField.tag = 0
                
        self.addictionNameTextField.layer.borderWidth  = 2
        self.addictionNameTextField.layer.cornerRadius = 8
        self.addictionNameTextField.tag = 1
       
        self.newHabitTextField.layer.borderWidth  = 2
        self.newHabitTextField.layer.cornerRadius = 8
        self.newHabitTextField.tag = 2
        
        self.fellingsBeforeTextField.layer.borderWidth  = 2
        self.fellingsBeforeTextField.layer.cornerRadius = 8
        self.fellingsBeforeTextField.tag = 3
        
        self.feelingsAfterTextField.layer.borderWidth  = 2
        self.feelingsAfterTextField.layer.cornerRadius = 8
        self.feelingsAfterTextField.tag = 4
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            // Not found, so remove keyboard.
            textField.resignFirstResponder()
        }
        return true
    }
    
}
