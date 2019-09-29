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
    let nomeExercicio = "Supino"
    let treinoParaCriarExercicio = "Treino Para Criar Exercicio"
    
    override func setUp() {
            super.setUp()
        var treino = TreinosScreen()
        if(!treino.app.staticTexts[treinoParaCriarExercicio].exists) {
            treino = treino.addTreino().cadastrarTreino(nome: treinoParaCriarExercicio, diaInicio: "1", mesInicio: "outubro", anoInicio: "2019", diaFinal: "15", mesFinal: "dezembro", anoFinal: "2019", tipo: "AB")
        }
        let exercicio = treino.abrirTreinoParaCadastrarExercicio(tituloDoTreino: treinoParaCriarExercicio)
        
        if(exercicio.app.staticTexts["Supino"].exists) {
            exercicio.apagarExercicio(nomeDoExercicio: "Supino")
        }
        exercicio.addExercicio()
    }
    
    func testCriarExercicioTreino() {
        _ = criarExercicio.cadastrarExercicio(nome: nomeExercicio, series: "3", repeticoes: "15", peso: 100)
        XCTAssertTrue(app.staticTexts[nomeExercicio].exists)
    }
    
    func testCriarExercicioSemNome() {
        _ = criarExercicio.cadastrarExercicio(nome: "", series: "4", repeticoes: "10", peso: 100)
        XCTAssertTrue(criarExercicio.mensagemDeErroNomeVazio.exists)
    }
    
    func testCriarExercicioSemRepeticoes() {
           _ = criarExercicio.cadastrarExercicio(nome: "Rosca Direta", series: "4", repeticoes: "", peso: 100)
        XCTAssertTrue(criarExercicio.mensagemDeErroRepeticoesVazio.exists)
       }
}
