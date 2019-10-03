//
//  ExercicesViewControll.swift
//  GymWorkout
//
//  Created by Adrian de Almeida on 15/09/19.
//  Copyright © 2019 Adrian de Almeida. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class ExercicesViewController: BaseViewController {

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var exercicesTableView: UITableView!
    @IBOutlet weak var addExercice: UIBarButtonItem!

    private var disposeBag = DisposeBag()
    var exercicesIndex = 0
    var exerciceType = ExerciceType.a
    var exercices: [Exercice] = []
    var viewModel: ExercicesViewModel!
    var workout: Workout? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = workout?.name
        setupViews()
        setupSegmentedControl()
        setupTableView()
    }

    func setupViews() {
        addExercice.rx.tap.bind() {
            if let workout = self.workout {
                self.showExerciceCreate(workout: workout, exerciceType: self.exerciceType)
            }
        }.disposed(by: disposeBag)
    }

    func setupSegmentedControl() {
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.white], for: .selected)
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.white], for: .normal)
        var segmentesTitle: [String] = []
        switch workout?.type {
        case .some(.ab):
            segmentesTitle = ["A", "B"]
        case .some(.abc):
            segmentesTitle = ["A", "B", "C"]
        case .some(.abcd):
            segmentesTitle = ["A", "B", "C", "D"]
        case .none:
            break
        }
        self.segmentedControl.replaceSegments(segments: segmentesTitle)
        self.segmentedControl.selectedSegmentIndex = 0
        segmentedControl.rx.selectedSegmentIndex.subscribe(onNext: { index in
            self.exercicesIndex = index
            switch index {
            case 1:
                self.exerciceType = ExerciceType.b
            case 2:
                self.exerciceType = ExerciceType.c
            case 3:
                self.exerciceType = ExerciceType.d
            default:
                self.exerciceType = ExerciceType.a
            }
            self.reloadData()
        }).disposed(by: disposeBag)
    }

    func setupTableView() {
        exercicesTableView.backgroundColor = UIColor.clear
        exercicesTableView.separatorColor = SystemColor.lineSeparator.uiColor
        exercicesTableView.dataSource = self
        exercicesTableView.delegate = self
        exercicesTableView.register(R.nib.exerciceTableViewCell)
    }

    override func viewWillAppear(_ animated: Bool) {
        self.reloadData()
    }

    func reloadData() {
        self.exercices = self.workout?.exercices.toArray().filter({ exercice in
            switch exercicesIndex {
            case 1:
                return exercice.type == ExerciceType.b
            case 2:
                return exercice.type == ExerciceType.c
            case 3:
                return exercice.type == ExerciceType.d
            default:
                return exercice.type == ExerciceType.a
            }
        }) ?? []
        self.exercicesTableView.reloadData()
    }
}

extension ExercicesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (exercices.count != 0) {
            tableView.restore()
        } else {
            switch exercicesIndex {
            case 1:
                tableView.setEmptyView(message: "Nenhum exercicio cadastrado para o treino B.\nClique no + para adicionar.")
            case 2:
                tableView.setEmptyView(message: "Nenhum exercicio cadastrado para o treino C.\nClique no + para adicionar.")
            case 3:
                tableView.setEmptyView(message: "Nenhum exercicio cadastrado para o treino D.\nClique no + para adicionar.")
            default:
                tableView.setEmptyView(message: "Nenhum exercicio cadastrado para o treino A.\nClique no + para adicionar.")
            }
        }
        return exercices.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.exerciceTableViewCell, for: indexPath)!
        if (indexPath.row % 2 == 0) {
            cell.backgroundColor = SystemColor.backgroundDefaultGray.uiColor
        } else {
            cell.backgroundColor = UIColor.clear
        }
        cell.setupExerciceCell(exercice: self.exercices[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let alert = DeleteConfirmAlert(title: "Tem certeza que deseja deletar?", message: "Deletar o exercício: \(self.exercices[indexPath.row].name)\nEssa ação não poderá ser desfeita.")
            alert.show(navigationController: navigationController!, onConfirm: {
                if let workout = self.workout {
                    self.viewModel.removeExercice(workout: workout, exerciceIndex: workout.exercices.index(of: self.exercices[indexPath.row]) ?? 0).subscribe({ result in
                        switch result {
                        case .completed:
                            self.reloadData()
                        case .error(let error):
                            print("\(error)")
                        }
                    }).disposed(by: self.disposeBag)
                }
            })
        }
    }

    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Deletar"
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        let alert = AskNewWeightAlert(title: "Novo peso", message: "Insira novo peso para o exercício: \(self.exercices[indexPath.row].name)")
        alert.show(navigationController: navigationController!, onConfirm: { value in
            if (!value.isEmpty) {
                if let workout = self.workout {
                    self.viewModel.updateExerciceWeight(workout: workout, exerciceIndex: workout.exercices.index(of: self.exercices[indexPath.row]) ?? 0, value: value).subscribe({ result in
                        switch result {
                        case .completed:
                            self.reloadData()
                        case .error(let error):
                            print("\(error)")
                        }
                    }).disposed(by: self.disposeBag)
                }
            }
        })
    }
}
