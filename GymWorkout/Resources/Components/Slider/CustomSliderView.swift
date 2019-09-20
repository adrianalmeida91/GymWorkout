//
//  CustomSliderView.swift
//  GymWorkout
//
//  Created by Adrian de Almeida on 17/09/19.
//  Copyright © 2019 Adrian de Almeida. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class CustomSliderView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var weightSlider: UISlider!
    @IBOutlet weak var weightValue: UILabel!

    var disposeBag = DisposeBag()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initialize()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initialize()
    }

    func initialize() {
        Bundle.main.loadNibNamed(R.nib.customSliderView.name, owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        setupView()
    }

    func setupView() {
        weightSlider.rx.value.subscribe(onNext: { value in
            self.weightValue.text = String(Int(value))
        }).disposed(by: disposeBag)
    }

    func getWeight() -> String {
        return weightValue.text ?? "0"
    }
}
