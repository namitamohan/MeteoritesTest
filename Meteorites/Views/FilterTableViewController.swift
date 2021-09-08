//
//  FilterTableViewController.swift
//  MeteoriteTest
//
//  Created by Namita on 9/5/21.
//  Copyright © 2021 Namita. All rights reserved.
//

import UIKit

class FilterTableViewController: UITableViewController {
    
    @IBOutlet weak var fromYearTextField: UITextField!
    
    @IBOutlet weak var sortByNameButton: UIButton!
    
    @IBOutlet weak var sortByMassButton: UIButton!
    
    @IBOutlet weak var sortByYearButton: UIButton!
    
    private lazy var yearDatePicker: DatePicker = {
        let picker = DatePicker()
        picker.fromDate = "1400".toDate(format: Constants.DateFormats.yyyy)
        picker.toDate = Date()
        picker.setup()
        picker.didSelectDate = { [weak self] (selectedDate) in
            self?.fromYearTextField.text = self?.formatDate(date: selectedDate)
        }
        return picker
    }()
    
    var filters: MeteoriteFilters!
    
    var saveFilters: ((_ selectedFilters: MeteoriteFilters) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    func setupViews() {
        title = Constants.Titles.filterTitle
        tableView.tableFooterView = UIView()
        fromYearTextField.text = filters.fromYear ?? "1400"
        
        switch filters.sortBy {
        case .name:
            sortByNameButton.isSelected = true
        case .mass:
            sortByMassButton.isSelected = true
        case .year:
            sortByYearButton.isSelected = true
        }
        
        setupDatePicker()
        
        let saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveButtonAction))
        navigationItem.rightBarButtonItem  = saveButton
    }
    
    func setupDatePicker() {
        fromYearTextField.inputView = yearDatePicker.inputView
    }
    
    func formatDate(date: Date) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Constants.DateFormats.yyyy
        return dateFormatter.string(from: date)
    }
    
    @objc func saveButtonAction() {
        filters.fromYear = fromYearTextField.text
        self.saveFilters?(self.filters)
        navigationController?.popViewController(animated: true)
    }

    @IBAction func sortByNameAction(_ sender: Any) {
        filters.sortBy = .name
        sortByNameButton.isSelected = !sortByNameButton.isSelected
        sortByMassButton.isSelected = false
        sortByYearButton.isSelected = false
    }
    
    @IBAction func sortByMassAction(_ sender: Any) {
        filters.sortBy = .mass
        sortByMassButton.isSelected = !sortByMassButton.isSelected
        sortByNameButton.isSelected = false
        sortByYearButton.isSelected = false
    }
    
    @IBAction func sortByYearAction(_ sender: Any) {
        filters.sortBy = .year
        sortByYearButton.isSelected = !sortByYearButton.isSelected
        sortByNameButton.isSelected = false
        sortByMassButton.isSelected = false
    }
    
    @objc func doneDatePicker(){
        fromYearTextField.endEditing(true)
    }
}

extension FilterTableViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let toolBar = UIToolbar(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: self.view.frame.width, height: CGFloat(44))))
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneDatePicker))

        toolBar.setItems([space,doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        toolBar.sizeToFit()

        textField.inputAccessoryView = toolBar
    }
}
