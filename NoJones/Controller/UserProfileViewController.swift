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
    
    @IBOutlet weak var scrollView: UIScrollView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        setUserImage()
        
    }
    
    func setUserImage() {
        let image = UIImage(named: "profileImage")
        let imageView = UIImageView()
        
        imageView.image = image
        imageView.contentMode = .scaleAspectFill
        
        scrollView.parallaxHeader.view = imageView
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
