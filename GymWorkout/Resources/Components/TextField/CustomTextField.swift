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

class CustomTextField: UITextField, CustomTextFieldProtocol  {
    var border: CALayer
    var hasError: Bool
    var hasFocus: Bool
    var errorView: UILabel?
    var lenght: Int = 0

    @objc
    @IBOutlet open weak var nextResponderField: UIResponder?

    @IBInspectable var maxLenght: Int {
        get { return lenght }
        set{ lenght = newValue }
    }

    @IBInspectable var cornerRadius: Double = 0.0 {
        didSet {
           self.layer.cornerRadius = CGFloat(cornerRadius)
         }
    }

    @IBInspectable var borderWidth: Double = 0.0 {
          didSet {
           self.layer.borderWidth = CGFloat(borderWidth)
          }
    }

    @IBInspectable var borderColor: UIColor = UIColor.clear {
         didSet {
            self.layer.borderColor = borderColor.cgColor
         }
    }

    let textPadding: UIEdgeInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)

    override init(frame: CGRect) {
        self.border = CALayer()
        self.hasError = false
        self.hasFocus = false
        super.init(frame: frame)
        self.initialize()
    }

    required init?(coder aDecoder: NSCoder) {
        self.border = CALayer()
        self.hasError = false
        self.hasFocus = false
        super.init(coder: aDecoder)
        self.initialize()
    }

    func initialize() {
        self.backgroundColor = SystemColor.backgroundDefaultGray.uiColor
        self.textColor = SystemColor.textfieldTextColorDefault.uiColor
        self.attributedPlaceholder = NSAttributedString(string: self.placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor: SystemColor.textfieldPlaceholderDefault.uiColor])
        self.addTarget(self, action: #selector(actionKeyboardButtonTapped(sender:)), for: .editingDidEndOnExit)
    }

    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: textPadding)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: textPadding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: textPadding)
    }

    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if action == #selector(paste(_:)) ||
            action == #selector(cut(_:)) ||
            action == #selector(copy(_:)) ||
            action == #selector(select(_:)) ||
            action == #selector(selectAll(_:)) ||
            action == #selector(delete(_:)) ||
            action == #selector(makeTextWritingDirectionLeftToRight(_:)) ||
            action == #selector(makeTextWritingDirectionRightToLeft(_:)) ||
            action == #selector(toggleBoldface(_:)) ||
            action == #selector(toggleItalics(_:)) ||
            action == #selector(toggleUnderline(_:)) {
            return false
        }
        return super.canPerformAction(action, withSender: sender)
    }

    @objc func actionKeyboardButtonTapped(sender: UITextField) {
        switch nextResponderField {
        case let button as UIButton where button.isEnabled:
            button.sendActions(for: .touchUpInside)
        case .some(let responder):
            responder.becomeFirstResponder()
        default:
            resignFirstResponder()
        }
    }
}

extension CustomTextField: UITextViewDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if (self.lenght == 0) { return true }
        let currentString: NSString = textField.text! as NSString
        let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= self.lenght
    }
}
