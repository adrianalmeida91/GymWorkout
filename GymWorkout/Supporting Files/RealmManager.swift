//
//  RealmManager.swift
//  GymWorkout
//
//  Created by Adrian de Almeida on 08/09/19.
//  Copyright © 2019 Adrian de Almeida. All rights reserved.
//

import Foundation
import RealmSwift

class RealmManager {
    private static let appRealmConfig = Realm.Configuration(
        schemaVersion: 0,
        deleteRealmIfMigrationNeeded: true
    )

    static func createRealmInstance() -> Realm {
        return try! Realm(configuration: RealmManager.appRealmConfig)
    }
}
