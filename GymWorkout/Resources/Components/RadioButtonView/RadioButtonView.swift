//
//  RadioButtonView.swift
//  GymWorkout
//
//  Created by Adrian de Almeida on 02/09/19.
//  Copyright © 2019 Adrian de Almeida. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class RadioButtonView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var radioButtonAB: UIButton!
    @IBOutlet weak var radioButtonABC: UIButton!
    @IBOutlet weak var radioButtonABCD: UIButton!

    var disposeBag = DisposeBag()
    let radioButtonSelected = BehaviorRelay<RadioButtonEnum>(value: .ab)

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initialize()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initialize()
    }

    func initialize() {
        Bundle.main.loadNibNamed(R.nib.radioButtonView.name, owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        setupViews()
        setupSubscribe()
    }

    func setupViews() {
        radioButtonAB.setImage(UIImage(named: R.image.unchecked_2.name)?.fillAlpha(fillColor: UIColor.white), for: .normal)
        radioButtonAB.setImage(UIImage(named: R.image.checked_2.name)?.fillAlpha(fillColor: UIColor.white), for: .selected)
        radioButtonABC.setImage(UIImage(named: R.image.unchecked_2.name)?.fillAlpha(fillColor: UIColor.white), for: .normal)
        radioButtonABC.setImage(UIImage(named: R.image.checked_2.name)?.fillAlpha(fillColor: UIColor.white), for: .selected)
        radioButtonABCD.setImage(UIImage(named: R.image.unchecked_2.name)?.fillAlpha(fillColor: UIColor.white), for: .normal)
        radioButtonABCD.setImage(UIImage(named: R.image.checked_2.name)?.fillAlpha(fillColor: UIColor.white), for: .selected)
    }

    func setupSubscribe() {
        radioButtonSelected.subscribe(onNext: { radioButtonSelected in
            self.radioButtonAB.isSelected = false
            self.radioButtonABC.isSelected = false
            self.radioButtonABCD.isSelected = false
            switch radioButtonSelected {
            case .ab:
                self.radioButtonAB.isSelected = true
            case .abc:
                self.radioButtonABC.isSelected = true
            case .abcd:
                self.radioButtonABCD.isSelected = true
            }
        }).disposed(by: disposeBag)
    }

    @IBAction func radioButtonPressed(_ sender: UIButton) {
        switch sender {
        case radioButtonAB:
            radioButtonSelected.accept(.ab)
        case radioButtonABC:
            radioButtonSelected.accept(.abc)
        case radioButtonABCD:
            radioButtonSelected.accept(.abcd)
        default:
            break
        }
    }
}
