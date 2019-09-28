//
//  BaseScreen.swift
//  GymWorkoutUITests
//
//  Created by Daniela Ferreira da Cunha on 20/09/19.
//  Copyright © 2019 Adrian de Almeida. All rights reserved.
//

import XCTest

protocol BaseScreen {
    
}

extension BaseScreen {
    
    func findAll(_ type: XCUIElement.ElementType) -> XCUIElementQuery {
        return app.descendants(matching: type)
    }
    
    var app: XCUIApplication {
        return XCUIApplication()
    }
    
    func sendText(idCampo: XCUIElement, texto: String) {
        idCampo.tap()
        idCampo.typeText(texto)
    }
    
    func setDatePicker(idCampo: XCUIElement, dia: String, mes: String, ano: String) {
        idCampo.tap()
        app.datePickers.pickerWheels.element(boundBy: 0).adjust(toPickerWheelValue: dia)
        app.datePickers.pickerWheels.element(boundBy: 1).adjust(toPickerWheelValue: mes)
        app.datePickers.pickerWheels.element(boundBy: 2).adjust(toPickerWheelValue: ano)
    }
}
