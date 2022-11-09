//
//  Extension + UserDefault.swift
//  StructureTreeApp
//
//  Created by Андрей Антонов on 31.10.2022.
//  Copyright © 2022 Андрей Антонов. All rights reserved.
//

import Foundation
import RxSwift

protocol ObjectSavable {
    func setObject<Object: Encodable>(_ object: [Object], forKey: String) throws -> Observable<Void>
    func getObject<Object: Decodable>(forKey: String, castTo type: Object.Type) throws -> Observable<Object>
}

enum ObjectSavableError: String, LocalizedError {
    case unableToEncode = "Unable to encode object into data"
    case noValue = "No data object found for the given key"
    case unableToDecode = "Unable to decode object into given type"
}

extension UserDefaults: ObjectSavable {
    func setObject<Object: Encodable>(_ object: [Object], forKey: String) -> Observable<Void> {
        return Observable.create { observer in
            if let data = try? JSONEncoder().encode(object) {
                self.set(data, forKey: forKey)
                observer.onNext(Void())
                observer.onCompleted()
            } else {
                observer.onError(ObjectSavableError.unableToEncode)
            }
            return Disposables.create()
        }
    }
    
    func getObject<Object: Decodable>(forKey: String, castTo type: Object.Type) -> Observable<Object> {
        return Observable.create { observer in
            guard let data = self.data(forKey: forKey) else { return Disposables.create() }
            if let decoder = try? JSONDecoder().decode(type, from: data) {
                observer.onNext(decoder)
                observer.onCompleted()
            } else {
                observer.onError(ObjectSavableError.unableToDecode)
            }
            return Disposables.create()
        }
    }
}
