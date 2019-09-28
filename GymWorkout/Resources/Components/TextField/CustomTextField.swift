//
//  CustomTextField.swift
//  GymWorkout
//
//  Created by Adrian de Almeida on 02/09/19.
//  Copyright © 2019 Adrian de Almeida. All rights reserved.
//

import UIKit

protocol CustomTextFieldProtocol {
    var border: CALayer {get set}
    var hasError: Bool {get set}
    var hasFocus: Bool {get set}
    var errorView: UILabel? {get set}
}

extension CustomTextFieldProtocol where Self: UITextField {
    mutating func setErrorMessage(_ text: String) {
        if errorView == nil {
            errorView = UILabel(frame: CGRect(x: 0, y: self.frame.height + 4, width: 20, height: 14))
            errorView?.isAccessibilityElement = true
            errorView?.textColor = UIColor.red
            self.addSubview(errorView!)
        }
        self.clipsToBounds = false
        errorView?.isHidden = false
        errorView?.text = text
        errorView?.sizeToFit()
    }

    mutating func removeError() {
        errorView?.removeFromSuperview()
        errorView = nil
    }
}

class CustomTextField: UITextField, CustomTextFieldProtocol {
    var border: CALayer
    var hasError: Bool
    var hasFocus: Bool
    var errorView: UILabel?

    override init(frame: CGRect) {
        self.border = CALayer()
        self.hasError = false
        self.hasFocus = false
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        self.border = CALayer()
        self.hasError = false
        self.hasFocus = false
        super.init(coder: aDecoder)
    }
}
