//
//  MainRepository.swift
//  MVVMArchitecture
//
//  Created by Zvonimir Medak on 24.04.2021..
//

import Foundation
import RxSwift

class MainRepository {
    let apiHelper: ApiHelper
    
    public init(_ apiHelper: ApiHelper) {
        self.apiHelper = apiHelper
    }
    
    func getUsers() -> Observable<[User]> {
        apiHelper.getUsers()
    }
}
