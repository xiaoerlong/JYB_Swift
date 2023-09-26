//
//  CloudServerAPI.swift
//  JYB_Swift
//
//  Created by kim on 2022/2/28.
//

import Foundation
import Moya

// jybapisit服务器 接口信息
let CloudServerProvider = MoyaProvider<CloudServerAPI>()

enum CloudServerAPI {
    case token
}

extension CloudServerAPI: TargetType {
    
    var baseURL: URL {
        return URL.init(string: JYBServerManager.shared.cloud_server)!
    }
    
    var path: String {
        switch self {
        case .token:
            return "/token"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .token:
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
        case .token:
            parameters["uid"] = JYBUserModel.default.userId ?? ""
            parameters["sessionId"] = JYBUserModel.default.session ?? ""
        }
        print("param:\(parameters)")
        return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
    }
    
        // 请求头
    var headers: [String : String]? {
        return nil
//        return ["Content-Type": "application/json",
//                "Authorization": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJqeWJ1c2VyIiwiaXNzIjoid3d3LnRyYWRlZ284LmNvbSIsImV4cCI6MTYxMzQ0NzMxMiwiaWF0IjoxNjExNjQ3MzEyLCJqdGkiOiI4ODY5MjMxMDAifQ.9bi9NaTb9vqk-xw0hlm4ALAjjwjpZmEpo4SQ3p-ICls"]
    }
    
    
}
