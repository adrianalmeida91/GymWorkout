//
//  Exercices.swift
//  GymWorkout
//
//  Created by Adrian de Almeida on 15/09/19.
//  Copyright © 2019 Adrian de Almeida. All rights reserved.
//

import Foundation
import RealmSwift

@objcMembers class Exercice: Object {
    dynamic var name = ""
    dynamic var series = ""
    dynamic var repetitions = ""
    dynamic var weight = ""
    @objc dynamic private var privateExerciceType = ExerciceType.a.rawValue
    var type: ExerciceType {
        get { return ExerciceType(rawValue: privateExerciceType)! }
        set { privateExerciceType = newValue.rawValue }
    }
}
