//
//  DashboardViewController.swift
//  NoJones
//
//  Created by VInicius Mesquita on 20/04/20.
//  Copyright © 2020 NoJones. All rights reserved.
//

import UIKit

class DashboardViewController: UIViewController {
    
    //MARK: Collection and Table Data from Model
    var addictions = [
        Addiction(name: "Cigarro", days: 0, type: "Cronico"),
        Addiction(name: "Cigarro", days: 0, type: "Cronico"),
        Addiction(name: "Cigarro", days: 0, type: "Cronico"),
        Addiction(name: "Cigarro", days: 0, type: "Cronico"),
        Addiction(name: "Cigarro", days: 0, type: "Cronico"),
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
    
    //MARK: IBOutlets
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var userAge: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(AchievementCollectionViewCell.self, forCellWithReuseIdentifier: "achievementCell")
        collectionView.dataSource = self

        setupTableView()
        setupProfileImage()
        
    }
    
    func setupTableView() {
        tableView.rowHeight = 70
        tableView.dataSource = self
        tableView.delegate = self
        let sectionNib = UINib(nibName: HabitsSectionHeader.xibName, bundle: nil)
        tableView.register(sectionNib, forHeaderFooterViewReuseIdentifier: HabitsSectionHeader.identifier)
    }
}

//MARK: Profile Image Picker Extension
extension DashboardViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func setupProfileImage() {
        profileImage.layer.masksToBounds = false
        profileImage.contentMode = .scaleAspectFill
        profileImage.layer.cornerRadius = profileImage.frame.height / 2
        profileImage.clipsToBounds = true
        
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

//MARK: Table View Delegate and Data SourceY
extension DashboardViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addictions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "addictionCell")
        
        cell.textLabel?.text = addictions[indexPath.row].name
        cell.detailTextLabel?.text = addictions[indexPath.row].type
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    //Section Header Height
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 32
    }
    //Section Header View
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: HabitsSectionHeader.identifier) as! HabitsSectionHeader
        header.section.text = "Hábitos"
        header.addAddictionButton.addTarget(self, action: #selector(addAddiction), for: .allTouchEvents)
        
        return header
    }
    //AddAddictionAction
    @objc func addAddiction(_ sender: UIButton!) {
        performSegue(withIdentifier: "addAddictionSegue", sender: nil)
    }
    
    //Deleting Cells
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        tableView.beginUpdates()
        addictions.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .right)
        tableView.endUpdates()
    }

}

//MARK: Collection View Delegate and Data Source
extension DashboardViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return achievements.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "achievementCell", for: indexPath) as! AchievementCollectionViewCell
        
        cell.achievement = self.achievements[indexPath.row]
        
        return cell
    }
}


