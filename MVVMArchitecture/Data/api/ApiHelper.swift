//
//  ApiHelper.swift
//  MVVMArchitecture
//
//  Created by Zvonimir Medak on 24.04.2021..
//

import Foundation
import RxSwift
class ApiHelper {
    let apiService: ApiService
    
    public init(apiService: ApiService) {
        self.apiService = apiService
    }
    
    func getUsers() -> Observable<[User]> {
        apiService.getUsers()
    }
}
