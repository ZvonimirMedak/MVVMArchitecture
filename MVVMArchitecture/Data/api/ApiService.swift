//
//  ApiService.swift
//  MVVMArchitecture
//
//  Created by Zvonimir Medak on 24.04.2021..
//

import Foundation
import RxSwift

protocol ApiService {
    func getUsers() -> Observable<[User]>
}
