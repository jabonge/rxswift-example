//
//  MainFeedViewModel.swift
//  realworld
//
//  Created by Mac on 2020/09/17.
//  Copyright © 2020 Mac. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class MainFeedViewModel {
    
    let disposedBag = DisposeBag()
    var totalCount: Int?
    var articles: [Article] = []
    let articlesSubject = BehaviorRelay<[Article]>(value: [])
    let loading = BehaviorRelay<Bool>(value: false)
    
    func getArticles() {
        loading.accept(true)
        ArticleService.shared.getGlobalArticles()
            .subscribe(
                onNext: { [weak self] articleWithCount in
                    guard let self = self else { return }
                    self.articles = articleWithCount.articles
                    self.articlesSubject.accept(self.articles)
                    self.totalCount = articleWithCount.articlesCount
                },
                onError: { error in
                    print(error.localizedDescription)
                },
                onDisposed: { [weak self] in
                    self?.loading.accept(false)
                }
        ).disposed(by: disposedBag)
    }
}
