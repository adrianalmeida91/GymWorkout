//
//  ExerciceTableViewCell.swift
//  GymWorkout
//
//  Created by Adrian de Almeida on 16/09/19.
//  Copyright © 2019 Adrian de Almeida. All rights reserved.
//

import UIKit

class ExerciceTableViewCell: UITableViewCell {

    @IBOutlet weak var exerciceName: UILabel!
    @IBOutlet weak var seriesValue: UILabel!
    @IBOutlet weak var repetitionValue: UILabel!
    @IBOutlet weak var weightValue: UILabel!

    func setupExerciceCell(exercice: Exercice) {
        self.exerciceName.text = exercice.name
        self.seriesValue.text = "x\(exercice.series)"
        self.repetitionValue.text = exercice.repetitions
        self.weightValue.text = exercice.weight
    }
}
