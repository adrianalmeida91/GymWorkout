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

    func showWorkoutBuild() {
        let workoutBuildViewController = navigationController?.viewControllers.filter { $0 is WorkoutBuildViewController }.first
        if let workoutBuildViewController = workoutBuildViewController {
            self.navigationController?.popToViewController(workoutBuildViewController, animated: true)
        } else {
            if let workoutBuildViewController = AppDelegate().container.resolve(WorkoutBuildViewController.self) {
                self.navigationController?.pushViewController(workoutBuildViewController, animated: true)
            }
        }
    }

    func showExercices(workout: Workout) {
        let exercicesViewController = navigationController?.viewControllers.filter { $0 is
            ExercicesViewController }.first
        if let exercicesViewController = exercicesViewController {
            self.navigationController?.popToViewController(exercicesViewController, animated: true)
        } else {
            if let exercicesViewController = AppDelegate().container.resolve(ExercicesViewController.self) {
                exercicesViewController.workout = workout
                self.navigationController?.pushViewController(exercicesViewController, animated: true)
            }
        }
    }

    func showExerciceCreate(workout: Workout, exerciceType: ExerciceType) {
        let exerciceCreateViewController = navigationController?.viewControllers.filter { $0 is
            ExerciceCreateViewController }.first
        if let exerciceCreateViewController = exerciceCreateViewController {
            self.navigationController?.popToViewController(exerciceCreateViewController, animated: true)
        } else {
            if let exerciceCreateViewController = AppDelegate().container.resolve(ExerciceCreateViewController.self) {
                exerciceCreateViewController.workout = workout
                exerciceCreateViewController.exerciceType = exerciceType
                self.navigationController?.pushViewController(exerciceCreateViewController, animated: true)
            }
        }
    }
}
