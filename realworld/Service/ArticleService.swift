//
//  ArticleService.swift
//  realworld
//
//  Created by Mac on 2020/09/16.
//  Copyright © 2020 Mac. All rights reserved.
//
import Alamofire
import Foundation
import RxSwift
import ObjectMapper

class ArticleService: BaseService {
    
    static let shared = ArticleService()
    
    private override init() { super.init() }
    
    func getGlobalArticles() -> Observable<ArticlesWithCount> {
        return Observable.create { emitter in
            AF.request("\(self.baseUrl)/articles").responseJSON { res in
                switch res.result {
                case.success(let data):
                    guard let articleWithCount = try? Mapper<ArticlesWithCount>().map(JSONObject: data) as ArticlesWithCount  else { return }
                    emitter.onNext(articleWithCount)
                    emitter.onCompleted()
                case.failure(let error):
                    emitter.onError(error)
                }
            }
            return Disposables.create()
        }
    }
}
