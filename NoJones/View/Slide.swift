//
//  Slide.swift
//  NoJones
//
//  Created by Joseph on 04/05/20.
//  Copyright © 2020 NoJones. All rights reserved.
//

import UIKit

class Slide: UIView {

    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var title: UITextView!
    @IBOutlet weak var content: UITextView!
    
    var page: Page? = nil {
        
        didSet {
            imageView.image = UIImage(named: page?.image ?? "onboarding1" )
            title.text = page?.title
            content.text = page?.content
        }
    }
    
}
