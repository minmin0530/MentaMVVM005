//
//  ViewModel.swift
//  MentaMVVM005
//
//  Created by Yoshiki Izumi on 2020/04/28.
//  Copyright © 2020 Yoshiki Izumi. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa


final class ViewModel {
    let validationText: Observable<String>
    let loadLabelColor: Observable<UIColor>
    init(idTextObservable: Observable<String?>, passwordTextObservable: Observable<String?>, model: ModelProtocol) {
        let event = Observable.combineLatest(idTextObservable, passwordTextObservable).skip(1).flatMap { idText, passwordText -> Observable<Event<Void>> in
            return model.validate(idText: idText, passwordText: passwordText).materialize()
        }.share()
        self.validationText = event.flatMap { event -> Observable<String> in
            switch event {
            case .next: return .just("OK!!!")
            case let .error(error as ModelError):
                return .just(error.errorText)
            case .error, .completed: return .empty()
                
            }
        }.startWith("ID と Password を入力してください。")
        self.loadLabelColor = event.flatMap { event -> Observable<UIColor> in
            switch event {
            case .next: return .just(.green)
            case .error: return .just(.red)
            case .completed: return .empty()
            }
        }
    }
}
extension ModelError {
    fileprivate var errorText: String {
        switch self {
        case .invalidIdAndPassword: return "IDとPasswordが未入力です。"
        case .invalidId: return "IDが未入力です。"
        case .invalidPassword: return "Passwordが未入力です。"
        }
    }
}
