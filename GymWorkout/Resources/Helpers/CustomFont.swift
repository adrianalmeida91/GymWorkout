//
//  CustomFont.swift
//  GymWorkout
//
//  Created by Adrian de Almeida on 12/09/19.
//  Copyright © 2019 Adrian de Almeida. All rights reserved.
//

import UIKit

struct CustomFont {
    static let systemMedium14 = UIFont.systemFont(ofSize: 14, weight: .medium)
    static let systemMedium20 = UIFont.systemFont(ofSize: 20, weight: .medium)
    static let systemRegular17 = UIFont.systemFont(ofSize: 17)
    static let systemBold16 = UIFont.boldSystemFont(ofSize: 16)
    static let systemBold17 = UIFont.boldSystemFont(ofSize: 17)
    static let systemRegular11 = UIFont.systemFont(ofSize: 11)
    static let systemBold11 = UIFont.boldSystemFont(ofSize: 11)
    static let systemRegular12 = UIFont.systemFont(ofSize: 12)
    static let systemRegular13 = UIFont.systemFont(ofSize: 13)
    static let systemRegular14 = UIFont.systemFont(ofSize: 14)
    static let systemRegular16 = UIFont.systemFont(ofSize: 16)
    static let systemBold13 = UIFont.boldSystemFont(ofSize: 13)
    static let systemBold14 = UIFont.boldSystemFont(ofSize: 14)
    static let systemBold20 = UIFont.systemFont(ofSize: 20.0, weight: .medium)

    struct DeleteConfirmAlerts {
        static let deleteBoldAlertButton: [NSAttributedString.Key: Any] = [.font: CustomFont.systemBold17, .foregroundColor: SystemColor.red.uiColor]
        static let regularAlertButton: [NSAttributedString.Key: Any] = [.font: CustomFont.systemRegular17, .foregroundColor: SystemColor.blue.uiColor]
    }

    struct AskNewWieghtAlerts {
        static let confirmBoldAlertButton: [NSAttributedString.Key: Any] = [.font: CustomFont.systemBold17, .foregroundColor: SystemColor.blue.uiColor]
        static let regularAlertButton: [NSAttributedString.Key: Any] = [.font: CustomFont.systemRegular17, .foregroundColor: SystemColor.blue.uiColor]
    }
}
