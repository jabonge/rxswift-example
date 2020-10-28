//
//  UserViewModel.swift
//  realworld
//
//  Created by Mac on 2020/09/18.
//  Copyright © 2020 Mac. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class UserViewModel {
    
    static let shared = UserViewModel()
    
    
    let disposeBag = DisposeBag()
    let userRelay = BehaviorRelay<User?>(value: nil)
    
    private init() {
        
    }
    
    func login(email: String, password: String) {
        AuthService.shared.login(email: email, password: password).subscribe(onNext: { [weak self] (user) in
            self?.userRelay.accept(user)
            }, onError: { error in
                print(error.localizedDescription)
        }).disposed(by: disposeBag)
    }
    
    func getMe() {
        AuthService.shared.getMe().subscribe(onNext: { [weak self] user in
            self?.userRelay.accept(user)
            }, onError: { error in
                print(error.localizedDescription)
        }).disposed(by: disposeBag)
    }
}
