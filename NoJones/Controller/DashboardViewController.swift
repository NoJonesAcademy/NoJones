//
//  DashboardViewController.swift
//  NoJones
//
//  Created by Albert Rayneer on 20/04/20.
//  Copyright © 2020 NoJones. All rights reserved.
//

import UIKit

class DashboardViewController: InitialScreenViewController {
    
    //MARK: Collection and Table Data from Model
    var addictions = [
        Addiction(name: "Cigarro", days: 0, type: "Cronico"),
        Addiction(name: "Cigarro", days: 0, type: "Cronico"),
        Addiction(name: "Cigarro", days: 0, type: "Cronico")
        ]
        {
        didSet {
            noAddictionMessage.frame.size.height = self.addictions.isEmpty ? 220 : 0
        }
    }
    
    var achievements = [
        Achievement(image: UIImage(named: "achievement1"), name: "Welcome"),
        Achievement(image: UIImage(named: "achievement2-disable"), name: "OneDay"),
        Achievement(image: UIImage(named: "achievement3-disable"), name: "SevenDays"),
        Achievement(image: UIImage(named: "achievement4-disable"), name: "OneMonth"),
        Achievement(image: UIImage(named: "achievement5-disable"), name: "OneYear")
    ]
    
    //MARK: IBOutlets
    private var profileImageView = UIImageView(image: UIImage(named: "profileImage")!.withRenderingMode(.alwaysTemplate))
    private var userName = UserDefaultsManager.fetchString(withUserDefaultKey: .userName)
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var noAddictionMessage: UIView!
    var observer: NSKeyValueObservation?

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        showImage(true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        showImage(false)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backButton = UIBarButtonItem()
        backButton.title = "Dashboard"
        navigationItem.backBarButtonItem = backButton
    }
    
    //MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
       
        collectionView.register(AchievementCollectionViewCell.self, forCellWithReuseIdentifier: "achievementCell")
        collectionView.dataSource = self
        
        self.observer = self.navigationController?.navigationBar.observe(\.bounds, options: [.new], changeHandler: { (navigationBar, changes) in
            if let height = changes.newValue?.height {
                if height > 44.0 {
                    //Large Title
                    self.title = "Olá, \(self.userName!)"
                } else {
                    //Small Title
                    self.title = "Dashboard"
                }
            }
        })
        
        setupTableView()
        setupUI()
    }
    
    //MARK: Table View Properties
    func setupTableView() {
        tableView.rowHeight = 70
        tableView.dataSource = self
        tableView.delegate = self
        let sectionNib = UINib(nibName: HabitsSectionHeader.xibName, bundle: nil)
        tableView.register(sectionNib, forHeaderFooterViewReuseIdentifier: HabitsSectionHeader.identifier)
        
        noAddictionMessage.frame.size.height = self.addictions.isEmpty ? 220 : 0
        //setProfileImage()
        //        if let userName = UserDefaultsManager.fetchString(withUserDefaultKey: .userName) {
        //            self.username.text = userName
        //        }
        
    }
}

extension DashboardViewController {
    
    /// WARNING: Change these constants according to your project's design
    private struct Const {
        /// Image height/width for Large NavBar state
        static let ImageSizeForLargeState: CGFloat = 40
        /// Margin from right anchor of safe area to right anchor of Image
        static let ImageRightMargin: CGFloat = 16
        /// Margin from bottom anchor of NavBar to bottom anchor of Image for Large NavBar state
        static let ImageBottomMarginForLargeState: CGFloat = 12
        /// Margin from bottom anchor of NavBar to bottom anchor of Image for Small NavBar state
        static let ImageBottomMarginForSmallState: CGFloat = 6
        /// Image height/width for Small NavBar state
        static let ImageSizeForSmallState: CGFloat = 32
        /// Height of NavBar for Small state. Usually it's just 44
        static let NavBarHeightSmallState: CGFloat = 44
        /// Height of NavBar for Large state. Usually it's just 96.5 but if you have a custom font for the title, please make sure to edit this value since it changes the height for Large state of NavBar
        static let NavBarHeightLargeState: CGFloat = 96.5
    }
    
