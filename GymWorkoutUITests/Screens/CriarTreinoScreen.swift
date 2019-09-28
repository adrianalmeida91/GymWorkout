//
//  CriarTreinoScreen.swift
//  GymWorkoutUITests
//
//  Created by Daniela Ferreira da Cunha on 22/09/19.
//  Copyright © 2019 Adrian de Almeida. All rights reserved.
//

import XCTest

class CriarTreinoScreen: BaseScreen {
    
    private lazy var textFieldElements = findAll(.textField)
    private lazy var buttonsElements = findAll(.button)
    public lazy var salvar = buttonsElements["salvar"]
    public lazy var campoNome = textFieldElements["nome"]
    public lazy var dataInicio = textFieldElements["dataDeInicio"]
    public lazy var dataFinal = textFieldElements["dataFinal"]
    public lazy var abButton = buttonsElements["AB"]
    public lazy var abcButton = buttonsElements["ABC"]
    public lazy var abcdButton = buttonsElements["ABCD"]

    func cadastrarTreino(nome: String, diaInicio: String, mesInicio: String, anoInicio: String, diaFinal: String, mesFinal: String, anoFinal: String, tipo: String) -> TreinosScreen {
        sendText(idCampo: campoNome, texto: nome)
        setDatePicker(idCampo: dataInicio, dia: diaInicio, mes: mesInicio, ano: anoInicio)
        setDatePicker(idCampo: dataFinal, dia: diaFinal, mes: mesFinal, ano: anoFinal)
        
        switch tipo {
        case "ABC":
            abcButton.tap()
        case "ABCD":
            abcdButton.tap()
        default:
            abButton.tap()
        }
        app.buttons["OK"].tap()
        salvar.tap()
        return TreinosScreen()
    }
}
