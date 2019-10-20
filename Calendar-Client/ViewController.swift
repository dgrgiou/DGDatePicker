//
//  ViewController.swift
//  Calendar-Client
//
//  Created by Dimitris Georgiou on 20/10/19.
//  Copyright © 2019 Dimitris Georgiou. All rights reserved.
//

import UIKit
import DGDatePicker

class ViewController: UIViewController, CalendarProtocol {

    @IBOutlet weak var showCalendarButton: UIButton!

    // MARK: - UIView life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    // MARK: - Private Outlet actions
    @IBAction func showCalendarPressed(_ sender: Any) {
        let calendarVC = CalendarVC()
        calendarVC.modalPresentationStyle = .overCurrentContext
        calendarVC.calendarDelegate = self
        present(calendarVC, animated: true, completion: nil)
    }

    func calendarDidClosed(selectedDate: Date) {
        print(selectedDate)
    }
}

