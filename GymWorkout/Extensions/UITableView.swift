//
//  UITableView.swift
//  GymWorkout
//
//  Created by Adrian de Almeida on 12/09/19.
//  Copyright © 2019 Adrian de Almeida. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {
    func setEmptyView(message: String) {
        let emptyView = UIView(frame: CGRect(x: self.center.x, y: self.center.y, width: self.bounds.size.width, height: self.bounds.size.height))
        let messageLabel = UILabel()
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.textColor = UIColor.black
        emptyView.addSubview(messageLabel)
        messageLabel.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor).isActive = true
        messageLabel.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
        messageLabel.text = message
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        self.backgroundView = emptyView
        self.separatorStyle = .none
    }

    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
        self.separatorColor = UIColor.black
    }
}
