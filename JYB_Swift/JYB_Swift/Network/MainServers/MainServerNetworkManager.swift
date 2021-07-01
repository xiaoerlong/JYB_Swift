//
//  MainServerNetworkManager.swift
//  JYB_Swift
//
//  Created by kim on 2021/3/25.
//

import Foundation

let m_mainServers = "http://JybApiSit.iqdii.com" // 主服务器域名

let MainProvider = MoyaProvider<MainAPI>()

enum MainAPI {
    case getCustomIcons
    case homeIconList
}

extension MainAPI: TargetType {
    
    var baseURL: URL {
        return URL(string: m_mainServers)!
    }
    
    var path: String {
        switch self {
        case .getCustomIcons:
            return "/jybapp/Config/GetCustomIcons"
        case .homeIconList:
            return "/jybapp/Config/HomeIconList"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getCustomIcons:
            return .post
        case .homeIconList:
            return .post
        }
    }
    
    // 单元测试模拟数据
    var sampleData: Data {
        return "{}".data(using: .utf8)!
    }
    
    var task: Task {
        var parameters = [String: Any]()
        parameters["lang"] = "cht";
        parameters["mobile"] = "18162579527";
        parameters["network"] = "WiFi";
        parameters["org"] = "org_jyb_mob";
        parameters["session"] = "B94B20C650F0E8B13369FA33";
        parameters["theme"] = "dark";
        parameters["uid"] = "886923100";
        parameters["ver"] = "7.3.60";
        
        switch self {
        case .getCustomIcons:
            parameters["mode"] = "ios"
            parameters["resourcetype"] = ""
            parameters["source"] = "APP"
        case .homeIconList:
            parameters["mode"] = "ios"
            parameters["resourcetype"] = ""
            parameters["source"] = "APP"
            parameters["new"] = 1
        }
        return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
    }
    
        // 请求头
    var headers: [String : String]? {
        return ["Content-Type": "application/json",
                "Authorization": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJqeWJ1c2VyIiwiaXNzIjoid3d3LnRyYWRlZ284LmNvbSIsImV4cCI6MTYxMzQ0NzMxMiwiaWF0IjoxNjExNjQ3MzEyLCJqdGkiOiI4ODY5MjMxMDAifQ.9bi9NaTb9vqk-xw0hlm4ALAjjwjpZmEpo4SQ3p-ICls"]
    }
    
    
}



