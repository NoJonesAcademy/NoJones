//
//  DashboardViewController.swift
//  NoJones
//
//  Created by VInicius Mesquita on 20/04/20.
//  Copyright © 2020 NoJones. All rights reserved.
//

import UIKit

class DashboardViewController: UIViewController {
    
    var addictions = [
        Addiction(name: "Cigarro", days: 0, type: "Cronico"),
        Addiction(name: "Cigarro", days: 0, type: "Cronico"),
        Addiction(name: "Cigarro", days: 0, type: "Cronico"),
        Addiction(name: "Cigarro", days: 0, type: "Cronico"),
        Addiction(name: "Cigarro", days: 0, type: "Cronico")
    ]
    
    var achievements = [
        Achievement(image: UIImage(named: "achievement1"), name: "Welcome"),
        Achievement(image: UIImage(named: "achievement2-disable"), name: "OneDay"),
        Achievement(image: UIImage(named: "achievement3-disable"), name: "SevenDays"),
        Achievement(image: UIImage(named: "achievement4-disable"), name: "OneMonth"),
        Achievement(image: UIImage(named: "achievement5-disable"), name: "OneYear")
    ]
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var userAge: UILabel!
 
    
    @IBOutlet weak var addAddictionButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        if addictions.isEmpty {
            tableView.isScrollEnabled = false
            tableView.backgroundColor = .none
            tableView.separatorStyle = .none
        }
        tableView.rowHeight = 70
        
        
        collectionView.register(AchievementCell.self, forCellWithReuseIdentifier: "achievementCell")
        collectionView.dataSource = self
        tableView.dataSource = self
        
        
        profileImage.layer.masksToBounds = false
        profileImage.contentMode = .scaleAspectFill
        profileImage.layer.cornerRadius = profileImage.frame.height / 2
        profileImage.clipsToBounds = true
        setProfileImage()
        
    }
    
    
}

extension DashboardViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func setProfileImage() {
        self.profileImage.isUserInteractionEnabled = true
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


extension DashboardViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addictions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "addictionCell")
        
        cell.textLabel?.text = addictions[indexPath.row].name
        cell.detailTextLabel?.text = addictions[indexPath.row].type
        
        return cell
    }
}


extension DashboardViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return achievements.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "achievementCell", for: indexPath) as! AchievementCell
        
        cell.achievement = self.achievements[indexPath.row]
        
        return cell
    }
}


class AchievementCell: UICollectionViewCell {
    
    var achievement: Achievement? {
        didSet {
            guard let achievement = achievement else { return }
            background.image = achievement.image
        }
    }
    
    fileprivate let background: UIImageView = {
       let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        return imageView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(background)
        
        background.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        background.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        background.trailingAnchor.constraint(equalTo: contentView.trailingAnchor ).isActive = true
        background.bottomAnchor.constraint(equalTo: contentView.bottomAnchor ).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
