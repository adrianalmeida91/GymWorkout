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
    private lazy var staticTextElements = findAll(.staticText)
    public lazy var salvar = buttonsElements["salvar"]
    public lazy var campoNome = textFieldElements["nome"]
    public lazy var dataInicio = textFieldElements["dataDeInicio"]
    public lazy var dataFinal = textFieldElements["dataFinal"]
    public lazy var abButton = buttonsElements["AB"]
    public lazy var abcButton = buttonsElements["ABC"]
    public lazy var abcdButton = buttonsElements["ABCD"]
    public lazy var mensagemDeErroNomeVazio = staticTextElements["Campo Nome não pode ser vazio!"]
    public lazy var mensagemDeErroDataIVazio = staticTextElements["Campo Data Inicial não pode ser vazio!"]
    public lazy var mensagemDeErroDataFVazio = staticTextElements["Campo Data Final não pode ser vazio!"]

    func cadastrarTreino(nome: String, diaInicio: String, mesInicio: String, anoInicio: String, diaFinal: String, mesFinal: String, anoFinal: String, tipo: String) -> TreinosScreen {
        inserirNomeDoTreino(nome: nome)
        inserirDataDeInicio(diaInicio: diaInicio, mesInicio: mesInicio, anoInicio: anoInicio)
        inserirDataFinal(diaFinal: diaFinal, mesFinal: mesFinal, anoFinal: anoFinal)
        escolherTipoDoTreino(tipo: tipo)
        botaoSalvarTreino()
        return TreinosScreen()
    }
    
    func inserirNomeDoTreino(nome: String)-> CriarTreinoScreen {
        sendText(idCampo: campoNome, texto: nome)
        return self
    }
    
    func inserirDataDeInicio(diaInicio: String, mesInicio: String, anoInicio: String)-> CriarTreinoScreen {
        setDatePicker(idCampo: dataInicio, dia: diaInicio, mes: mesInicio, ano: anoInicio)
        return self
    }
    
    func inserirDataFinal(diaFinal: String, mesFinal: String, anoFinal: String)-> CriarTreinoScreen {
        setDatePicker(idCampo: dataFinal, dia: diaFinal, mes: mesFinal, ano: anoFinal)
        return self
    }
    
    func escolherTipoDoTreino(tipo: String) -> CriarTreinoScreen {
        switch tipo {
        case "ABC":
            abcButton.tap()
        case "ABCD":
            abcdButton.tap()
        default:
            abButton.tap()
        }
        app.buttons["OK"].tap()
        return self
    }
    
    func botaoSalvarTreino() -> CriarTreinoScreen{
        salvar.tap()
        return self
    }
}
