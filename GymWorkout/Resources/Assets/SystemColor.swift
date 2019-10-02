//
//  SystemColor.swift
//  GymWorkout
//
//  Created by Adrian de Almeida on 01/09/19.
//  Copyright © 2019 Adrian de Almeida. All rights reserved.
//

import Foundation
import UIKit

enum SystemColor {
    
    case red
    case orange
    case yellow
    case green
    case tealBlue
    case blue
    case purple
    case pink
    case dialogDefaulBackground
    case appBackground
    case defaultGreenColor
    case primaryColor
    case secondaryColor
    case defaultYellowColor
    case backgroundDefaultGray
    case textfieldPlaceholderDefault
    case textfieldTextColorDefault
    case lineSeparator
    
    var uiColor: UIColor {
        switch self {
        case .red:
            return UIColor(red: 255/255, green: 59/255, blue: 48/255, alpha: 1)
        case .orange:
            return UIColor(red: 255/255, green: 149/255, blue: 0/255, alpha: 1)
        case .yellow:
            return UIColor(red: 255/255, green: 204/255, blue: 0/255, alpha: 1)
        case .green:
            return UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        case .tealBlue:
            return UIColor(red: 90/255, green: 200/255, blue: 250/255, alpha: 1)
        case .blue:
            return UIColor(red: 0/255, green: 122/255, blue: 255/255, alpha: 1)
        case .purple:
            return UIColor(red: 88/255, green: 86/255, blue: 214/255, alpha: 1)
        case .pink:
            return UIColor(red: 255/255, green: 45/255, blue: 85/255, alpha: 1)
        case .dialogDefaulBackground:
            return UIColor(red: 216/255, green: 216/255, blue: 216/255, alpha: 1)
        case .appBackground:
            return UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1)
        case .defaultGreenColor:
            return UIColor(red: 183/255, green: 255/255, blue: 27/255, alpha: 1)
        case .primaryColor:
            return UIColor(red: 132/255, green: 165/255, blue: 218/255, alpha: 1)
        case .secondaryColor:
            return UIColor(red: 232/255, green: 154/255, blue: 25/255, alpha: 1)
        case . defaultYellowColor:
            return UIColor(red: 250/255, green: 240/255, blue: 45/255, alpha: 1)
        case . backgroundDefaultGray:
            return UIColor(red: 0, green: 0, blue: 0, alpha: 0.2)
        case . textfieldPlaceholderDefault:
            return UIColor(red: 1, green: 1, blue: 1, alpha: 0.5)
        case . textfieldTextColorDefault:
            return UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        case . lineSeparator:
            return UIColor(red: 1, green: 1, blue: 1, alpha: 0.4)
        }
    }
    
}
