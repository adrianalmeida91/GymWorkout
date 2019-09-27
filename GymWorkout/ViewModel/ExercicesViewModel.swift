//
//  ExercicesViewModel.swift
//  GymWorkout
//
//  Created by Adrian de Almeida on 15/09/19.
//  Copyright © 2019 Adrian de Almeida. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class ExercicesViewModel {

    private var databaseService: DatabaseService

    init(databaseService: DatabaseService) {
        self.databaseService = databaseService
    }

    func removeExercice(workout: Workout, exerciceIndex: Int) -> Completable {
        return databaseService.removeExercice(workout: workout, exerciceIndex: exerciceIndex)
    }

    func updateExerciceWeight(workout: Workout, exerciceIndex: Int, value: String) -> Completable {
        return databaseService.updateExerciceWeight(workout: workout, exerciceIndex: exerciceIndex, value: value)
    }
}