    /**
     Setup the image in navbar to be on the same line as the navbar title
     */
    private func setupUI() {
        // Initial setup for image for Large NavBar state since the the screen always has Large NavBar once it gets opened
        guard let navigationBar = self.navigationController?.navigationBar else { return }
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(profileScreenSegue))
        singleTap.numberOfTouchesRequired = 1
        self.profileImageView.addGestureRecognizer(singleTap)
        profileImageView.isUserInteractionEnabled = true
        profileImageView.tintColor = UIColor(named: "buttonColor")

        navigationBar.addSubview(profileImageView)
        
        
        
        // setup constraints
        profileImageView.layer.cornerRadius = Const.ImageSizeForLargeState / 2
        profileImageView.clipsToBounds = true
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            profileImageView.rightAnchor.constraint(equalTo: navigationBar.rightAnchor, constant: -Const.ImageRightMargin),
            profileImageView.bottomAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: -Const.ImageBottomMarginForLargeState),
            profileImageView.heightAnchor.constraint(equalToConstant: Const.ImageSizeForLargeState),
            profileImageView.widthAnchor.constraint(equalTo: profileImageView.heightAnchor)
        ])
    }
    
    @objc func profileScreenSegue() {
        performSegue(withIdentifier: "profileSegue", sender: nil)
    }
    
    private func showImage(_ show: Bool) {
      UIView.animate(withDuration: 0.2) {
        self.profileImageView.alpha = show ? 1.0 : 0.0
      }
    }
    
    private func moveAndResizeImage(for height: CGFloat) {
        let coeff: CGFloat = {
            let delta = height - Const.NavBarHeightSmallState
            let heightDifferenceBetweenStates = (Const.NavBarHeightLargeState - Const.NavBarHeightSmallState)
            return delta / heightDifferenceBetweenStates
        }()
        
        let factor = Const.ImageSizeForSmallState / Const.ImageSizeForLargeState
        
        let scale: CGFloat = {
            let sizeAddendumFactor = coeff * (1.0 - factor)
            return min(1.0, sizeAddendumFactor + factor)
        }()
        
        // Value of difference between icons for large and small states
        let sizeDiff = Const.ImageSizeForLargeState * (1.0 - factor) // 8.0
        let yTranslation: CGFloat = {
            /// This value = 14. It equals to difference of 12 and 6 (bottom margin for large and small states). Also it adds 8.0 (size difference when the image gets smaller size)
            let maxYTranslation = Const.ImageBottomMarginForLargeState - Const.ImageBottomMarginForSmallState + sizeDiff
            return max(0, min(maxYTranslation, (maxYTranslation - coeff * (Const.ImageBottomMarginForSmallState + sizeDiff))))
        }()
        
        let xTranslation = max(0, sizeDiff - coeff * sizeDiff)
        
        profileImageView.transform = CGAffineTransform.identity
            .scaledBy(x: scale, y: scale)
            .translatedBy(x: xTranslation, y: yTranslation)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let height = navigationController?.navigationBar.frame.height else { return }
        moveAndResizeImage(for: height)
    }
}



//MARK: Table View Delegate and Data Source
extension DashboardViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "detailSegue", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addictions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "addictionCell")
        
        cell.textLabel?.text = addictions[indexPath.row].name
        cell.detailTextLabel?.text = addictions[indexPath.row].type
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    //Section Header Height
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    //Section Header View
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: HabitsSectionHeader.identifier) as! HabitsSectionHeader
        header.section.text = "Hábitos"
        header.addAddictionButton.addTarget(self, action: #selector(addAddiction), for: .touchUpInside)
        
        return header
    }
    //Add Addiction Action Button
    @objc func addAddiction() {
        performSegue(withIdentifier: "addAddictionSegue", sender: nil)
        
        //Insert new Row
        //        let newAddiction = Addiction(name: "Games", days: 0, type: "Tech", done: false)
        //        addictions.insert(newAddiction, at: 0)
        //        tableView.beginUpdates()
        //        let indexPath = IndexPath(row: 0, section: 0)
        //        tableView.insertRows(at: [indexPath], with: .left)
        //        tableView.endUpdates()
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let doneAction = UIContextualAction(style: .normal, title: "Feito"){ (_, _, success) in
            print("Habito feito")
            success(true)
        }
        doneAction.backgroundColor = UIColor(named: "buttonColor")
        let configure = UISwipeActionsConfiguration(actions: [doneAction])
        configure.performsFirstActionWithFullSwipe = false
        return configure
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


