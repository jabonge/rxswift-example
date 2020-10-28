//
//  SideMenuViewController.swift
//  realworld
//
//  Created by Mac on 2020/09/18.
//  Copyright © 2020 Mac. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class SideMenuViewController: UIViewController {
    
    private let tableView = UITableView().then {
        $0.separatorInset = .zero
        $0.separatorStyle = .none
    }
    private let imageView = UIImageView().then {
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = 30
        $0.backgroundColor = .gray
        $0.snp.makeConstraints { make in
            make.width.equalTo(60)
            make.height.equalTo(60)
        }
    }
    
    enum SideMenuNav: Int {
        
        case Auth = 0
        case Home
        case Setting
        case About
        
        var description: String {
            switch self {
            case .Auth:
                return "Login/Register"
            case .Home:
                return "Home"
            case .Setting:
                return "Setting"
            case .About:
                return "About"
            }
        }
        
    }
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.setNavigationBarHidden(true, animated: false)
        tableView.dataSource = self
        tableView.delegate = self
        configureUI()
    }
    
    func configureUI() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
}

extension SideMenuViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.backgroundColor = .systemGray
        cell.textLabel?.text = SideMenuNav.init(rawValue: indexPath.row)?.description
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
}

extension SideMenuViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView()
        header.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.top.equalTo(header.snp.top).offset(20)
            make.bottom.equalTo(header.snp.bottom).offset(-20)
            make.left.equalTo(header.snp.left).offset(20)
        }
        return header
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var VC: UIViewController = UIViewController()
        switch SideMenuNav.init(rawValue: indexPath.row){
        case .Auth:
            VC = LoginViewController()
        case .About,.Home,.Setting:
            VC = UIViewController()
        case .none:
            VC = UIViewController()
        }
        navigationController?.pushViewController(VC, animated: true)
    }
}


