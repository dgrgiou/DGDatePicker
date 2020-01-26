//
//  CalendarVC.swift
//  DGDatePicker
//
//  Created by Dimitris Georgiou on 10/10/19.
//  Copyright © 2019 Dimitris Georgiou. All rights reserved.
//

import UIKit
import JTAppleCalendar

public class CalendarVC: UIViewController {
    
    public weak var calendarDelegate: CalendarProtocol?

    // MARK: - Outlets | Properties
    @IBOutlet weak var mainBackgroundView: UIView!
    @IBOutlet weak var calendarView: JTAppleCalendarView!
    
    // MARK: CalendarView Outlets
    @IBOutlet weak var calendarTopHeaderView: UIView!
    @IBOutlet weak var calendarTopHeaderYearLabel: UILabel!
    @IBOutlet weak var calendarTopHeaderDateLabel: UILabel!
    @IBOutlet weak var scrollViewDateLabel: UILabel!
    @IBOutlet weak var mondayStackViewLabel: UILabel!
    @IBOutlet weak var tuesdayStackViewLabel: UILabel!
    @IBOutlet weak var wednesdayStackViewLabel: UILabel!
    @IBOutlet weak var thursdayStackViewLabel: UILabel!
    @IBOutlet weak var fridayStackViewLabel: UILabel!
    @IBOutlet weak var saturdayStackViewLabel: UILabel!
    @IBOutlet weak var sundayStackViewLabel: UILabel!
    @IBOutlet weak var cancelButtonOutlet: UIButton!
    @IBOutlet weak var doneButtonOutlet: UIButton!

    // MARK: - Public Properties
    open var mainCalendarColor: UIColor? = UIColor.colorWithHex(rgbValue: 0x3D8984)

    // MARK: Private Properties
    private let dateFormatter = DateFormatter()
    private var selectedDate = Date()
    private let calendarStartDate: String = "01/01/1900"
    private let calendarEndDate: String = "21/12/2052"

    // MARK: - UIView lifecycle
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.clear
        registerCalendarCell()
        scrollToCurrentDate()
        drawCalendarVCUI()
    }
    
    override public func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        self.view.backgroundColor = UIColor(white: 0, alpha: 0.5)
    }
    
    private func registerCalendarCell() {
        self.calendarView.register(UINib(nibName: "CalendarCell", bundle: Bundle(for: CalendarCell.self)),
                                   forCellWithReuseIdentifier: "calendarCell")
    }

    public init() {
        super.init(nibName: "CalendarVC", bundle: Bundle(for: CalendarVC.self))
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Draw Calendar UI
    
    private func drawCalendarVCUI() {
        
        self.mainBackgroundView.layer.cornerRadius = 4
        self.mainBackgroundView.clipsToBounds = true
        drawTopHeaderView()
        drawScrollView()
        drawVeryShortDatesStackView()
        drawButtons()
    }
    
    private func drawTopHeaderView() {
        // Calendar top header view
        self.calendarTopHeaderView.backgroundColor = mainCalendarColor
        
        // Calendar top header Year label
        self.calendarTopHeaderYearLabel.text = DateHelper().getYearFromDate(self.selectedDate)
        self.calendarTopHeaderYearLabel.textColor = UIColor.white
        
        // Calendar top header Date label
        self.calendarTopHeaderDateLabel.text =
            DateHelper().getCalendarDateOfWeekFromDate(self.selectedDate)
        self.calendarTopHeaderDateLabel.textColor = UIColor.white
    }
    
    private func drawScrollView() {
        self.scrollViewDateLabel.text =
            DateHelper().getMonthAndYearStringFromDate(self.selectedDate)
    }
    
    private func drawVeryShortDatesStackView() {
        let veryShortWeekdaySymbols: [String] = DateHelper().getVeryShortWeekdaysSymbols()
        
        self.sundayStackViewLabel.text = veryShortWeekdaySymbols[0]
        self.mondayStackViewLabel.text = veryShortWeekdaySymbols[1]
        self.tuesdayStackViewLabel.text = veryShortWeekdaySymbols[2]
        self.wednesdayStackViewLabel.text = veryShortWeekdaySymbols[3]
        self.thursdayStackViewLabel.text = veryShortWeekdaySymbols[4]
        self.fridayStackViewLabel.text = veryShortWeekdaySymbols[5]
        self.saturdayStackViewLabel.text = veryShortWeekdaySymbols[6]
        
        self.sundayStackViewLabel.textColor = UIColor.lightGray
        self.mondayStackViewLabel.textColor = UIColor.lightGray
        self.tuesdayStackViewLabel.textColor = UIColor.lightGray
        self.wednesdayStackViewLabel.textColor = UIColor.lightGray
        self.thursdayStackViewLabel.textColor = UIColor.lightGray
        self.fridayStackViewLabel.textColor = UIColor.lightGray
        self.saturdayStackViewLabel.textColor = UIColor.lightGray
    }
    
    private func drawButtons() {
        // Cancel button Outlet
        self.cancelButtonOutlet.setTitle(NSLocalizedString("Cancel", comment: ""), for: .normal)
        self.cancelButtonOutlet.setTitleColor(mainCalendarColor, for: .normal)
        
        // Done button Outlet
        self.doneButtonOutlet.setTitle(NSLocalizedString("OK", comment: ""), for: .normal)
        self.doneButtonOutlet.setTitleColor(mainCalendarColor, for: .normal)
    }
    
    private func updateScrollView(forDates visibleDates: DateSegmentInfo) {
        
        // Get the first date from the visibleDates array
        let visibleDate = visibleDates.monthDates[0].date
        self.scrollViewDateLabel.text =
            DateHelper().getMonthAndYearStringFromDate(visibleDate)
    }
    
    // MARK: - Calendar View Actions
    
    @IBAction func scrollToPreviousMonthTapped(_ sender: Any) {
        self.calendarView.scrollToSegment(.previous)
    }
    
    @IBAction func scrollToNextMonthTapped(_ sender: Any) {
        self.calendarView.scrollToSegment(.next)
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func doneButtonTapped(_ sender: Any) {
        
        self.calendarDelegate?.calendarDidClosed(selectedDate: selectedDate)
        self.dismiss(animated: true, completion: nil)
    }
    
    // Scroll to today
    private func scrollToCurrentDate() {
        self.calendarView.scrollToDate(self.selectedDate, animateScroll: false)
        self.calendarView.selectDates([self.selectedDate], triggerSelectionDelegate: false)
    }
}

// MARK: - JTAppleCalendar DataSource

extension CalendarVC: JTAppleCalendarViewDataSource {
    
    public func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        
        calendar.scrollDirection = .horizontal
        calendar.showsHorizontalScrollIndicator = false
        calendar.scrollingMode = .stopAtEachSection
        
        let startDate = DateHelper().getDateFromStringDate_ddMMyyyy(self.calendarStartDate)
        let endDate = DateHelper().getDateFromStringDate_ddMMyyyy(self.calendarEndDate)
        let calendarParamenters = ConfigurationParameters(startDate: startDate,
                                                          endDate: endDate,
                                                          generateInDates: .forAllMonths,
                                                          generateOutDates: .tillEndOfRow,
                                                          firstDayOfWeek: .monday)
        
        return calendarParamenters
    }
}

