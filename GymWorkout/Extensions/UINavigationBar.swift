//
//  UINavigationBar.swift
//  GymWorkout
//
//  Created by Adrian de Almeida on 28/09/19.
//  Copyright © 2019 Adrian de Almeida. All rights reserved.
//

import Foundation
import UIKit

extension UINavigationBar {
    func transparentNavigationBar() {
        // Sets background to a blank/empty image
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        // Sets shadow (line below the bar) to a blank image
        UINavigationBar.appearance().shadowImage = UIImage()
        // Sets the translucent background color
        UINavigationBar.appearance().backgroundColor = .clear
        // Set translucent. (Default value is already true, so this can be removed if desired.)
        UINavigationBar.appearance().isTranslucent = true
        // Set title color
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor : SystemColor.defaultGreenColor.uiColor]
        // Set icons bar colors
        UINavigationBar.appearance().tintColor = SystemColor.primaryColor.uiColor
    }

    func primaryNavigationBar() {
        // Sets background to a blank/empty image
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        // Sets shadow (line below the bar) to a blank image
        UINavigationBar.appearance().shadowImage = UIImage()
        // Sets the translucent background color
        UINavigationBar.appearance().backgroundColor = SystemColor.primaryColor.uiColor
        UINavigationBar.appearance().barTintColor = SystemColor.primaryColor.uiColor
        // Set translucent. (Default value is already true, so this can be removed if desired.)
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().clipsToBounds = false
        // Set title color
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        // Set icons bar colors
        UINavigationBar.appearance().tintColor = UIColor.white
    }
}
