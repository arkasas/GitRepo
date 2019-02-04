//
//  ApplicationRouter.swift
//  GitRepo
//
//  Created by Arkadiusz Pituła on 03/02/2019.
//  Copyright © 2019 Arkadiusz Pituła. All rights reserved.
//

import UIKit

protocol AppRouter: class {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool
    func applicationWillResignActive(_ application: UIApplication)
    func applicationDidEnterBackground(_ application: UIApplication)
    func applicationWillEnterForeground(_ application: UIApplication)
    func applicationDidBecomeActive(_ application: UIApplication)
    func applicationWillTerminate(_ application: UIApplication)

    func logout()
}

final class ApplicationRouter: AppRouter {

    fileprivate var window: UIWindow!
    fileprivate var navigationController: UINavigationController!

    init() {
        window = UIWindow(frame: UIScreen.main.bounds)
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupWindow()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {

    }

    func applicationDidEnterBackground(_ application: UIApplication) {

    }

    func applicationWillEnterForeground(_ application: UIApplication) {

    }

    func applicationDidBecomeActive(_ application: UIApplication) {

    }

    func applicationWillTerminate(_ application: UIApplication) {

    }

    func logout() {
    }
}

private extension ApplicationRouter {
    func setupWindow() {
        let rootVC = UIStoryboard(name: "UserScene", bundle: nil).instantiateInitialViewController()!
        setupStartNavigationController(rootVC: rootVC)
    }

    func setupStartNavigationController(rootVC: UIViewController) {
        navigationController = UINavigationController(rootViewController: rootVC)
        navigationController.navigationBar.prefersLargeTitles = true
        
        window.rootViewController = self.navigationController
        window.makeKeyAndVisible()
    }

}
