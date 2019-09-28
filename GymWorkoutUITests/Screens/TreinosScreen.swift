//
//  TreinosScreen.swift
//  GymWorkoutUITests
//
//  Created by Daniela Ferreira da Cunha on 20/09/19.
//  Copyright © 2019 Adrian de Almeida. All rights reserved.
//

import XCTest


class TreinosScreen: BaseScreen {
    private lazy var buttonsElements = findAll(.button)
    private lazy var staticTextElements = findAll(.staticText)
    public lazy var addTreinoButton = buttonsElements["addTreino"]
    public lazy var botaoDeletarTreino = buttonsElements["Deletar"]
    public lazy var botaoDeletarDialog = buttonsElements["Deletar"]
    
    func addTreino() -> CriarTreinoScreen {
        addTreinoButton.tap()
        return CriarTreinoScreen()
    }
    
    func apagarTreino(tituloDoTreino: String) -> TreinosScreen {
        staticTextElements[tituloDoTreino].swipeLeft()
        botaoDeletarTreino.tap()
        botaoDeletarDialog.tap()
        return self
    }
    
    func abrirTreinoParaCadastrarExercicio(tituloDoTreino: String) -> ExercicioScreen {
        staticTextElements[tituloDoTreino].tap()
        return ExercicioScreen()
    }
}
