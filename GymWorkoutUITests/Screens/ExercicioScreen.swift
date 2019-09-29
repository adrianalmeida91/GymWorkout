//
//  ExerciciosScreen.swift
//  GymWorkoutUITests
//
//  Created by Daniela Ferreira da Cunha on 23/09/19.
//  Copyright © 2019 Adrian de Almeida. All rights reserved.
//

import XCTest

class ExercicioScreen: BaseScreen {
    
    private lazy var buttonsElements = findAll(.button)
    private lazy var staticTextElements = findAll(.staticText)
    public lazy var botaoDeletarExercicio = buttonsElements["Deletar"]
    public lazy var botaoDeletarDialog = buttonsElements["Deletar"]
    public lazy var addExercicioButton = buttonsElements["addExercicio"]
    
    func addExercicio() -> CriarExercicioScreen {
        addExercicioButton.tap()
        return CriarExercicioScreen()
    }
    
    func apagarExercicio(nomeDoExercicio: String) -> ExercicioScreen {
        staticTextElements[nomeDoExercicio].swipeLeft()
        botaoDeletarExercicio.tap()
        botaoDeletarDialog.tap()
        return self
    }
}
