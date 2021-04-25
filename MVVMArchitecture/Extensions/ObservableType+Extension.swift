//
//  ObservableType+Extension.swift
//  MVVMArchitecture
//
//  Created by Zvonimir Medak on 25.04.2021..
//

import Foundation
import RxSwift
import ObjectMapper
extension ObservableType {
    public func mapObject<T: Mappable>(type: T.Type) -> Observable<T> {
        return flatMap { data -> Observable<T> in
            let json = data as? AnyObject
            guard let object = Mapper<T>().map(JSONObject: json) else {
                throw NSError(
                    domain: "",
                    code: -1,
                    userInfo: [NSLocalizedDescriptionKey: "ObjectMapper can't map"]
                )
            }
            
            return Observable.just(object)
        }
    }
    
    public func mapArray<T: Mappable>(type: T.Type) -> Observable<[T]> {
        return flatMap { data -> Observable<[T]> in
            let json = data as? AnyObject
            guard let objects = Mapper<T>().mapArray(JSONObject: json) else {
                throw NSError(
                    domain: "",
                    code: -1,
                    userInfo: [NSLocalizedDescriptionKey: "ObjectMapper can't map"]
                )
            }
            
            return Observable.just(objects)
        }
    }
}
