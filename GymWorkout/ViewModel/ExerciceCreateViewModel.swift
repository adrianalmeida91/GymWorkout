//
//  ExerciceCreateViewModel.swift
//  GymWorkout
//
//  Created by Adrian de Almeida on 17/09/19.
//  Copyright © 2019 Adrian de Almeida. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class ExerciceCreateViewModel {

    private var databaseService: DatabaseService
    let exerciceName = BehaviorRelay<String>(value: "")
    let exerciceSeries = BehaviorRelay<String>(value: "")
    let exerciceRepetitions = BehaviorRelay<String>(value: "")
    let exerciceWeight = BehaviorRelay<String>(value: "")
    let isValid: Driver<Bool>

    init(databaseService: DatabaseService) {
        self.databaseService = databaseService
        isValid = Driver.combineLatest(exerciceName.asDriver(), exerciceSeries.asDriver(), exerciceRepetitions.asDriver(), exerciceWeight.asDriver()) { (name, series, repetitions, weight) in
            return !(name.isEmpty || series.isEmpty || repetitions.isEmpty || weight.isEmpty)
        }
    }

    func createExercice(workout: Workout, exercice: Exercice) -> Completable {
        return databaseService.createExercice(workout: workout, exercice: exercice)
    }
}
