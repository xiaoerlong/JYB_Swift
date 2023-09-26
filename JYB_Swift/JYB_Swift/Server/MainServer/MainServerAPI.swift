//
//  MainServerAPI.swift
//  JYB_Swift
//
//  Created by kim on 2022/2/28.
//

import Foundation
import Moya

// main服务器 接口
let MainServerProvider = MoyaProvider<MainServerAPI>()

enum MainServerAPI {
    case anonymous_login // 匿名登录
    
    case service_price // 查询用户服务包
}

extension MainServerAPI: TargetType {
    
    var baseURL: URL {
        return URL.init(string: JYBServerManager.shared.main_server)!
    }
    
    var path: String {
        switch self {
        case .anonymous_login:
            return "/jybapp/login/anonymous-login"
        case .service_price:
            return "/jybapp/service/price"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .anonymous_login:
            return .post
        case .service_price:
            return .get
        }
    }
    
    // 单元测试模拟数据
    var sampleData: Data {
        return "{}".data(using: .utf8)!
    }
    
    var task: Task {
        var parameters = [String: Any]()
        
        switch self {
        case .anonymous_login: break
            
        case .service_price:
            parameters["session"] = JYBUserModel.default.session ?? ""
        }
        return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
    }
    
        // 请求头
    var headers: [String : String]? {
        return nil
//        return ["Content-Type": "application/json",
//                "Authorization": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJqeWJ1c2VyIiwiaXNzIjoid3d3LnRyYWRlZ284LmNvbSIsImV4cCI6MTYxMzQ0NzMxMiwiaWF0IjoxNjExNjQ3MzEyLCJqdGkiOiI4ODY5MjMxMDAifQ.9bi9NaTb9vqk-xw0hlm4ALAjjwjpZmEpo4SQ3p-ICls"]
    }
    
    
}
