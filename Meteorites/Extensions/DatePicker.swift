//
//  DatePicker.swift
//  MeteoriteTest
//
//  Created by Namita on 9/5/21.
//  Copyright © 2021 Namita. All rights reserved.
//

import Foundation
import UIKit

class DatePicker : NSObject {
    
    var fromDate: Date?
    var toDate: Date?
    
    private lazy var pickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.backgroundColor = UIColor.white
        return pickerView
    }()
    
    var inputView: UIView {
        return pickerView
    }
    
    var didSelectDate: ((_ selectedDate: Date) -> Void)?
    
    let dateFormatter = DateFormatter()
    
    var dateCollection = [Date]()
    
    func setup() {
        dateFormatter.dateFormat = Constants.DateFormats.yyyy
        dateCollection = getYears(date: toDate ?? Date())
    }
    
    func getYears(date: Date) -> [Date]{
        
        var dates = [Date]()
        let calendar = Calendar.current
        var currentDate = date
        
        let yearDiff = calendar.date(byAdding: .year, value: -650, to: currentDate)
        
        // last date
        let endDate: Date = fromDate ?? yearDiff!
        
        while currentDate >= endDate {
          dates.append(currentDate)
          currentDate = calendar.date(byAdding: .year, value: -1, to: currentDate)!
        }
        
        return dates
    }
}

// MARK - UIPickerViewDelegate
extension DatePicker : UIPickerViewDelegate{
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let date = dateCollection[row]
        didSelectDate?(date)
    }
}

// MARK - UIPickerViewDataSource
extension DatePicker : UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1;
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dateCollection.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let label = formatDatePicker(date: dateCollection[row])
        return label
    }
    
    func formatDatePicker(date: Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Constants.DateFormats.yyyy
        return dateFormatter.string(from: date)
    }
}
