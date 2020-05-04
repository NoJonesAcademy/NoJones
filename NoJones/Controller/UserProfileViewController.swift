//
//  UserProfileViewController.swift
//  NoJones
//
//  Created by Albert Rayneer on 04/05/20.
//  Copyright © 2020 NoJones. All rights reserved.
//

import UIKit
import ParallaxHeader

class UserProfileViewController: UIViewController {
    
    let image = UIImage(named: "profileImage")
    let profileImage = UIImageView()
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var userAge: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never

        userName.text = UserDefaultsManager.fetchString(withUserDefaultKey: .userName)
        
        userName.delegate = self
        setUserImage()
        setupProfileImage()
        
    }
    
    func setUserImage() {
        self.profileImage.backgroundColor = .systemGray
        self.profileImage.image = image
        self.profileImage.contentMode = .scaleAspectFill
        
        scrollView.parallaxHeader.view = self.profileImage
        scrollView.parallaxHeader.height = 400
        scrollView.parallaxHeader.minimumHeight = 120
        scrollView.parallaxHeader.mode = .centerFill
        
        let roundIcon = UIImageView(
            frame: CGRect(x: 0, y: 0, width: 100, height: 100)
        )
        
        roundIcon.image = image
        roundIcon.layer.borderColor = UIColor.white.cgColor
        roundIcon.layer.borderWidth = 2
        roundIcon.layer.cornerRadius = roundIcon.frame.width / 2
        roundIcon.clipsToBounds = true
                
    }

}


//MARK: Profile Image Picker Extension
extension UserProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    func setupProfileImage() {
        profileImage.isUserInteractionEnabled = true
        profileImage.layer.masksToBounds = false
        profileImage.contentMode = .scaleAspectFill
        profileImage.layer.cornerRadius = profileImage.frame.height / 2
        profileImage.clipsToBounds = true
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(switchUserPhoto))
        singleTap.numberOfTouchesRequired = 1
        self.profileImage.addGestureRecognizer(singleTap)
    }

    @objc func switchUserPhoto() {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        self.profileImage.image = image
        dismiss(animated: true)
    }
}

extension UserProfileViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        UserDefaultsManager.setUserName(name: textField.text)
        textField.resignFirstResponder()
         
         return true
     }
    
}
