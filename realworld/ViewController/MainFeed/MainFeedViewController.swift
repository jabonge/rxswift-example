//
//  MainFeedViewController.swift
//  realworld
//
//  Created by Mac on 2020/09/16.
//  Copyright © 2020 Mac. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import SnapKit
import SideMenu

class MainFeedViewController: UIViewController {
    
    private let mainFeedViewModel = MainFeedViewModel()
    private let disposeBag = DisposeBag()
    private let activityIndicator = UIActivityIndicatorView()
    private let tableView = UITableView().then {
        $0.register(MainFeedTableViewCell.self, forCellReuseIdentifier: String(describing: MainFeedTableViewCell.self))
        $0.rowHeight = UITableView.automaticDimension
        $0.estimatedRowHeight = 100
        $0.separatorStyle = .none
    }
    private let leftMenuNavigationController = SideMenuNavigationController(rootViewController: SideMenuViewController()).then {
        $0.leftSide = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.barTintColor = .green
        navigationController?.navigationBar.isTranslucent = false
        navigationItem.title = "Real World"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "line.horizontal.3"), style: .plain, target: self, action: #selector(showOrCloseSideMenu))
        configureUI()
        bind()
        mainFeedViewModel.getArticles()
    }
    
    @objc func showOrCloseSideMenu() {
        present(leftMenuNavigationController,animated: true)
    }
        
    func bind() {
        mainFeedViewModel.articlesSubject.bind(to: tableView.rx.items(cellIdentifier: String(describing: MainFeedTableViewCell.self), cellType: MainFeedTableViewCell.self)) {
            (index, article, cell) in
            cell.setArticle(article: article)
        }.disposed(by: disposeBag)
        mainFeedViewModel.loading.bind(to: activityIndicator.rx.isAnimating).disposed(by: disposeBag)
    }
    
    func configureUI() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.equalTo(view)
            make.right.equalTo(view)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        view.addSubview(activityIndicator)
        activityIndicator.color = .green
        activityIndicator.isHidden = false
        activityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    
}


