//
//  AchievementCollectionViewCell.swift
//  NoJones
//
//  Created by Albert Rayneer on 28/04/20.
//  Copyright © 2020 NoJones. All rights reserved.
//

import UIKit

//MARK: Collection View Cell
class AchievementCollectionViewCell: UICollectionViewCell {
    
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

