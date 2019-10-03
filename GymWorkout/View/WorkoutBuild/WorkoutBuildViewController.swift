//
//  WorkoutBuildViewController.swift
//  GymWorkout
//
//  Created by Adrian de Almeida on 01/09/19.
//  Copyright © 2019 Adrian de Almeida. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class WorkoutBuildViewController: BaseViewController {

    @IBOutlet weak var nameTextField: CustomTextField!
    @IBOutlet weak var startTextField: CustomTextField!
    @IBOutlet weak var endTextField: CustomTextField!
    @IBOutlet weak var saveWorkout: UIBarButtonItem!
    @IBOutlet weak var radioButtonGroup: RadioButtonView!
    @IBOutlet weak var nameErrorLabel: UILabel!
    @IBOutlet weak var startErrorLabel: UILabel!
    @IBOutlet weak var endErrorLabel: UILabel!

    private var disposeBag = DisposeBag()
    private var activeTextField: UITextField? = nil
    private var isFieldValid = false
    var viewModel: WorkoutBuildViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    func setupViews() {
        nameTextField.delegate = self
        nameTextField.tintColor = UIColor.white
        setupPicker(textField: self.startTextField)
        setupPicker(textField: self.endTextField)
        nameTextField.rx.text.orEmpty.bind(to: viewModel.workoutName).disposed(by: disposeBag)
        startTextField.rx.text.orEmpty.bind(to: viewModel.workoutStartDate).disposed(by: disposeBag)
        endTextField.rx.text.orEmpty.bind(to: viewModel.workoutEndDate).disposed(by: disposeBag)
        viewModel.isValid.drive(onNext: { isValid in
            self.isFieldValid = isValid
        }).disposed(by: disposeBag)
        saveWorkout.rx.tap.bind {
            if self.nameTextField.text?.isEmpty ?? false {
                self.nameErrorLabel.isHidden = false
            }
            if self.startTextField.text?.isEmpty ?? false {
                self.startErrorLabel.isHidden = false
            }
            if self.endTextField.text?.isEmpty ?? false {
                self.endErrorLabel.isHidden = false
            }
            if self.isFieldValid {
                self.createWorkout()
            }
        }.disposed(by: disposeBag)
    }

    func setupPicker(textField: CustomTextField) {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let flexible = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: self, action: nil)
        let done = UIBarButtonItem(title: "OK", style: UIBarButtonItem.Style.done, target: nil, action: #selector(textField.actionKeyboardButtonTapped(sender:)))
        toolbar.setItems([flexible, done], animated: false)
        let datePicker = UIDatePicker()
        datePicker.locale = Locale.init(identifier: "pt_BR")
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(WorkoutBuildViewController.datePickerValueChanged(sender:)), for: UIControl.Event.valueChanged)
        textField.inputAccessoryView = toolbar
        textField.inputView = datePicker
        textField.tintColor = UIColor.clear
        textField.delegate = self
    }

    @objc func datePickerValueChanged(sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateStyle = DateFormatter.Style.medium
        formatter.timeStyle = DateFormatter.Style.none
        formatter.locale = Locale.init(identifier: "pt_BR")
        if let activeTextField = activeTextField {
            activeTextField.attributedText = NSAttributedString(string: formatter.string(from: sender.date), attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        }
    }

    func createWorkout() {
        let workout = Workout()
        workout.name = self.nameTextField.text!
        workout.startDate = self.startTextField.text!
        workout.endDate = self.endTextField.text!
        workout.type = self.radioButtonGroup.radioButtonSelected.value

        self.viewModel.createWorkout(workout: workout).subscribe({ result in
            switch result {
            case .completed:
                self.showWorkout()
            case .error(let error):
                print("\(error)")
            }
        }).disposed(by: self.disposeBag)
    }
}

extension WorkoutBuildViewController: UITextFieldDelegate {
    internal func textFieldDidBeginEditing(_ textField: UITextField) {
        clearTextFields(textField)
        if textField === startTextField || textField === endTextField {
            activeTextField = textField
            if textField.text?.isEmpty ?? false {
                let datePickerToday = UIDatePicker()
                self.datePickerValueChanged(sender: datePickerToday)
            }
        } else {
            activeTextField = nil
        }
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        clearTextFields(textField)
        let customTextField = textField as! CustomTextField
        if (customTextField.lenght == 0) { return true }
        let currentString: NSString = textField.text! as NSString
        let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= customTextField.lenght
    }

    @objc func donePressed(sender: Any) {
        view.endEditing(true)
    }

    func clearTextFields(_ textField: UITextField) {
        if textField === nameTextField {
            nameErrorLabel.isHidden = true
        } else if textField === startTextField {
            startErrorLabel.isHidden = true
        } else if textField === endTextField {
            endErrorLabel.isHidden = true
        }
    }
}
