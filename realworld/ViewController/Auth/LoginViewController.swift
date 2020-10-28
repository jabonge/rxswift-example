//
//  LoginViewController.swift
//  realworld
//
//  Created by Mac on 2020/09/19.
//  Copyright © 2020 Mac. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import RxSwift
import RxCocoa

class LoginViewController: UIViewController {
    
    private let userViewModel = UserViewModel.shared
    private let disposeBag = DisposeBag()
    
    private let appNameLabel = UILabel().then {
        $0.text = "RealWorld"
        $0.font = .boldSystemFont(ofSize: 25)
        $0.textAlignment = .center
    }
    private let emailTextField = UITextField().then {
        $0.placeholder = "Email"
    }
    private let passwordTextField = UITextField().then {
        $0.placeholder = "password"
        $0.isSecureTextEntry = true
    }
    private let loginButton = UIButton().then {
        $0.backgroundColor = .green
        $0.setTitle("LOGIN", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = .boldSystemFont(ofSize: 20)
    }
    private let registerButton = UIButton().then {
        $0.setTitle("Don't have an account? Register", for: .normal)
        $0.setTitleColor(.gray, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 17)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.setNavigationBarHidden(true, animated: true)
        configureUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        emailTextField.addBottomBorder()
        passwordTextField.addBottomBorder()
    }
    
    func configureUI() {
        _ = UIStackView().then {
            $0.axis = .vertical
            $0.alignment = .fill
            $0.distribution = .equalCentering
            $0.spacing = 30
            view.addSubview($0)
            $0.addArrangedSubview(appNameLabel)
            $0.addArrangedSubview(emailTextField)
            $0.addArrangedSubview(passwordTextField)
            $0.addArrangedSubview(loginButton)
            $0.snp.makeConstraints { (make) in
                make.centerX.equalToSuperview()
                make.centerY.equalTo(view).multipliedBy(0.8)
                make.width.equalTo(view.snp.width).inset(UIEdgeInsets(top: 0, left: 25, bottom: 0, right: 25))
            }
        }
        appNameLabel.snp.makeConstraints { make in
            make.width.equalToSuperview()
        }
        loginButton.snp.makeConstraints { (make) in
            make.height.equalTo(48)
            make.width.equalToSuperview()
        }
        loginButton.rx.tap.bind {
            self.userViewModel.login(email: "jaebong@naver.com", password: "woqhd3946")
        }.disposed(by: disposeBag)
        view.addSubview(registerButton)
        registerButton.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-20)
            make.centerX.equalToSuperview()
        }
        
    }
}
