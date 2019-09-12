//
//  WorkoutViewModel.swift
//  GymWorkout
//
//  Created by Adrian de Almeida on 08/09/19.
//  Copyright © 2019 Adrian de Almeida. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class WorkoutViewModel {

    let workoutsRelay = BehaviorRelay<[Workout]>(value: [])
    var workouts: Driver<[Workout]> {
        return workoutsRelay.asDriver()
    }
    private var databaseService: DatabaseService

    init(databaseService: DatabaseService) {
        self.databaseService = databaseService
    }

    func loadWorkouts() {
        workoutsRelay.accept(databaseService.loadWorkouts().toArray())
    }

    func removeWorkout(workout: Workout) -> Completable {
        return databaseService.deleteWorkout(workout: workout)
    }
}
