//
//  BaseViewController.swift
//  GymWorkout
//
//  Created by Adrian de Almeida on 08/09/19.
//  Copyright © 2019 Adrian de Almeida. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    func showWorkout() {
        let workoutViewController = navigationController?.viewControllers.filter { $0 is WorkoutViewController }.first
        if let workoutViewController = workoutViewController {
            self.navigationController?.popToViewController(workoutViewController, animated: true)
        } else {
            if let workoutViewController = AppDelegate().container.resolve(WorkoutViewController.self) {
                self.navigationController?.pushViewController(workoutViewController, animated: true)
            }
        }
    }

    func showWorkoutCreate() {
        let workoutCreateViewController = navigationController?.viewControllers.filter { $0 is WorkoutCreateViewController }.first
        if let workoutCreateViewController = workoutCreateViewController {
            self.navigationController?.popToViewController(workoutCreateViewController, animated: true)
        } else {
            if let workoutCreateViewController = AppDelegate().container.resolve(WorkoutCreateViewController.self) {
                self.navigationController?.pushViewController(workoutCreateViewController, animated: true)
            }
        }
    }
}
