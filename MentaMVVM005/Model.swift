//
//  Model.swift
//  MentaMVVM005
//
//  Created by Yoshiki Izumi on 2020/04/28.
//  Copyright © 2020 Yoshiki Izumi. All rights reserved.
//

import Foundation
import RxSwift

enum ModelError: Error {
    case invalidId
    case invalidPassword
    case invalidIdAndPassword
}

protocol ModelProtocol {
    func validate(idText: String?, passwordText: String?) -> Observable<Void>
}

final class Model: ModelProtocol {
    func validate(idText: String?, passwordText: String?) -> Observable<Void> {
        switch (idText, passwordText) {
        case (.none, .none):
            return Observable.error(ModelError.invalidIdAndPassword)
        case (.none, .some):
            return Observable.error(ModelError.invalidId)
        case (.some, .none):
            return Observable.error(ModelError.invalidPassword)
        case (let idText?, let passwordText?):
            switch (idText.isEmpty, passwordText.isEmpty) {
            case (true, true):
                return Observable.error(ModelError.invalidIdAndPassword)
            case (false, false):
                return Observable.just(())
            case (true, false):
                return Observable.error(ModelError.invalidId)
            case (false, true):
                return Observable.error(ModelError.invalidPassword)
                
            }
        }
    }
}
