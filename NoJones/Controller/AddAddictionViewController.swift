//
//  AddAddictionViewController.swift
//  NoJones
//
//  Created by Albert Rayneer on 22/04/20.
//  Copyright © 2020 NoJones. All rights reserved.
//

import UIKit


class AddAddictionViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var delegate: HabitDelegate?
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var addictionPicker: UIPickerView!
    //TextFields
    @IBOutlet weak var habitNameTextField: UITextField!
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
        
        scrollView.keyboardDismissMode = .onDrag
        self.configueTextFields()
        
        self.addictionPicker.delegate = self
        self.addictionPicker.dataSource = self
        addictionData = ["Vezes ao Dia","Minutos","Horas"]
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(dismissModal))

        navigationItem.leftBarButtonItem?.tintColor = UIColor(named: "buttonColor")
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(createHabit))
        
        navigationItem.rightBarButtonItem?.tintColor = UIColor(named: "buttonColor")

    }
    
    
    @objc func dismissModal () {
        self.navigationController?.dismiss(animated: true, completion: {})
        //self.navigationController?
    }
    
}


extension AddAddictionViewController: UITextFieldDelegate {
    
    func configueTextFields() {
        
        customTextField(textField: newHabitTextField)
        self.newHabitTextField.tag = 0
                
        customTextField(textField: habitNameTextField)
        self.habitNameTextField.tag = 1
       
        customTextField(textField: newHabitTextField)
        self.newHabitTextField.tag = 2
        
        customTextField(textField: fellingsBeforeTextField)
        self.fellingsBeforeTextField.tag = 3
        
        customTextField(textField: feelingsAfterTextField)
        self.feelingsAfterTextField.tag = 4
    }
    
    func customTextField(textField: UITextField) {
        let leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 8, height: 2.0))
        textField.autocorrectionType = .no
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

extension AddAddictionViewController {
    
    @objc func createHabit(){
        
        let habit = Habit()
        
        if habitNameTextField.text == "" {
            warningEmptyTextField(textField: habitNameTextField)
        }
        else {
            habit.name = habitNameTextField.text
        }
        if newHabitTextField.text == "" {
            warningEmptyTextField(textField: newHabitTextField)
        }
        else {
            habit.concurrent?.name = newHabitTextField.text
        }
        if fellingsBeforeTextField.text == "" {
           warningEmptyTextField(textField: fellingsBeforeTextField)
        }
        else {
             habit.initialFelling = fellingsBeforeTextField.text
        }
        if feelingsAfterTextField.text == "" {
            warningEmptyTextField(textField: feelingsAfterTextField)
        }
        else {
            habit.finalFelling = feelingsAfterTextField.text
        }
        
        delegate?.didCreateHabit(habit)
    }
    
    func warningEmptyTextField(textField: UITextField) {
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.red.cgColor
        let alertController = UIAlertController(title: "Oops", message:
            "Você esqueceu de algo", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Entendi", style: .default))

        self.present(alertController, animated: true, completion: nil)
    }
}

protocol HabitDelegate {
    func didCreateHabit(_ habit: Habit)
}
