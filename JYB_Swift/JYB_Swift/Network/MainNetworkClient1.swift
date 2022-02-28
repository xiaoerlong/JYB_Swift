//
//  MainNetworkClient1.swift
//  JYB_Swift
//
//  Created by kim on 2022/2/25.
//

import Foundation

struct MainNetworkClient1 {
    typealias callback = (Any?, String?) -> Void
    
    // 请求服务器列表
    static func requestJYBServer() {
        MainNetworkProvider.request(.servers) { result in
            switch result {
            case let .success(response):
                let data = response.data
                let statusCode = response.statusCode
                if statusCode != 200 {
                    print("请求错误")
                    return
                }
                guard let json = String.init(data: data, encoding: .utf8) else {
                    print("data 转 json 错误")
                    return
                }
                if let baseModel = ResponseBaseModel.deserialize(from: json) {
                    if baseModel.result == 1 {
                        if let serverModel = ServerModel.deserialize(from: baseModel.data) {
                            JYBServerManager.shared.serverModel = serverModel
                            // TODO: 数据保存到本地
                        }
                    } else {
                        print(baseModel.msg ?? "")
                    }
                }
            case let .failure(error):
                print(error)
            }
        }
    }
}
