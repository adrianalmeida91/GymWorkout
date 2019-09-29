//
//  ExerciciosTest.swift
//  GymWorkoutUITests
//
//  Created by Daniela Ferreira da Cunha on 23/09/19.
//  Copyright © 2019 Adrian de Almeida. All rights reserved.
//

import XCTest

class ExerciciosTest: BaseTest {
    
    lazy var telaDeExercicio = ExercicioScreen()
    let nomeDoTreino = "Treino Para Pagina de Exercicio"
    
    override func setUp() {
            super.setUp()
        var treino = TreinosScreen()
        if(!treino.app.staticTexts[nomeDoTreino].exists) {
            treino = treino.addTreino().cadastrarTreino(nome: nomeDoTreino, diaInicio: "1", mesInicio: "outubro", anoInicio: "2019", diaFinal: "15", mesFinal: "dezembro", anoFinal: "2019", tipo: "AB")
        }
        _ = treino.abrirTreinoParaCadastrarExercicio(tituloDoTreino: nomeDoTreino)
    }
    
    func testVerificarSeColunaBEstaAtivaAoClicarEColunaANaoEsta() {
        _ = app.buttons["B"].tap()
        XCTAssertTrue(app.buttons["B"].isHittable)
        XCTAssertFalse(app.buttons["A"].isSelected)
    }
    
    func testCriarExercicioEmColunaB() {
        _ = app.buttons["B"].tap()
        telaDeExercicio = telaDeExercicio.addExercicio()
        .cadastrarExercicio(nome: "Leg Press 45", series: "4", repeticoes: "10", peso: 100)
        XCTAssertTrue(app.buttons["B"].isSelected && app.staticTexts[nomeDoTreino].exists)
    }
}
