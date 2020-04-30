//
//  DayWeekCustomView.swift
//  NoJones
//
//  Created by Vinicius Mesquita on 30/04/20.
//  Copyright © 2020 NoJones. All rights reserved.
//

import UIKit

class DayWeekCustomView: UIView {
    
    @IBOutlet weak var CircleView: UIView!
    @IBOutlet weak var dayWeek: UILabel!
    
    
    var contentView: UIView?
    var xibName = "DayWeekCustomView"
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupXib()
    }
    
    private func setupXib() {
        guard let view = loadViewFromNib() else {
            fatalError("Wrong xib name")
        }
        view.frame = self.bounds
        self.addSubview(view)
        contentView = view
    }
    
    
    func loadViewFromNib() -> UIView? {
        let bundle = Bundle(for: type(of: self))
        
        let nib = UINib(nibName: xibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
}
