//
//  DatabaseService.swift
//  GymWorkout
//
//  Created by Adrian de Almeida on 08/09/19.
//  Copyright © 2019 Adrian de Almeida. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RealmSwift
import RxRealm

class DatabaseService {
    init() {
    }

    func createWorkout(workout: Workout) -> Completable {
        return Completable.create { completable in
            DispatchQueue.main.async {
                do {
                    let realm = RealmManager.createRealmInstance()
                    workout.id = self.incrementWorkoutID()
                    try realm.write {
                        realm.add(workout)
                    }
                    completable(.completed)
                } catch {
                    completable(.error(error))
                }
            }
            return Disposables.create()
        }
    }

    private func incrementWorkoutID() -> Int {
        let realm = RealmManager.createRealmInstance()
        return (realm.objects(Workout.self).max(ofProperty: "id") as Int? ?? 0) + 1
    }

    func loadWorkouts() -> Results<Workout> {
        let realm = RealmManager.createRealmInstance()
        return realm.objects(Workout.self)
    }

    func deleteWorkout(workout: Workout) -> Completable {
        return Completable.create { completable in
            DispatchQueue.main.async {
                do {
                    let realm = RealmManager.createRealmInstance()
                    try realm.write {
                        realm.delete(workout)
                    }
                    completable(.completed)
                } catch {
                    completable(.error(error))
                }
            }
            return Disposables.create()
        }
    }

    func createExercice(workout: Workout, exercice: Exercice) -> Completable {
        return Completable.create { completable in
            DispatchQueue.main.async {
                do {
                    let realm = RealmManager.createRealmInstance()
                    try realm.write {
                        workout.exercices.append(exercice)
                    }
                    completable(.completed)
                } catch {
                    completable(.error(error))
                }
            }
            return Disposables.create()
        }
    }

    func removeExercice(workout: Workout, exerciceIndex: Int) -> Completable {
        return Completable.create { completable in
            DispatchQueue.main.async {
                do {
                    let realm = RealmManager.createRealmInstance()
                    try realm.write {
                        workout.exercices.remove(at: exerciceIndex)
                    }
                    completable(.completed)
                } catch {
                    completable(.error(error))
                }
            }
            return Disposables.create()
        }
    }
}
