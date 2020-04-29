//
//  Model.swift
//  MentaMVVM005
//
//  Created by Yoshiki Izumi on 2020/04/28.
//  Copyright © 2020 Yoshiki Izumi. All rights reserved.
//

import Foundation
import RxSwift

// エラーの種類
enum ModelError: Error {
    case invalidId
    case invalidPassword
    case invalidIdAndPassword
}

// バリデーション関数を持ったモデルのプロトコル
protocol ModelProtocol {
    func validate(idText: String?, passwordText: String?) -> Observable<Void>
}

// モデル
final class Model: ModelProtocol {
    
    // バリデーション
    func validate(idText: String?, passwordText: String?) -> Observable<Void> {
        switch (idText, passwordText) {
        case (.none, .none):
            return Observable.error(ModelError.invalidIdAndPassword)
        case (.none, .some):
            return Observable.error(ModelError.invalidId)
        case (.some, .none):
            return Observable.error(ModelError.invalidPassword)
            
        case (let idText?, let passwordText?): // ここのletがよく分からない
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
