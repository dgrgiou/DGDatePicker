//
//  CalendarProtocol.swift
//  DGDatePicker
//
//  Created by Dimitris Georgiou on 12/10/19.
//  Copyright © 2019 Dimitris Georgiou. All rights reserved.
//

import Foundation

public protocol CalendarProtocol: class {
    func calendarDidClosed(selectedDate: Date)
}
