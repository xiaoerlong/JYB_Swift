//
//  NetworkManager.swift
//  JYB_Swift
//
//  Created by kim on 2021/1/28.
//

import Foundation
import Moya


let m_newsServers = "http://fwuat.iqdii.com" // 新闻服务器域名

let NetworkProvider = MoyaProvider<NetworkAPI>()

enum NetworkAPI {
    case aaa(cityId: String)
    /// 获取标签新闻列表
    case tagNews(page: Int = 1, num: Int = 20)
}

extension NetworkAPI: TargetType {
    
    var baseURL: URL {
        switch self {
        case .aaa:
            return URL(string: "https://baidu.com")!
        case .tagNews:
            return URL(string: m_newsServers)!
        }
    }
    
    var path: String {
        switch self {
        case .aaa:
            return ""
        case .tagNews:
            return "/jybapp/news/channel_news"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .aaa:
            return .get
        case .tagNews:
            return .get
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
        case .aaa(let cityId):
            parameters["cityId"] = cityId
        case .tagNews(page: let page, num: let num):
            parameters["page"] = page
            parameters["num"] = num
            parameters["cid"] = "JRGZ"
        }
        return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
    }
    
        // 请求头
    var headers: [String : String]? {
        return ["Content-Type": "application/json",
                "Authorization": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJqeWJ1c2VyIiwiaXNzIjoid3d3LnRyYWRlZ284LmNvbSIsImV4cCI6MTYxMzQ0NzMxMiwiaWF0IjoxNjExNjQ3MzEyLCJqdGkiOiI4ODY5MjMxMDAifQ.9bi9NaTb9vqk-xw0hlm4ALAjjwjpZmEpo4SQ3p-ICls"]
    }
    
    
}



