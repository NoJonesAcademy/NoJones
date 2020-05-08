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
    
    var habits: [Habit]?
    
    
    override func awakeFromNib() {
        if let currentCalendar = currentCalendar {
            let month = CVDate(date: Date(), calendar: currentCalendar).month - 1
            let year = CVDate(date: Date(), calendar: currentCalendar).year
            
            let monthCapitalized = currentCalendar.monthSymbols[month].capitalized
            monthLabel.text = "\(monthCapitalized)  \(year)"
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchHabits()
        setupCalendarViews()
        
        self.calendarView.calendarAppearanceDelegate = self
        
        self.calendarView.animatorDelegate = self
        
        self.menuView.menuViewDelegate = self
        
        self.calendarView.calendarDelegate = self
    }
    
    override func viewDidLayoutSubviews() {
        
        menuView.commitMenuViewUpdate()
        calendarView.commitCalendarViewUpdate()
    }
    
    func fetchHabits() {
        let habitDao = CoreDao<Habit>(with: "Habit")
        habits = habitDao.fetchAll()
    }


    func setupCalendarViews() {
        currentCalendar = Calendar.current
        currentCalendar!.locale = Locale(identifier: "pt_BR")
        menuView.calendar = currentCalendar!
        
        menuView.backgroundColor = .none
        calendarView.backgroundColor = .none
    }
    
    // MARK: Buttons Actions
    
    @IBAction func rightArrowButton(_ sender: UIButton) {
        calendarView.loadNextView()
    }
    
    @IBAction func leftArrowButton(_ sender: Any) {
        calendarView.loadPreviousView()
    }
    
    
}

typealias CalendarDelegates = CVCalendarMenuViewDelegate & CVCalendarViewDelegate

extension ProgressViewController: CalendarDelegates {
    
    // MARK: Configuration Calendar
    
    func presentationMode() -> CalendarMode { return .monthView }
    
    func firstWeekday() -> Weekday { return .sunday }
    
    func shouldShowWeekdaysOut() -> Bool { true }
    
    func presentedDateUpdated(_ date: CVDate) {
        let year = date.year
        let monthCapitalized = currentCalendar!.monthSymbols[date.month - 1].capitalized
        self.monthLabel.text = "\(monthCapitalized)  \(year)"
    }
    
    func dotMarker(shouldShowOnDayView dayView: DayView) -> Bool {
        guard let habits = habits else {
          return false
        }
        
        for habit in habits {
            let dates = habit.dates?.allObjects as! [DateHabit]
            
            for date in dates {
                if date.data == dayView.date.convertedDate(calendar: currentCalendar!) {
                    return true
                }
            }
        }
        return false
    }

    func dotMarker(sizeOnDayView dayView: DayView) -> CGFloat {
        return 20.0
    }
    
    func dotMarker(moveOffsetOnDayView dayView: DayView) -> CGFloat {
        return 3.0
    }
    
    func dotMarker(shouldMoveOnHighlightingOnDayView dayView: DayView) -> Bool {
        return false
    }
    
    func didSelectDayView(_ dayView: DayView, animationDidFinish: Bool) {
        // some action when click day
    }
}

extension ProgressViewController: CVCalendarViewAppearanceDelegate {
    
    // MARK: Appearance Calendar
    
    func dayLabelWeekdayDisabledColor() -> UIColor { return .lightGray }
       
    func dayOfWeekTextColor() -> UIColor { return .gray }
    
    func dayLabelBackgroundColor(by weekDay: Weekday, status: CVStatus, present: CVPresent) -> UIColor? {
        if status == .selected {
            return UIColor.init(named: "buttonColor")
        }
        
        if status == .disabled {
            return .brown
        }
        return .cyan
    }
    
    func dotMarker(colorOnDayView dayView: DayView) -> [UIColor] { return [.brown, .darkGray, .gray] }
    
    
}
