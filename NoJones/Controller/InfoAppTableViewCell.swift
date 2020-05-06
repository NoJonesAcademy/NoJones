//
//  InfoAppTableViewCell.swift
//  NoJones
//
//  Created by Mateus Nobre Ferreira on 05/05/20.
//  Copyright © 2020 NoJones. All rights reserved.
//

import UIKit

class InfoAppTableViewCell: UITableViewCell {

    
    @IBOutlet weak var backgroundImageCell: UIImageView!
    @IBOutlet weak var appMaiorView: UIView!
    @IBOutlet weak var opacityLayerView: UIView!
    
    
    override func awakeFromNib() {
        backgroundImageCell.layer.cornerRadius = 15
        appMaiorView.layer.cornerRadius = 15
        opacityLayerView.layer.cornerRadius = 15
        backgroundImageCell.image = #imageLiteral(resourceName: "usingSmartphone")
        
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
