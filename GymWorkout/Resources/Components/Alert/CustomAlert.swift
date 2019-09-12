//
//  CustomAlert.swift
//  GymWorkout
//
//  Created by Adrian de Almeida on 12/09/19.
//  Copyright © 2019 Adrian de Almeida. All rights reserved.
//

import UIKit

@objc protocol CustomAlertProtocol {
    func alertFirstButtonTapped(alert: CustomAlert)
    func alertSecondButtonTapped(alert: CustomAlert)
    func alertDismissed(alert: CustomAlert)
}

class CustomAlert: UIView, Modal {
    var backgroundView = UIView()
    var dialogView = UIView()
    private var dialogViewWidth = CGFloat()
    private var titleLabel = UILabel()
    private var messageLabel = UITextView()
    private var firstButton: UIButton?
    private var secondButton: UIButton?
    var dismissOnTouchOutside = true
    var buttonsDelegate: CustomAlertProtocol?

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    convenience init(title: NSAttributedString,
                     message: NSAttributedString? = nil,
                     type: ModalButtonType,
                     dismissOnTouchOutside: Bool = false,
                     firstButtonText: NSAttributedString? = nil,
                     secondButtonText: NSAttributedString? = nil,
                     viewWidth: CGFloat? = nil,
                     delegate: CustomAlertProtocol? = nil) {
        self.init(frame: UIScreen.main.bounds)
        self.initialize(title: title, message: message, type: type, firstButtonText: firstButtonText, secondButtonText: secondButtonText, viewWidth: viewWidth)
        self.buttonsDelegate = delegate
        self.dismissOnTouchOutside = dismissOnTouchOutside
    }

    func initialize(title: NSAttributedString,
                    message: NSAttributedString?,
                    type: ModalButtonType,
                    firstButtonText: NSAttributedString? = nil,
                    secondButtonText: NSAttributedString? = nil,
                    viewWidth: CGFloat? = nil) {
        dialogView.clipsToBounds = true
        dialogViewWidth = viewWidth ?? frame.width - CGFloat(Constants.Modal.dialogViewWidthDefaultMargin)
        dialogView.backgroundColor = UIColor.white
        setupBackground()
        addTitle(title: title)
        addMessage(message: message)
        addButtons(type: type, firstTitle: firstButtonText, secondTitle: secondButtonText)
        let dialogViewHeight = calculateDialogHeight()
        dialogView.frame.origin = CGPoint(x: CGFloat(Constants.Modal.margin), y: frame.height)
        dialogView.frame.size = CGSize(width: dialogViewWidth, height: dialogViewHeight)
        dialogView.layer.cornerRadius = CGFloat(Constants.Modal.dialogViewCornerRadius)
        addSubview(dialogView)
    }

