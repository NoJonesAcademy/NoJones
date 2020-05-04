//
//  InfoCollectionViewCell.swift
//  NoJones
//
//  Created by Mateus Nobre Ferreira on 04/05/20.
//  Copyright © 2020 NoJones. All rights reserved.
//

import UIKit

class InfoCollectionViewCell: UICollectionViewCell {
    override func awakeFromNib() {
        super.awakeFromNib()
        self.sizeToFit()
        // Initialization code
    }
    
    public func configure(with image: UIImage){
        //backgroundImage.image = image
        self.layer.borderWidth = 2
        self.layer.cornerRadius = 15
    }

    static func nib() -> UINib {
            return UINib(nibName: "InfoCollectionCell", bundle: nil )
    }
}