// MARK: - JTAppleCalendar Delegete methods & Helpers

extension CalendarVC: JTAppleCalendarViewDelegate {
    
    public func calendar(_ calendar: JTAppleCalendarView,
                  cellForItemAt date: Date,
                  cellState: CellState,
                  indexPath: IndexPath) -> JTAppleCell {
        
        let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "calendarCell",
                                                       for: indexPath) as! CalendarCell
        
        // Configure calendar view date cells
        configureCalendarCell(cell: cell, cellState: cellState)
        configureSelectedCell(cell: cell, cellState: cellState)
        hideDates(cell: cell, cellState: cellState)
        
        return cell
    }
    
    public func calendar(_ calendar: JTAppleCalendarView,
                  willDisplay cell: JTAppleCell,
                  forItemAt date: Date,
                  cellState: CellState,
                  indexPath: IndexPath) {
        
    }
    
    public func calendar(_ calendar: JTAppleCalendarView,
                  didScrollToDateSegmentWith visibleDates: DateSegmentInfo) {
        updateScrollView(forDates: visibleDates)
    }
    
    public func calendar(_ calendar: JTAppleCalendarView,
                  didSelectDate date: Date,
                  cell: JTAppleCell?,
                  cellState: CellState) {
        
        self.selectedDate = date
        drawTopHeaderView()
        guard let selectedCell = cell as? CalendarCell else {return}
        configureSelectedCell(cell: selectedCell, cellState: cellState)
    }
    
    public func calendar(_ calendar: JTAppleCalendarView,
                  didDeselectDate date: Date,
                  cell: JTAppleCell?,
                  cellState: CellState) {
        
        guard let selectedCell = cell as? CalendarCell else {return}
        configureSelectedCell(cell: selectedCell, cellState: cellState)
    }
    
    // MARK: Helping private methods
    
    /// Configure calendar cell
    private func configureCalendarCell(cell: JTAppleCell?, cellState: CellState) {
        
        guard let cell = cell as? CalendarCell  else { return }
        cell.calendarDateLabel.text = cellState.text
    }
    
    /// Hide dates that do not belong to visible month
    private func hideDates(cell: CalendarCell, cellState: CellState) {
        if cellState.dateBelongsTo == .thisMonth {
            cell.isHidden = false
        } else {
            cell.isHidden = true
        }
    }
    
    /// Configure the selected cell background view UI
    private func configureSelectedCell(cell: CalendarCell, cellState: CellState) {
        
        if cellState.isSelected {
            cell.calendarDateBackView.backgroundColor = self.mainCalendarColor
            cell.calendarDateLabel.textColor = UIColor.white
        } else {
            cell.calendarDateBackView.backgroundColor = UIColor.clear
            cell.calendarDateLabel.textColor = UIColor.black
            
        }
    }
}
