//
//  AppDelegate.swift
//  MovieDB
//
//  Created by Илья Козлов on 07.03.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let navigationController = BaseNavigationController()
        let coordinator = LoginCoordinator(navigationController)
        window = UIWindow()
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        coordinator.start()

        return true
    }

}
