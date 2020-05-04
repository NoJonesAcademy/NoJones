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
        
        customTextField(textField: newHabitTextField)
        self.newHabitTextField.tag = 0
                
        customTextField(textField: addictionNameTextField)
        self.addictionNameTextField.tag = 1
       
        customTextField(textField: newHabitTextField)
        self.newHabitTextField.tag = 2
        
        customTextField(textField: fellingsBeforeTextField)
        self.fellingsBeforeTextField.tag = 3
        
        customTextField(textField: feelingsAfterTextField)
        self.feelingsAfterTextField.tag = 4
    }
    
    func customTextField(textField: UITextField) {
        let leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 8, height: 2.0))
        textField.leftView = leftView
        textField.leftViewMode = .always
        textField.delegate = self
        textField.tintColor = UIColor(named: "buttonColor")
        textField.layer.borderWidth  = 2
        textField.layer.borderColor = UIColor(named: "buttonColor")?.cgColor
        textField.layer.cornerRadius = 8
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
