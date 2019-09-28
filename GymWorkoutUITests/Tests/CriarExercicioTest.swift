//
//  CadastroDeExercicioTest.swift
//  GymWorkoutUITests
//
//  Created by Daniela Ferreira da Cunha on 23/09/19.
//  Copyright © 2019 Adrian de Almeida. All rights reserved.
//

import XCTest

class CriarExercicioTest: BaseTest {
    
    lazy var criarExercicio = CriarExercicioScreen()
    
    override func setUp() {
            super.setUp()
        var criarTreino = TreinosScreen()
        if(!app.staticTexts["Treino Inicial"].exists) {
            criarTreino = criarTreino.addTreino().cadastrarTreino(nome: "Treino Inicial", diaInicio: "1", mesInicio: "outubro", anoInicio: "2019", diaFinal: "15", mesFinal: "dezembro", anoFinal: "2019", tipo: "AB")
        }
        _ = criarTreino.abrirTreinoParaCadastrarExercicio(tituloDoTreino: "Treino Inicial")
    }
    
    func testCriarExercicioTreinoA() {
        _ = ExercicioScreen().addExercicio()
        _ = criarExercicio.cadastrarExercicio(nome: "Supino", series: "3", repeticoes: "15", peso: 100)
    }
    
    func testCriarExercicioTreinoB() {
        _ = app.buttons["B"].tap()
        _ = ExercicioScreen().addExercicio()
        _ = criarExercicio.cadastrarExercicio(nome: "Leg Press 45", series: "4", repeticoes: "10", peso: 100)
    }
}
