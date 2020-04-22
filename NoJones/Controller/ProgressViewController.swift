//
//  ProgressViewController.swift
//  NoJones
//
//  Created by VInicius Mesquita on 20/04/20.
//  Copyright © 2020 NoJones. All rights reserved.
//

import UIKit
import CVCalendar

class ProgressViewController: UIViewController {
    
    @IBOutlet weak var menuView: CVCalendarMenuView!
    @IBOutlet weak var calendarView: CVCalendarView!
    @IBOutlet weak var monthLabel: UILabel!
    private var currentCalendar: Calendar?
    
    override func awakeFromNib() {
        let timeZoneBias = 480 // (UTC+08:00)
        currentCalendar = Calendar(identifier: .gregorian)
        currentCalendar?.locale = Locale(identifier: "fr_FR")
        if let timeZone = TimeZone(secondsFromGMT: -timeZoneBias * 60) {
            currentCalendar?.timeZone = timeZone
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationItem.largeTitleDisplayMode = .never
        setupViews()
        
        if let currentCalendar = currentCalendar {
            monthLabel.text = CVDate(date: Date(), calendar: currentCalendar).globalDescription

        }
        
    }
    
    override func viewDidLayoutSubviews() {
        
        menuView.commitMenuViewUpdate()
        calendarView.commitCalendarViewUpdate()
    }


    func setupViews() {
        menuView.backgroundColor = .none
        calendarView.backgroundColor = .none
    }
}

typealias CalendarDelegate = CVCalendarMenuViewDelegate &
    CVCalendarViewDelegate &
    CVCalendarViewAppearanceDelegate

extension ProgressViewController: CalendarDelegate {
    
    // MARK: Configuration Calendar
    
    func presentationMode() -> CalendarMode { return .monthView }
    
    func firstWeekday() -> Weekday { return .sunday }
    
    func presentedDateUpdated(_ date: CVDate) {
        self.monthLabel.text = date.globalDescription
    }
    
    func shouldShowWeekdaysOut() -> Bool {
        true
    }
    
    // MARK: Appearance Calendar
    
    func dayLabelWeekdayDisabledColor() -> UIColor { return .lightGray }
       
    func dayOfWeekTextColor() -> UIColor { return .gray }
    
    
}
