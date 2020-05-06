//
//  HabitDetailsViewController.swift
//  NoJones
//
//  Created by Vinicius Mesquita on 28/04/20.
//  Copyright © 2020 NoJones. All rights reserved.
//

import UIKit
import CVCalendar

class HabitDetailsViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var habitName: UILabel!
    @IBOutlet weak var competitorHabitName: UILabel!
    
    var habit: Habit?
    
    override func viewWillAppear(_ animated: Bool) {
        configureViews()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        self.scrollView.contentOffset = .zero
        configureHabitDetails()
        
    }
    
    func configureViews() {
        
        var currentCalendar = Calendar.current
        currentCalendar.locale = Locale(identifier: "pt-BR")
        
        let views = stackView.arrangedSubviews
        
        let date = CVDate(date: Date(), calendar: currentCalendar)
        let daysWeek = currentCalendar.shortWeekdaySymbols
        
        for (index, day) in daysWeek.enumerated() {
            
            let customView = views[index] as? DayWeekCustomView
            customView?.dayWeek.text = day.capitalized
            customView?.imageMark.image = UIImage(named: "checkmark")
            customView?.contentView?.backgroundColor = .none

            
        }
        
        if let dayWeek = date.weekDay()?.rawValue {
            let customView = views[dayWeek - 1] as? DayWeekCustomView
            customView?.contentView?.backgroundColor =  .systemBlue
            customView?.imageMark.image = .none

        }
        
    }
    
    
    func configureHabitDetails() {
        habitName.text = habit?.name
        competitorHabitName.text = habit?.concurrent?.name
    }

}
