//
//  String.swift
//  GymWorkout
//
//  Created by Adrian de Almeida on 12/09/19.
//  Copyright © 2019 Adrian de Almeida. All rights reserved.
//

import Foundation
import UIKit

extension String {
    func toAttributedText(attributes: [NSAttributedString.Key: Any]? = nil) -> NSAttributedString {
        return NSAttributedString(string: self, attributes: attributes)
    }
}
