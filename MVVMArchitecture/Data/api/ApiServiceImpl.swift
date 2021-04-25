//
//  ApiServiceImpl.swift
//  MVVMArchitecture
//
//  Created by Zvonimir Medak on 24.04.2021..
//

import Foundation
import RxAlamofire
import RxSwift
import ObjectMapper
class ApiServiceImpl: ApiService {
    
    func getUsers() -> Observable<[User]> {
        RxAlamofire.json(.get, "https://5e510330f2c0d300147c034c.mockapi.io/users").mapArray(type: User.self)
            .debug()
    }
}


