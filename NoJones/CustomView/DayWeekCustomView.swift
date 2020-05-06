//
//  DayWeekCustomView.swift
//  NoJones
//
//  Created by Vinicius Mesquita on 30/04/20.
//  Copyright © 2020 NoJones. All rights reserved.
//

import UIKit

public class DayWeekCustomView: UIView {
    
    @IBOutlet weak private var circleView: UIView!
    @IBOutlet weak public var imageMark: UIImageView!
    @IBOutlet weak public var dayWeek: UILabel!
    
    var contentView: UIView?
    var xibName = "DayWeekCustomView"
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupXib()
        self.contentView?.backgroundColor = UIColor(named: "buttonColor")
        self.contentView?.layer.cornerRadius = 6
        circleView.layer.cornerRadius = circleView.frame.height / 2
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
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
