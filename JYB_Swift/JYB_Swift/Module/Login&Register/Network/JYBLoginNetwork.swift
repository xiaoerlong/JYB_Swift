//
//  JYBLoginNetwork.swift
//  JYB_Swift
//
//  Created by kim on 2021/2/2.
//

import Foundation
import Moya


let LoginProvider = MoyaProvider<LoginAPI>()

enum LoginAPI {
    /// 账号密码登录
    case login(userName: String, password: String)
}

extension LoginAPI: TargetType {
    
    var baseURL: URL {
        switch self {
        case .login:
            return URL(string: m_mainServers)!
        }
    }
    
    var path: String {
        switch self {
        case .login:
            return "/jybapp/login/base-login"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .login:
            return .post
        }
    }
    
    // 单元测试模拟数据
    var sampleData: Data {
        return "{}".data(using: .utf8)!
    }
    
    var task: Task {
        var parameters = [String: Any]()
        parameters["mobile"] = "ios"
        parameters["org"] = "org_jyb_mob"
        parameters["lang"] = "cht"
        parameters["ver"] = "7.3.70"
        parameters["version"] = "6.0"
        parameters["network"] = "WIFI"
        
        switch self {
        case .login(userName: let userName, password: let password):
            parameters["userName"] = userName
            parameters["password"] = password
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        }
//        return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
    }
    
        // 请求头
    var headers: [String : String]? {
        return ["Authorization": "",
                "Content-Type": "application/json"]
    }
}




