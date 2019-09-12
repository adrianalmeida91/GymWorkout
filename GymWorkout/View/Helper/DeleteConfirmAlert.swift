//
//  DeleteConfirmAlert.swift
//  GymWorkout
//
//  Created by Adrian de Almeida on 12/09/19.
//  Copyright © 2019 Adrian de Almeida. All rights reserved.
//

import UIKit

class DeleteConfirmAlert: CustomAlert, CustomAlertProtocol {
    var navigationController: UINavigationController!
    var onConfirm: (() -> Void)?

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
        initialize(title: title.toAttributedText(),
                   message: message.toAttributedText(),
                   type: ModalButtonType.horizontal,
                   firstButtonText: "Cancelar".toAttributedText(attributes: CustomFont.DeleteConfirmAlerts.regularAlertButton),
                   secondButtonText: "Deletar".toAttributedText(attributes: CustomFont.DeleteConfirmAlerts.deleteBoldAlertButton))
        buttonsDelegate = self
        dismissOnTouchOutside = false
    }

    func show(navigationController: UINavigationController, onConfirm: @escaping (() -> Void)) {
        self.navigationController = navigationController
        self.onConfirm = onConfirm
        sizeToFit()
        show(animated: true)
    }

    func alertFirstButtonTapped(alert: CustomAlert) {
        // do nothing
    }

    func alertSecondButtonTapped(alert: CustomAlert) {
        onConfirm?()
    }

    func alertDismissed(alert: CustomAlert) {
        // do nothing
    }
}
