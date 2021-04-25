//
//  MainViewModel.swift
//  MVVMArchitecture
//
//  Created by Zvonimir Medak on 24.04.2021..
//

import Foundation
import RxSwift
import RxCocoa

class MainViewModel {
    
    public let usersRelay: BehaviorRelay<[User]>
    private var disposables: [Disposable] = []
    private let mainRepository: MainRepository
    public let loadDataSubject: ReplaySubject<()>
    public let loaderSubject: PublishSubject<Bool>
    
    public init(mainRepo: MainRepository, usersRelay: BehaviorRelay<[User]>, loadDataSubject: ReplaySubject<()>, loaderSubject: PublishSubject<Bool>) {
        self.usersRelay = usersRelay
        self.mainRepository = mainRepo
        self.loadDataSubject = loadDataSubject
        self.loaderSubject = loaderSubject
    }
    
    func initializeViewModel() -> [Disposable] {
        disposables.append(initializeUsersRelay(for: loadDataSubject))
        return disposables
    }
}

private extension MainViewModel {
    
    func initializeUsersRelay(for subject: ReplaySubject<()>) -> Disposable {
        return subject
            .observe(on: ConcurrentDispatchQueueScheduler.init(qos: .background))
            .flatMap{ [unowned self] _ -> Observable<[User]> in
                loaderSubject.onNext(true)
                return mainRepository.getUsers()
            }
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [unowned self] (items) in
                loaderSubject.onNext(false)
                usersRelay.accept(items)
            }, onError: { [unowned self] (error) in
                loaderSubject.onNext(false)
                print(error.localizedDescription)
            })
    }
}
