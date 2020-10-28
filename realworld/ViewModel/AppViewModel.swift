//
//  AppViewModel.swift
//  realworld
//
//  Created by Mac on 2020/09/22.
//  Copyright © 2020 Mac. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class AppViewModel {
    
    static let shared = AppViewModel()
    
    let appStateRelay: BehaviorRelay<AppState>
    
    private init() {
        if UserDefaults.standard.string(forKey: "token") != nil {
            self.appStateRelay = BehaviorRelay(value: .IsLoggedIn)
        }else {
            self.appStateRelay = BehaviorRelay(value: .LoggedOut)
        }
    }
}

enum AppState {
    case FirstInit
    case IsLoggedIn
    case LoggedOut
}
