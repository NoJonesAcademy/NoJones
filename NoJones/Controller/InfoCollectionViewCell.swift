//
//  InfoCollectionViewCell.swift
//  NoJones
//
//  Created by Mateus Nobre Ferreira on 04/05/20.
//  Copyright © 2020 NoJones. All rights reserved.
//

import UIKit

class InfoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var opacityLayerView: UIView!
    @IBOutlet weak var text: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    public func configure(image: UIImage, text: String){
        backgroundImage.image = image
        self.text.text = text
        self.layer.cornerRadius = 15
        backgroundImage.layer.cornerRadius = 15
        opacityLayerView.layer.cornerRadius=15
    }

    static func nib() -> UINib {
            return UINib(nibName: "InfoCollectionCell", bundle: nil )
    }
}
