//
//  ViewController.swift
//  GymWorkout
//
//  Created by Adrian de Almeida on 31/08/19.
//  Copyright © 2019 Adrian de Almeida. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class WorkoutViewController: BaseViewController {

    @IBOutlet weak var addWorkout: UIBarButtonItem!
    @IBOutlet weak var workoutsTableView: UITableView!
    
    let disposeBag = DisposeBag()
    var viewModel: WorkoutViewModel!
    var workouts: [Workout] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupTableView()
    }

    func setupViews() {
        navigationItem.hidesBackButton = true
        addWorkout.rx.tap.bind {
            self.showWorkoutBuild()
        }.disposed(by: disposeBag)
        viewModel.workouts.drive(onNext: { workouts in
            self.workouts = workouts.reversed()
            self.workoutsTableView.reloadData()
        }).disposed(by: disposeBag)
    }

    func setupTableView() {
        workoutsTableView.backgroundColor = UIColor.clear
        workoutsTableView.separatorColor = UIColor.black
        workoutsTableView.dataSource = self
        workoutsTableView.delegate = self
        workoutsTableView.register(R.nib.workoutTableViewCell)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        viewModel.loadWorkouts()
    }
}

extension WorkoutViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (workouts.count == 0) {
            tableView.setEmptyView(message: "Nenhum treino cadastrado.\nClique no + para adicionar.")
        } else {
            tableView.restore()
        }
        return workouts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.workoutTableViewCell, for: indexPath)!
        cell.setLabels(workout: self.workouts[indexPath.row])
        cell.backgroundColor = UIColor.clear
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        return cell
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let alert = DeleteConfirmAlert(title: "Tem certeza que deseja deletar?", message: "Deletar o treino: \(self.workouts[indexPath.row].name)\nEssa ação não poderá ser desfeita.")
            alert.show(navigationController: navigationController!, onConfirm: {
                self.viewModel.removeWorkout(workout: self.workouts[indexPath.row]).subscribe({ result in
                    switch result {
                    case .completed:
                        self.workouts.remove(at: indexPath.row)
                        tableView.reloadData()
                    case .error(let error):
                        print("\(error)")
                    }
                }).disposed(by: self.disposeBag)
            })
        }
    }

    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Deletar"
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showExercices(workout: workouts[indexPath.row])
    }
}
