//
//  ExerciceCreateViewController.swift
//  GymWorkout
//
//  Created by Adrian de Almeida on 17/09/19.
//  Copyright © 2019 Adrian de Almeida. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ExerciceCreateViewController: BaseViewController {

    @IBOutlet weak var saveExercice: UIBarButtonItem!
    @IBOutlet weak var exerciceName: UITextField!
    @IBOutlet weak var exerciceSeries: UITextField!
    @IBOutlet weak var exerciceRepetitions: UITextField!
    @IBOutlet weak var exerciceWeight: CustomSliderView!
    @IBOutlet weak var nameErrorLabel: UILabel!
    @IBOutlet weak var seriesErrorLabel: UILabel!
    @IBOutlet weak var repetitionsErrorLabel: UILabel!

    private var disposeBag = DisposeBag()
    var viewModel: ExerciceCreateViewModel!
    var workout: Workout? = nil
    var exerciceType = ExerciceType.a
    private var isFieldValid = false

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    func setupViews() {
        exerciceName.delegate = self
        exerciceSeries.delegate = self
        exerciceRepetitions.delegate = self
        exerciceName.rx.text.orEmpty.bind(to: viewModel.exerciceName).disposed(by: disposeBag)
        exerciceSeries.rx.text.orEmpty.bind(to: viewModel.exerciceSeries).disposed(by: disposeBag)
        exerciceRepetitions.rx.text.orEmpty.bind(to: viewModel.exerciceRepetitions).disposed(by: disposeBag)
        exerciceWeight.weightSlider.rx.value.subscribe(onNext: { value in
            self.viewModel.exerciceWeight.accept(String(Int(value)))
        }).disposed(by: disposeBag)
        viewModel.isValid.drive(onNext: { isValid in
            self.isFieldValid = isValid
        }).disposed(by: disposeBag)
        saveExercice.rx.tap.bind {
            if self.exerciceName.text?.isEmpty ?? false {
                self.nameErrorLabel.isHidden = false
            }
            if self.exerciceSeries.text?.isEmpty ?? false {
                self.seriesErrorLabel.isHidden = false
            }
            if self.exerciceRepetitions.text?.isEmpty ?? false {
                self.repetitionsErrorLabel.isHidden = false
            }
            if self.isFieldValid {
                self.createExercice()
            }
        }.disposed(by: disposeBag)
    }

    func createExercice() {
        let exercice = Exercice()
        exercice.name = self.exerciceName.text!
        exercice.series = self.exerciceSeries.text!
        exercice.repetitions = self.exerciceRepetitions.text!
        exercice.weight = self.exerciceWeight.getWeight()
        exercice.type = self.exerciceType

        if let workout = workout {
            self.viewModel.createExercice(workout: workout, exercice: exercice).subscribe({ result in
                switch result {
                case .completed:
                    self.showExercices(workout: workout)
                case .error(let error):
                    print("\(error)")
                }
            }).disposed(by: self.disposeBag)
        }
    }
}

extension ExerciceCreateViewController: UITextFieldDelegate {
    internal func textFieldDidBeginEditing(_ textField: UITextField) {
        clearTextFields(textField)
    }

    func clearTextFields(_ textField: UITextField) {
        if textField === exerciceName {
            nameErrorLabel.isHidden = true
        } else if textField === exerciceSeries {
            seriesErrorLabel.isHidden = true
        } else if textField === exerciceRepetitions {
            repetitionsErrorLabel.isHidden = true
        }
    }
}
