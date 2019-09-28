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
    
    override func setUp() {
            super.setUp()
        var criarTreino = TreinosScreen()
        if(app.staticTexts["Treino Inicial"].exists) {
            app.staticTexts["Treino Inicial"].tap()
        } else {
            criarTreino = criarTreino.addTreino().cadastrarTreino(nome: "Treino Inicial", diaInicio: "1", mesInicio: "outubro", anoInicio: "2019", diaFinal: "15", mesFinal: "dezembro", anoFinal: "2019", tipo: "AB")
        _ = criarTreino.abrirTreinoParaCadastrarExercicio(tituloDoTreino: "Treino Inicial")
        }
    }
    
    func testVerificarSeColunaEstaAtivaAoClicar() {
        _ = app.buttons["B"].tap()
        XCTAssertTrue(app.buttons["B"].isHittable)
        XCTAssertFalse(app.buttons["A"].isSelected)
    }
}
