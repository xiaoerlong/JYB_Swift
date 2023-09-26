//
//  MainNetworkAPI.swift
//  JYB_Swift
//
//  Created by kim on 2022/2/25.
//

import Foundation
import Moya

// jybapisit服务器 接口信息
let MainNetworkProvider = MoyaProvider<MainNetworkAPI>()

enum MainNetworkAPI {
    case servers
}

extension MainNetworkAPI: TargetType {
    
    var baseURL: URL {
        switch self {
        case .servers:
            return URL.init(string: "http://jybapisit.iqdii.com")!
        }
    }
    
    var path: String {
        switch self {
        case .servers:
            return "/jybapp/other/servers"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .servers:
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
        case .servers:
            parameters["uid"] = ""
            parameters["org"] = "org_jyb"
            parameters["country"] = "cn"
        }
        
        return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
    }
    
        // 请求头
    var headers: [String : String]? {
        return ["Content-Type": "application/json",
                "Authorization": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJqeWJ1c2VyIiwiaXNzIjoid3d3LnRyYWRlZ284LmNvbSIsImV4cCI6MTYxMzQ0NzMxMiwiaWF0IjoxNjExNjQ3MzEyLCJqdGkiOiI4ODY5MjMxMDAifQ.9bi9NaTb9vqk-xw0hlm4ALAjjwjpZmEpo4SQ3p-ICls"]
    }
    
    
}
