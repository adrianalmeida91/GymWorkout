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
    public lazy var addExercicioButton = buttonsElements["addExercicio"]
    
    func addExercicio() -> CriarExercicioScreen {
        addExercicioButton.tap()
        return CriarExercicioScreen()
    }
}
