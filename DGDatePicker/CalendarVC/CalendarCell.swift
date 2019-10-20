//
//  CalendarCell.swift
//  DGDatePicker
//
//  Created by Dimitris Georgiou on 10/10/19.
//  Copyright © 2019 Dimitris Georgiou. All rights reserved.
//

import UIKit
import JTAppleCalendar

class CalendarCell: JTAppleCell {

    @IBOutlet weak var calendarDateBackView: UIView!
    @IBOutlet weak var calendarDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        customizeCellUI()
    }

    private func customizeCellUI() {
        
        // Set date cell width and height
        self.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        
        // CalendarDate back view (selected date area)
        calendarDateBackView.layer.cornerRadius = calendarDateBackView.frame.size.width / 2
        calendarDateBackView.clipsToBounds = true
        
        // CalendarDate label
        calendarDateLabel.textAlignment = .center
    }
}
