//
//  AskNewWeightAlert.swift
//  GymWorkout
//
//  Created by Adrian de Almeida on 26/09/19.
//  Copyright © 2019 Adrian de Almeida. All rights reserved.
//

import UIKit

class AskNewWeightAlert: CustomAlert, CustomAlertProtocol {
    var navigationController: UINavigationController!
    var onConfirm: ((String) -> Void)?

    init(title: String, message: String) {
        super.init(frame: UIScreen.main.bounds)
        initialize(title: title, message: message)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func initialize(title: String, message: String) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = NSTextAlignment.center
        initialize(title: title.toAttributedText(attributes: [NSAttributedString.Key.foregroundColor: SystemColor.primaryColor.uiColor]),
                   message: message.toAttributedText(attributes: [NSAttributedString.Key.foregroundColor: UIColor.white]),
                   isTextField: true,
                   type: ModalButtonType.horizontal,
                   firstButtonText: "Cancelar".toAttributedText(attributes: CustomFont.AskNewWieghtAlerts.regularAlertButton),
                   secondButtonText: "Confirmar".toAttributedText(attributes: CustomFont.AskNewWieghtAlerts.confirmBoldAlertButton))
        buttonsDelegate = self
        dismissOnTouchOutside = false
    }

    func show(navigationController: UINavigationController, onConfirm: @escaping ((String) -> Void)) {
        self.navigationController = navigationController
        self.onConfirm = onConfirm
        self.textfield.becomeFirstResponder()
        sizeToFit()
        show(animated: true)
    }

    func alertFirstButtonTapped(alert: CustomAlert) {
        // do nothing
    }

    func alertSecondButtonTapped(alert: CustomAlert) {
        // do nothing
    }

    func alertTextFieldSecondButtonTapped(alert: CustomAlert, value: String) {
        onConfirm?(value)
    }

    func alertDismissed(alert: CustomAlert) {
        // do nothing
    }
}
