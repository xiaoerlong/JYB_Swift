//
//  JYBServerManager.swift
//  JYB_Swift
//
//  Created by kim on 2022/2/28.
//

import UIKit

/// jyb 服务器管理类
class JYBServerManager: NSObject {
    static let shared = JYBServerManager()
    
    var serverModel: ServerModel?
    
    var main_server: String {
        guard let server = serverModel?.mainsvr else {
            // TODO: 这里要判断UAT还是生产
            print("匿名登录时还没有请求到用哪个服务器，走这里")
            return "http://JybApiSit.iqdii.com"
        }
        return server
    }
    
    var cloud_server: String {
        guard let server = serverModel?.Cloud_Service else {
            // TODO: 这里要判断UAT还是生产
            return "http://cloudapiuat.iqdii.com"
        }
        return server
    }
}
