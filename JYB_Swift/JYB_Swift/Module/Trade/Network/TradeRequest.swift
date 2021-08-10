//
//  TradeRequest.swift
//  JYB_Swift
//
//  Created by kim on 2021/1/4.
//

import Foundation
import UIKit
import XMLMapper

class TradeRequest: XMLMappable {
    var language: String!
    var terminal_type: String!
    var encoding: String!
    var device_code = UUID().uuidString
    var deivce_name = UIDevice.current.name
    var session: String!
    var station: String!
    var msgnum: Int!
    var version: String!
    
    var nodeName: String!
    
    init() {
        terminal_type = "IPHONE"
        encoding = "UTF8"
        language = "CHS"
        msgnum = Int(100 + arc4random_uniform(899))
        version = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as? String
    }
    
    required init?(map: XMLMap) { }
    
    func mapping(map: XMLMap) {
        terminal_type <- map["terminal_type"]
        encoding <- map["encoding"]
        session <- map["session"]
        station <- map["station"]
        language <- map["language"]
        msgnum <- map.attributes["msgnum"]
        version <- map.attributes["version"]
    }
}

class LoginRequest: TradeRequest {
    var user_id: String!
    var password: String!
    
    override init() {
        super.init()
        nodeName = "login"
        user_id = "222222"
        password = "ts1456"
    }
    
    required init?(map: XMLMap) {
        super.init(map: map)
    }
    
    override func mapping(map: XMLMap) {
        super.mapping(map: map)
        user_id <- map["user_id"]
        password <- map["password"]
    }
}
