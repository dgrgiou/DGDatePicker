//
//  DateHelper.swift
//  DGDatePicker
//
//  Created by Dimitris Georgiou on 12/10/19.
//  Copyright © 2019 Dimitris Georgiou. All rights reserved.
//

import Foundation

final class DateHelper: NSObject {
    
    let dateFormatter = DateFormatter()
    
    // MARK: - Date -> String convertions
    
    /// Method to return a darte string representation e.g 01/01/2019 from a date
    ///
    /// - Parameter date: The given date
    /// - Returns: A date string in format e.g 01/01/2019
    func getStringFromDate_ddMMyyyy(date: Date) -> String {
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let dateString = dateFormatter.string(from: date)
        
        return dateString
    }
    
    /// Method to return year string eg. 2019 from a given date
    ///
    /// - Parameter date: The given date
    /// - Returns: A string with the year value as String
    func getYearFromDate(_ date: Date) -> String {
        dateFormatter.dateFormat = "yyyy"
        let yearString = dateFormatter.string(from: date)
        
        return yearString
    }
    
    /// Method to return the three first letters of a week date, separated with comma,
    /// followed by the date number and the month with the first 3 letters as string
    //  eg. Mon, 1 Jan
    ///
    /// - Parameter date: The given date
    /// - Returns: A string date representation as Mon, 1 Jan
    func getCalendarDateOfWeekFromDate(_ date: Date) -> String {
        dateFormatter.dateFormat = "EE, dd MMM"
        let dateString = dateFormatter.string(from: date)
        
        return dateString
    }
    
    /// Method to return month and year as string from a date e.g January 2019
    ///
    /// - Parameter date: The given date
    /// - Returns: A string with date as January 2019
    func getMonthAndYearStringFromDate(_ date: Date) -> String {
        dateFormatter.dateFormat = "MMMM yyyy"
        let dateString = dateFormatter.string(from: date)
        
        return dateString
    }
    
    // MARK: - String -> Date convertions
    
    /// Method to return a date from a given string value in dd/MM/yyyy format
    ///
    /// - Parameter stringDate: The given string date
    /// - Returns: a Date
    func getDateFromStringDate_ddMMyyyy(_ stringDate: String) -> Date {
        dateFormatter.dateFormat = "dd/MM/yyyy"
        dateFormatter.timeZone = Calendar.current.timeZone
        dateFormatter.locale = Calendar.current.locale
        
        return dateFormatter.date(from: stringDate)!
    }
    
    /// Returns all the short week days symbols in an array
    /// e.g ["S", "M", "T", "W", "T", "F", "S"]
    ///
    /// - Returns: An array of string with all short week days symbols
    func getVeryShortWeekdaysSymbols() -> [String] {
        return dateFormatter.veryShortWeekdaySymbols
    }
}
