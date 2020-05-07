//
//  AddAddictionViewController.swift
//  NoJones
//
//  Created by Albert Rayneer on 22/04/20.
//  Copyright © 2020 NoJones. All rights reserved.
//

import UIKit

class AddAddictionViewController: UIViewController {
    
    var delegate: HabitDelegate?
    let habitDao = CoreDao<Habit>(with: "Habit")
    let userDao =  CoreDao<User>(with: "User")
    let concurrentHabitDao =  CoreDao<ConcurrentHabit>(with: "ConcurrentHabit")
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var addictionPicker: UIPickerView!
    @IBOutlet weak var habitNameTextField: UITextField!
    @IBOutlet weak var newHabitTextField: UITextField!
    @IBOutlet weak var fellingsBeforeTextField: UITextField!
    @IBOutlet weak var feelingsAfterTextField: UITextField!
    
    var addictionData = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.keyboardDismissMode = .onDrag
        self.configueTextFields()
        
        self.addictionPicker.delegate = self
        self.addictionPicker.dataSource = self
        addictionData = ["Vezes ao Dia","Minutos","Horas"]
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancelar", style: .plain, target: self, action: #selector(dismissModal))
        
        navigationItem.leftBarButtonItem?.tintColor = UIColor(named: "buttonColor")
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Salvar", style: .done, target: self, action: #selector(createHabit))
        
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

extension AddAddictionViewController:  UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
         return 1
     }
     
     func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
         return addictionData.count
     }
     
     func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
         return addictionData[row]
     }
    
}


extension AddAddictionViewController {
    
    @objc func createHabit() {
        
        let habit = habitDao.new()
        let user = userDao.fetchAll().first as? User
        
        var complete = true
        let textFieldColor = UIColor(named: "buttonColor")?.cgColor
        
        if habitNameTextField.text == "" {
            warningEmptyTextField(textField: habitNameTextField)
            complete = false
        }
        else {
            habitNameTextField.layer.borderColor = textFieldColor
            habit.name = habitNameTextField.text
        }
        if newHabitTextField.text == "" {
            warningEmptyTextField(textField: newHabitTextField)
            complete = false
        }
        else {
            newHabitTextField.layer.borderColor = textFieldColor
            let concurrent = concurrentHabitDao.new()
            concurrent.name = newHabitTextField.text
//            habit.concurrent = concurrent
//            habit.concurrent?.name = newHabitTextField.text
        }
        if fellingsBeforeTextField.text == "" {
            warningEmptyTextField(textField: fellingsBeforeTextField)
            complete = false
        }
        else {
            fellingsBeforeTextField.layer.borderColor = textFieldColor
            habit.initialFelling = fellingsBeforeTextField.text
        }
        if feelingsAfterTextField.text == "" {
            warningEmptyTextField(textField: feelingsAfterTextField)
            complete = false
        }
        else {
            feelingsAfterTextField.layer.borderColor = textFieldColor
            habit.finalFelling = feelingsAfterTextField.text
        }
        
        if complete {
//            habit.userOwner = use
            delegate?.didCreateHabit(habit)
            dismissModal()
            habitDao.insert(object: habit)
            _ = habitDao.new()
        }
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
