//
//  WorkoutTableViewCell.swift
//  GymWorkout
//
//  Created by Adrian de Almeida on 09/09/19.
//  Copyright © 2019 Adrian de Almeida. All rights reserved.
//

import UIKit

class WorkoutTableViewCell: UITableViewCell {

    @IBOutlet weak var workoutName: UILabel!
    @IBOutlet weak var workoutType: UILabel!
    @IBOutlet weak var workoutStart: UILabel!
    @IBOutlet weak var workoutEnd: UILabel!

    func setLabels(workout: Workout) {
        self.workoutName.text = workout.name
        self.workoutStart.text = workout.startDate
        self.workoutEnd.text = workout.endDate
        switch workout.type {
        case RadioButtonEnum.abc:
            self.workoutType.text = "A/B/C"
        case RadioButtonEnum.abcd:
            self.workoutType.text = "A/B/C/D"
        default:
            self.workoutType.text = "A/B"
        }
    }
}
