//
//  AppDelegate.swift
//  MVVMArchitecture
//
//  Created by Zvonimir Medak on 24.04.2021..
//

import UIKit
import RxCocoa
import RxSwift
@main
class AppDelegate: UIResponder, UIApplicationDelegate {

var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        guard let window = window else {return false}
        window.makeKeyAndVisible()
        window.rootViewController = UINavigationController(rootViewController: MainViewController(mainViewModel: MainViewModel(mainRepo: MainRepository(ApiHelper(apiService: ApiServiceImpl())), usersRelay: BehaviorRelay<[User]>(value: []), loadDataSubject: ReplaySubject.create(bufferSize: 1), loaderSubject: PublishSubject())))
        return true
    }


}

