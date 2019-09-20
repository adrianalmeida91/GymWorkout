//
//  Workout.swift
//  GymWorkout
//
//  Created by Adrian de Almeida on 02/09/19.
//  Copyright © 2019 Adrian de Almeida. All rights reserved.
//

import Foundation
import RealmSwift

@objcMembers class Workout: Object {
    dynamic var id = 0
    dynamic var name = ""
    dynamic var startDate = ""
    dynamic var endDate = ""
    @objc dynamic private var privateRadioButtonType = RadioButtonEnum.ab.rawValue
    var type: RadioButtonEnum {
        get { return RadioButtonEnum(rawValue: privateRadioButtonType)! }
        set { privateRadioButtonType = newValue.rawValue }
    }
    var exercices = List<Exercice>()

    override static func primaryKey() -> String? {
        return "id"
    }
}
