//
//  TreinosTest.swift
//  GymWorkoutUITests
//
//  Created by Daniela Ferreira da Cunha on 20/09/19.
//  Copyright © 2019 Adrian de Almeida. All rights reserved.
//

import XCTest

class CriarTreinoTest: BaseTest {
    
    lazy var treinos = TreinosScreen()

    func testCadastrarTreino() {
        _ = treinos.addTreino().cadastrarTreino(nome: "Teste", diaInicio: "1", mesInicio: "setembro", anoInicio: "2019", diaFinal: "1", mesFinal: "novembro", anoFinal: "2019", tipo: "ABC")
    }
    
    func testCadastrarTreinoSemNome() {
        let cadastro = treinos.addTreino()
        _ = cadastro.cadastrarTreino(nome: "", diaInicio: "1", mesInicio: "setembro", anoInicio: "2019", diaFinal: "1", mesFinal: "novembro", anoFinal: "2019", tipo: "ABC")
        //XCTAssertTrue(app.staticTexts["Esse campo não pode ser vazio!"].exists)
    }
}
