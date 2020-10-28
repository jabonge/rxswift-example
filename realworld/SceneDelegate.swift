//
//  SceneDelegate.swift
//  realworld
//
//  Created by Mac on 2020/09/16.
//  Copyright © 2020 Mac. All rights reserved.
//

import UIKit
import RxSwift

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    let disposeBag = DisposeBag()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
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

}

