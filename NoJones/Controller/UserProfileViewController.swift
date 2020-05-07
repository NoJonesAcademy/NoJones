//
//  UserProfileViewController.swift
//  NoJones
//
//  Created by Albert Rayneer on 04/05/20.
//  Copyright © 2020 NoJones. All rights reserved.
//

import UIKit
import ParallaxHeader
import SnapKit

class UserProfileViewController: UIViewController {
    
    var image = UIImage(named: "emptyProfile")
    let profileImage = UIImageView()
    let roundIcon = UIImageView(
        frame: CGRect(x: 0, y: 0, width: 100, height: 100)
    )
    
    var user: User?
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var userAge: UITextField!
    
    let userDao = CoreDao<User>(with: "User")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never

        userName.text = UserDefaultsManager.fetchString(withUserDefaultKey: .userName)
        
        user = userDao.fetchAll().first
        if let user = self.user {
            userAge.text = String(user.age) + " anos"
        }

        userName.delegate = self
        setUserImage()
        setupProfileImageAction()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification:NSNotification) {

        let userInfo = notification.userInfo!
        var keyboardFrame:CGRect = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)

        contentInset = self.scrollView.contentInset
        changeHeight = keyboardFrame.size.height + view.frame.size.height/6
        contentInset.bottom = changeHeight
        scrollView.contentInset = contentInset
    }

    var contentInset:UIEdgeInsets = UIEdgeInsets()
    var changeHeight: CGFloat = CGFloat()
    
    @objc func keyboardWillHide(notification:NSNotification){

        contentInset.bottom -= changeHeight
        scrollView.contentInset = contentInset
    }
    
    func setUserImage() {
        self.profileImage.backgroundColor = .systemGray
        self.profileImage.image = image
        self.profileImage.contentMode = .scaleAspectFill
        self.profileImage.blurView.enable()
        // fetch data from user
        
        do {
            
            if let imageData = user?.profileImage {
                self.image = UIImage(data: imageData)
                self.profileImage.image = self.image
                self.roundIcon.image = self.image
            }
            
        }
        
        
        
        scrollView.parallaxHeader.view = self.profileImage
        scrollView.parallaxHeader.height = 400
        scrollView.parallaxHeader.minimumHeight = 120
        scrollView.parallaxHeader.mode = .centerFill
        scrollView.parallaxHeader.parallaxHeaderDidScrollHandler = { parallaxHeader in
            //update alpha of blur view on top of image view
            parallaxHeader.view.blurView.alpha = 1 - parallaxHeader.progress
        }
        
        
        self.roundIcon.image = image
        self.roundIcon.layer.cornerRadius = roundIcon.frame.width / 2
        self.roundIcon.clipsToBounds = true
        
        //add round image view to blur content view
        //do not use vibrancyContentView to prevent vibrant effect
        self.profileImage.blurView.blurContentView?.addSubview(roundIcon)
        
        //add constraints using SnpaKit library
        roundIcon.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(100)
        }
    }
}


//MARK: Profile Image Picker Extension
extension UserProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    func setupProfileImageAction() {
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
        self.roundIcon.image = image
    
        if let currentUser = userDao.fetchAll().first {
            currentUser.profileImage = image.pngData()
            userDao.save()
        }
        
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
