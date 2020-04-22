//
//  AddAddictionViewController.swift
//  NoJones
//
//  Created by Albert Rayneer on 22/04/20.
//  Copyright © 2020 NoJones. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)
class AddAddictionViewController: UIViewController, UIPickerViewDelegate, UITextFieldDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var addictionPicker: UIPickerView!
    var addictionData:[String] = [String]()
    
    @IBOutlet weak var addictionNameTextField: UITextField!
    @IBOutlet weak var newHabitTextField: UITextField!
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return addictionData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
       return addictionData[row]
    }
    
    
    @objc func dismissModal (){
        self.navigationController?.dismiss(animated: true, completion: {})
        //self.navigationController?
    }
    
    @objc func saveData(){
        print(addictionNameTextField.text ?? "Vazio")
        print(newHabitTextField.text ?? "Vazio")
        print(addictionPicker.selectedRow(inComponent: 0))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configueTextFields()
        
        self.addictionPicker.delegate = self
        self.addictionPicker.dataSource = self
        addictionData = ["Cigarros","Drogas","Jogos"]
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(dismissModal))

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveData))
    }
    
    
    func configueTextFields(){
        
        self.addictionNameTextField.delegate = self
        self.newHabitTextField.delegate = self
        
        
       self.addictionNameTextField.layer.borderWidth  = 2
       self.addictionNameTextField.layer.cornerRadius = 8
       self.addictionNameTextField.layer.borderColor = .init(srgbRed: 27/255, green: 88/255, blue: 166/255, alpha: 1)
       
       self.newHabitTextField.layer.borderWidth  = 2
       self.newHabitTextField.layer.cornerRadius = 8
       self.newHabitTextField.layer.borderColor = .init(srgbRed: 27/255, green: 88/255, blue: 166/255, alpha: 1)
    }
    

}
