//
//  GameViewController.swift
//  MentaMVVM005
//
//  Created by Yoshiki Izumi on 2020/04/28.
//  Copyright © 2020 Yoshiki Izumi. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit
import RxSwift
import RxCocoa


class GameViewController: UIViewController {
    @IBOutlet weak var idTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var validationLabel: UILabel!
    
    
    private lazy var viewModel = ViewModel(
        idTextObservable: idTextField.rx.text.asObservable(), passwordTextObservable: passwordTextField.rx.text.asObservable(), model: Model()
    )
    private let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.validationText.bind(to: validationLabel.rx.text).disposed(by: disposeBag)
        viewModel.loadLabelColor.bind(to: loadLabelColor).disposed(by: disposeBag)
    }

    private var loadLabelColor: Binder<UIColor> {
        return Binder(self) { me, color in
            me.validationLabel.textColor = color
        }
    }
}
