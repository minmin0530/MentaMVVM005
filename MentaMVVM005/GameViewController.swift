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
    // storyboardの部品
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var validationLabel: UILabel!
    
    // ViewModelを初期化
    private lazy var viewModel = ViewModel(
        idTextObservable: idTextField.rx.text.asObservable(),
        passwordTextObservable: passwordTextField.rx.text.asObservable(),
        model: Model()
    )
    
    // これがまだよく分かってない
    private let disposeBag = DisposeBag()
    
    // 初期化
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // バリデーション表示テキストをバインド
        viewModel.validationText.bind(to: validationLabel.rx.text).disposed(by: disposeBag)
        
        // バリデーション表示テキストのカラーをバインド
        viewModel.loadLabelColor.bind(to: loadLabelColor).disposed(by: disposeBag)
    }

    private var loadLabelColor: Binder<UIColor> {
        return Binder(self) { me, color in //ここにcolorがあるのがよく分からない
            me.validationLabel.textColor = color
        }
    }
}
