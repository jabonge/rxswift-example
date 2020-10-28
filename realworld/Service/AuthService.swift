//
//  AuthService.swift
//  realworld
//
//  Created by Mac on 2020/09/20.
//  Copyright © 2020 Mac. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire
import SwiftyJSON
import ObjectMapper


class AuthService: BaseService {
    
    static let shared = AuthService()
    private let userDefault = UserDefaults.standard
    
    private override init() {
        super.init()
    }
    
    func login(email: String, password: String) -> Observable<User> {
        let parameters = ["user":["email": email, "password": password]]
        return Observable.create { emitter in
            AF.request("\(self.baseUrl)/users/login",
                method: .post,
                parameters: parameters,
                encoding: JSONEncoding.default)
                .responseJSON { response in
                    switch response.result {
                    case .success(let data):
                        let json = JSON(data)
                        let userJSON = json["user"]
                        guard let userDictionary = userJSON.dictionaryObject else { return }
                        if let token = userDictionary["token"] {
                            self.userDefault.set(token, forKey: "token")
                        }
                        do {
                            let user =  try Mapper<User>().map(JSON: userDictionary) as User
                            emitter.onNext(user)
                            emitter.onCompleted()
                        } catch let error {
                            print(error)
                        }
                    case .failure(let error):
                        emitter.onError(error)
                    }
            }
            return Disposables.create()
        }
        
    }
    
    func getMe() -> Observable<User> {
        return Observable.create { emitter  in
            AF.request("\(self.baseUrl)/user").responseJSON { response in
                switch response.result {
                case .success(let data):
                    let json = JSON(data)
                    let userJSON = json["user"]
                    guard let userDictionary = userJSON.dictionaryObject else { return }
                    do {
                        let user =  try Mapper<User>().map(JSON: userDictionary) as User
                        emitter.onNext(user)
                        emitter.onCompleted()
                    } catch let error {
                        print(error)
                    }
                case .failure(let error):
                    emitter.onError(error)
                }
            }
            return Disposables.create()
        }
        
    }
}
