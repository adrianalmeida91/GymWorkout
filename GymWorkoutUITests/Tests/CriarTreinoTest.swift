//
//  TreinosTest.swift
//  GymWorkoutUITests
//
//  Created by Daniela Ferreira da Cunha on 20/09/19.
//  Copyright © 2019 Adrian de Almeida. All rights reserved.
//

import XCTest

class CriarTreinoTest: BaseTest {
    
    lazy var criarTreino = CriarTreinoScreen()
    let nomeTreino = "Teste"
    
    override func setUp() {
               super.setUp()
           let treino = TreinosScreen()
        if(treino.app.staticTexts[nomeTreino].exists) {
            treino.apagarTreino(tituloDoTreino: nomeTreino)
        }
           criarTreino = treino.addTreino()
       }
    
    func testCadastrarTreino() {
        _ = criarTreino.cadastrarTreino(nome: nomeTreino, diaInicio: "1", mesInicio: "setembro", anoInicio: "2019", diaFinal: "1", mesFinal: "novembro", anoFinal: "2019", tipo: "ABC")
        XCTAssertTrue(app.staticTexts[nomeTreino].exists)
    }
    
    func testCadastrarTreinoSemNome() {
        _ = criarTreino.cadastrarTreino(nome: "", diaInicio: "1", mesInicio: "setembro", anoInicio: "2019", diaFinal: "1", mesFinal: "novembro", anoFinal: "2019", tipo: "ABC")
        XCTAssertTrue(criarTreino.mensagemDeErroNomeVazio.exists)
    }
    
    func testCadastrarTreinoSemDataDeInicio() {
        _ = criarTreino.inserirNomeDoTreino(nome: "Teste 2")
            .inserirDataFinal(diaFinal: "30", mesFinal: "novembro", anoFinal: "2019")
            .escolherTipoDoTreino(tipo: "A/B/C")
            .botaoSalvarTreino()
        XCTAssertTrue(criarTreino.mensagemDeErroDataIVazio.exists)
    }
}
