//
//  TreinosTest.swift
//  GymWorkoutUITests
//
//  Created by Daniela Ferreira da Cunha on 23/09/19.
//  Copyright © 2019 Adrian de Almeida. All rights reserved.
//

import XCTest


class TreinosTest: BaseTest {
    
    lazy var treinos = TreinosScreen()
    let nomeTreino = "Treino Inicial"
    
    override func setUp() {
        super.setUp()
        if(!treinos.treinoInicial.exists) {
            _ = treinos.addTreino().cadastrarTreino(nome: nomeTreino, diaInicio: "1", mesInicio: "outubro", anoInicio: "2019", diaFinal: "15", mesFinal: "dezembro", anoFinal: "2019", tipo: "AB")
        }
    }
    
    func testApagarTreino() {
        _ = treinos.apagarTreino(tituloDoTreino: nomeTreino)
        XCTAssertFalse(treinos.app.staticTexts[nomeTreino].exists)
    }
}
