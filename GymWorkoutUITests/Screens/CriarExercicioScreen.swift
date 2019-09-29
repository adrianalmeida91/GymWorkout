//
//  CadastroDeExerciciosScreen.swift
//  GymWorkoutUITests
//
//  Created by Daniela Ferreira da Cunha on 23/09/19.
//  Copyright © 2019 Adrian de Almeida. All rights reserved.
//

import XCTest

class CriarExercicioScreen: BaseScreen {
    
    private lazy var textFieldElements = findAll(.textField)
    private lazy var sliderElements = findAll(.slider)
    private lazy var buttonsElements = findAll(.button)
    private lazy var staticTextElements = findAll(.staticText)
    public lazy var salvar = buttonsElements["salvar"]
    public lazy var campoNome = textFieldElements["nome"]
    public lazy var campoSeries = textFieldElements["series"]
    public lazy var campoRepeticoes = textFieldElements["repeticoes"]
    public lazy var pesoSlider = sliderElements["sliderPeso"]
    public lazy var mensagemDeErroNomeVazio = staticTextElements["Campo Nome não pode ser vazio!"]
    public lazy var mensagemDeErroSeriesIVazio = staticTextElements["Campo Séries não pode ser vazio!"]
    public lazy var mensagemDeErroRepeticoesVazio = staticTextElements["Campo Repetições não pode ser vazio!"]

    func cadastrarExercicio(nome: String, series: String, repeticoes: String, peso: Double) -> ExercicioScreen {
        sendText(idCampo: campoNome, texto: nome)
        sendText(idCampo: campoSeries, texto: series)
        sendText(idCampo: campoRepeticoes, texto: repeticoes)
        setSlider(peso: peso)
        salvar.tap()
    return ExercicioScreen()
    }
    
    func setSlider (peso: Double) {
        let slider = app.sliders.firstMatch
        var pesoN = peso/200
        slider.adjust(toNormalizedSliderPosition: (CGFloat(pesoN)))
    }
}
