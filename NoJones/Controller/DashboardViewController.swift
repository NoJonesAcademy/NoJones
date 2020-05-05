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
            showEmptyStateIllustration()
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
    private var userName: String?
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var noAddictionMessage: UIView!
    var observer: NSKeyValueObservation?
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        self.userName = UserDefaultsManager.fetchString(withUserDefaultKey: .userName)
        setTitle()
        
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
        
        setupTableView()
        setupUserImage()
        showEmptyStateIllustration()
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func setTitle() {
        self.navigationItem.title = "Olá, \(self.userName!)"
        self.observer = self.navigationController?.navigationBar.observe(\.bounds, options: [.new], changeHandler: { (navigationBar, changes) in
            if let height = changes.newValue?.height {
                if let username = self.userName, height > 44.0 {
                    //Large Title
                    self.navigationItem.title = "Olá, \(username)"
                } else {
                    //Small Title
                    self.navigationItem.title = "Dashboard"
                }
            }
        })
    }
    
    //MARK: Table View Properties
    func setupTableView() {
        tableView.rowHeight = 70
        tableView.dataSource = self
        tableView.delegate = self
        let sectionNib = UINib(nibName: HabitsSectionHeader.xibName, bundle: nil)
        tableView.register(sectionNib, forHeaderFooterViewReuseIdentifier: HabitsSectionHeader.identifier)
<<<<<<< HEAD
        showEmptyStateIllustration()
        
    }
    
    func showEmptyStateIllustration() {
        noAddictionMessage.frame.size.height = self.addictions.isEmpty ? Constants.dashBoardTableViewHeaderHeight.rawValue : 0
=======
        
        noAddictionMessage.frame.size.height = self.addictions.isEmpty ? 220 : 0
        //setProfileImage()
      
        if let userName = UserDefaultsManager.fetchString(withUserDefaultKey: .bornDate) {
            self.username.text = userName
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let habitsDetailsViewController = segue.destination as? HabitDetailsViewController
        if let viewController = habitsDetailsViewController {
            viewController.habits = addictions
        }
>>>>>>> ca87d07bf13c2af268f6a9aef73e1dcb0793a6da
    }
}

//MARK: Profile Image Edit Extension
extension DashboardViewController {
    
    private enum Constants: CGFloat {
        case dashBoardTableViewHeaderHeight = 220
        case imageSizeForLargeState = 40
        case imageRightMargin = 16
        case imageBottomMarginForLargeState = 12
        case imageBottomMarginForSmallState = 6
        case imageSizeForSmallState = 32
        case navBarHeightSmallState = 44
        case navBarHeightLargeState = 96.5
    }
    

    private func setupUserImage() {
        // Initial setup for image for Large NavBar state since the the screen always has Large NavBar once it gets opened
        guard let navigationBar = self.navigationController?.navigationBar else { return }
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(profileScreenSegue))
        singleTap.numberOfTouchesRequired = 1
        self.profileImageView.addGestureRecognizer(singleTap)
        profileImageView.isUserInteractionEnabled = true
        profileImageView.tintColor = UIColor(named: "buttonColor")
        
        navigationBar.addSubview(profileImageView)
        
        // setup constraints
        profileImageView.layer.cornerRadius = Constants.imageSizeForLargeState.rawValue / 2
        profileImageView.clipsToBounds = true
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            profileImageView.rightAnchor.constraint(equalTo: navigationBar.rightAnchor, constant: -Constants.imageRightMargin.rawValue),
            profileImageView.bottomAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: -Constants.imageBottomMarginForLargeState.rawValue),
            profileImageView.heightAnchor.constraint(equalToConstant: Constants.imageSizeForLargeState.rawValue),
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
            let delta = height - Constants.navBarHeightSmallState.rawValue
            let heightDifferenceBetweenStates = (Constants.navBarHeightLargeState.rawValue - Constants.navBarHeightSmallState.rawValue)
            return delta / heightDifferenceBetweenStates
        }()
        
        let factor = Constants.imageSizeForSmallState.rawValue / Constants.imageSizeForLargeState.rawValue
        
        let scale: CGFloat = {
            let sizeAddendumFactor = coeff * (1.0 - factor)
            return min(1.0, sizeAddendumFactor + factor)
        }()
        
        // Value of difference between icons for large and small states
        let sizeDiff = Constants.imageSizeForLargeState.rawValue * (1.0 - factor) // 8.0
        let yTranslation: CGFloat = {
            /// This value = 14. It equals to difference of 12 and 6 (bottom margin for large and small states). Also it adds 8.0 (size difference when the image gets smaller size)
            let maxYTranslation = Constants.imageBottomMarginForLargeState.rawValue - Constants.imageBottomMarginForSmallState.rawValue + sizeDiff
            return max(0, min(maxYTranslation, (maxYTranslation - coeff * (Constants.imageBottomMarginForSmallState.rawValue + sizeDiff))))
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
        performSegue(withIdentifier: SegueDestination.HabitDetails.rawValue, sender: self)
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
