//
//  User.swift
//  realworld
//
//  Created by Mac on 2020/09/20.
//  Copyright © 2020 Mac. All rights reserved.
//

import Foundation
import ObjectMapper

struct User : ImmutableMappable {
    
    var email: String
    var username : String
    var bio : String?
    var image : String?
   
    
    init (map: Map) throws {
        email = try map.value("email")
        username = try map.value("username")
        bio = try? map.value("bio")
        image = try? map.value("image")
    }

    mutating func mapping(map: Map) {
        email >>> map["email"]
        username >>> map["username"]
        bio >>> map["bio"]
        image >>> map["image"]
    }

}
