//
//  WorkoutBuildViewModel.swift
//  GymWorkout
//
//  Created by Adrian de Almeida on 08/09/19.
//  Copyright © 2019 Adrian de Almeida. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class WorkoutBuildViewModel {

    private let disposeBag = DisposeBag()
    private var databaseService: DatabaseService
    let workoutName = BehaviorRelay<String>(value: "")
    let workoutStartDate = BehaviorRelay<String>(value: "")
    let workoutEndDate = BehaviorRelay<String>(value: "")
    let isValid: Driver<Bool>

    init(databaseService: DatabaseService) {
        self.databaseService = databaseService
        isValid = Driver.combineLatest(workoutName.asDriver(), workoutStartDate.asDriver(), workoutEndDate.asDriver()) { (name, start, end) in
            return !(name.isEmpty || start.isEmpty || end.isEmpty)
        }
    }

    func createWorkout(workout: Workout) -> Completable {
        return databaseService.createWorkout(workout: workout)
    }
}
