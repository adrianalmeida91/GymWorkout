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
                    workout.id = self.incrementID()
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

    private func incrementID() -> Int {
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
}
