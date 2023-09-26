//
//  MainServerClient.swift
//  JYB_Swift
//
//  Created by kim on 2022/2/28.
//

import Foundation

struct MainServerClient {
    typealias callback = (Any?, String?) -> Void
    
    // 匿名登录
    static func anonymousLogin(_ completion: (()-> Void)?) {
        MainServerProvider.request(.anonymous_login) { result in
            switch result {
            case let .success(response):
                let data = response.data
                print(data)
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
                        if let userModel = JYBUserModel.deserialize(from: baseModel.data) {
                            userModel.saveUserMessage()
                            print("匿名登录成功")
                            if let completion = completion {
                                completion()
                            }
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

extension MainServerClient {
    // 查询用户服务包
    static func queryUserServicePkgs() {
        MainServerProvider.request(.service_price) { result in
            switch result {
            case let .success(response):
                let data = response.data
                print(data)
                let statusCode = response.statusCode
                if statusCode != 200 {
                    print("请求错误")
                    return
                }
                guard let json = String.init(data: data, encoding: .utf8) else {
                    print("data 转 json 错误")
                    return
                }
                print("查询用户服务包:\(json)")
                if let baseModel = ResponseBaseModel.deserialize(from: json) {
                    if baseModel.result == 1 {
                        if let pkg = PkgData.deserialize(from: baseModel.data) {
                            print(pkg)
                            JYBUserModel.default.pkgData = pkg
                            
                            // TODO: 权限发生变化重连
                        }
                    }
                }
                
                
            case let .failure(error):
                print(error)
            }
        }
    }
}
