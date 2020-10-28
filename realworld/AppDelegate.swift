//
//  AppDelegate.swift
//  realworld
//
//  Created by Mac on 2020/09/16.
//  Copyright © 2020 Mac. All rights reserved.
//

import UIKit
import AlamofireNetworkActivityLogger
import RxSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let disposeBag = DisposeBag()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        if #available(iOS 13, *) {
            
        } else {
            window = UIWindow()
            let navVC = UINavigationController()
            var rootVC = UIViewController()
            AppViewModel.shared.appStateRelay.subscribe(onNext: { (state) in
                switch state {
                case .LoggedOut,.FirstInit:
                    rootVC = MainFeedViewController()
                case .IsLoggedIn:
                    rootVC = LoggedUserFeedController()
                }
                }).disposed(by: disposeBag)
            navVC.setViewControllers([rootVC], animated: false)
            window?.rootViewController = navVC
            window?.makeKeyAndVisible()
        }
//        #if DEBUG
//            NetworkActivityLogger.shared.level = .debug
//            NetworkActivityLogger.shared.startLogging()
//        #endif
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

