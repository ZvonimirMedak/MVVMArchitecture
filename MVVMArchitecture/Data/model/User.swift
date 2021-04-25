//
//  User.swift
//  MVVMArchitecture
//
//  Created by Zvonimir Medak on 24.04.2021..
//

import Foundation
import ObjectMapper

class User: Codable, Mappable{
    
    var id: Int = 0
    var name: String = ""
    var email: String = ""
    var avatar: String = ""
    
    required init?(map: Map) {
    }
    
    public init(id: Int, name: String, email: String, avatar: String) {
        self.id = id
        self.name = name
        self.email = email
        self.avatar = avatar
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        email <- map["email"]
        avatar <- map["avatar"]
    }
}