    private func setupBackground() {
        backgroundView.frame = frame
        backgroundView.backgroundColor = UIColor.black
        backgroundView.alpha = CGFloat(Constants.Modal.backgroundAlph)
        backgroundView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTappedOnBackgroundView)))
        addSubview(backgroundView)
    }

    private func addTitle(title: NSAttributedString) {
        let titleTopMargin = CGFloat(Constants.Modal.titleTopMargin)
        titleLabel = UILabel(frame: CGRect(x: CGFloat(Constants.Modal.leftPadding),
                                           y: titleTopMargin,
                                           width: dialogViewWidth - CGFloat(Constants.Modal.margin),
                                           height: CGFloat(Constants.Modal.labelsHeight)))
        titleLabel.attributedText = title
        titleLabel.font = UIFont.boldSystemFont(ofSize: CGFloat(Constants.Modal.titleSize))
        titleLabel.textAlignment = .center
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.numberOfLines = 0
        titleLabel.frame = getNeededFrameSize(frameWidth: (dialogViewWidth - CGFloat(Constants.Modal.margin)), label: titleLabel)
        dialogView.addSubview(titleLabel)
    }

    private func addMessage(message: NSAttributedString? = nil) {
        if message == nil { return }
        messageLabel = UITextView(frame: CGRect(x: CGFloat(Constants.Modal.leftPadding),
                                                y: titleLabel.frame.maxY + CGFloat(Constants.Modal.spaceBetweenLabels),
                                                width: dialogViewWidth - CGFloat(Constants.Modal.margin),
                                                height: CGFloat(Constants.Modal.labelsHeight)))
        messageLabel.backgroundColor = UIColor.clear
        messageLabel.attributedText = message
        messageLabel.textAlignment = .center
        messageLabel.isEditable = false
        messageLabel.tintColor = UIColor.gray
        messageLabel.isScrollEnabled = false
        let fixedWidth = messageLabel.frame.size.width
        let newSize = messageLabel.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        messageLabel.frame.size = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height)
        dialogView.addSubview(messageLabel)
    }

    private func addButtons(type: ModalButtonType, firstTitle: NSAttributedString?, secondTitle: NSAttributedString?) {
        let topPadding = CGFloat(Constants.Modal.titleTopMargin)
        let separatorLineView = addSeparator(view: messageLabel, padding: topPadding)
        switch type {
        case .single:
            firstButton = addButton(below: separatorLineView, withTitle: firstTitle ?? NSAttributedString(string: ""))
        case .horizontal:
            addHorizontalButton(below: separatorLineView, withFirstTitle: firstTitle ?? NSAttributedString(string: ""), withSecondTitle: secondTitle ?? NSAttributedString(string: ""))
        case .vertical:
            addVerticalButton(below: separatorLineView, withFirstTitle: firstTitle ?? NSAttributedString(string: ""), withSecondTitle: secondTitle ?? NSAttributedString(string: ""))
        case .none:
            return
        }
    }

    private func getNeededFrameSize(frameWidth: CGFloat, label: UILabel) -> CGRect! {
        let size = label.sizeThatFits(CGSize(width: frameWidth, height: CGFloat.greatestFiniteMagnitude))
        var newFrame = label.frame
        newFrame.size.height = size.height
        return newFrame
    }

    private func addSeparator(view: UIView, padding: CGFloat = 0, type: SeparatorLineType = SeparatorLineType.vertical) -> UIView {
        let separatorLineView = UIView()
        switch type {
        case .horizontal:
            // add separator line to right of the view
            separatorLineView.frame.origin = CGPoint(x: view.frame.maxX, y: view.frame.minY)
            separatorLineView.frame.size = CGSize(width: CGFloat(Constants.Modal.separatorWidth), height: view.frame.height)
        case .vertical:
            // add separator line below of the view
            separatorLineView.frame.origin = CGPoint(x: 0, y: view.frame.maxY + padding)
            separatorLineView.frame.size = CGSize(width: dialogViewWidth, height: CGFloat(Constants.Modal.separatorHeight))
        }
        separatorLineView.backgroundColor = UIColor.black.withAlphaComponent(CGFloat(Constants.Modal.separatorAlphaComponent))
        dialogView.addSubview(separatorLineView)
        return separatorLineView
    }

    private func addButton(below: UIView, withTitle: NSAttributedString, function: (() -> Void)? = nil) -> UIButton {
        let button = UIButton(frame: CGRect(x: 0,
                                            y: below.frame.maxY,
                                            width: dialogViewWidth,
                                            height: CGFloat(Constants.Modal.buttonHeight)))
        button.setAttributedTitle(withTitle, for: .normal)
        button.setTitleColor(SystemColor.blue.uiColor, for: .normal)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        dialogView.addSubview(button)
        return button
    }

    private func addHorizontalButton(below: UIView, withFirstTitle: NSAttributedString, withSecondTitle: NSAttributedString) {
        firstButton = UIButton(frame: CGRect(x: 0,
                                             y: below.frame.maxY,
                                             width: dialogViewWidth/2,
                                             height: CGFloat(Constants.Modal.buttonHeight)))
        firstButton!.setAttributedTitle(withFirstTitle, for: .normal)
        firstButton!.setTitleColor(SystemColor.blue.uiColor, for: .normal)
        dialogView.addSubview(firstButton!)
        firstButton!.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        _ = addSeparator(view: firstButton!, type: SeparatorLineType.horizontal)
        secondButton = UIButton(frame: CGRect(x: firstButton!.frame.maxX,
                                              y: below.frame.maxY,
                                              width: dialogViewWidth/2,
                                              height: CGFloat(Constants.Modal.buttonHeight)))
        secondButton!.setAttributedTitle(withSecondTitle, for: .normal)
        secondButton!.setTitleColor(SystemColor.blue.uiColor, for: .normal)
        secondButton!.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        dialogView.addSubview(secondButton!)
    }

    private func addVerticalButton(below: UIView, withFirstTitle: NSAttributedString, withSecondTitle: NSAttributedString) {
        firstButton = addButton(below: below, withTitle: withFirstTitle)
        let separator = addSeparator(view: firstButton!)
        secondButton = addButton(below: separator, withTitle: withSecondTitle)
    }

    private func calculateDialogHeight() -> CGFloat {
        let firstView = dialogView.subviews[0]
        let lastView = dialogView.subviews[dialogView.subviews.endIndex - 1]
        return lastView.frame.maxY - firstView.frame.minY + CGFloat(Constants.Modal.dialogViewPadding)
    }

    @objc private func didTappedOnBackgroundView() {
        if dismissOnTouchOutside {
            dismiss(animated: true)
            buttonsDelegate?.alertDismissed(alert: self)
        }
    }

    @objc private func buttonTapped(sender: UIButton) {
        dismiss(animated: true)
        if sender == firstButton {
            buttonsDelegate?.alertFirstButtonTapped(alert: self)
        } else if sender == secondButton {
            buttonsDelegate?.alertSecondButtonTapped(alert: self)
        }
    }
}
