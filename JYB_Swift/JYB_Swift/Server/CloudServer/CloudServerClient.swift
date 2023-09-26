//
//  CloudServerClient.swift
//  JYB_Swift
//
//  Created by kim on 2022/2/28.
//

import Foundation

struct CloudServerClient {
    typealias callback = (Any?, String?) -> Void
    
    // 请求token
    static func requestJsonWebToken(_ completion: (()-> Void)? = nil) {
        CloudServerProvider.request(.token) { result in
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
                print("请求token:\(json)")
                
            case let .failure(error):
                print(error)
            }
        }
    }
}
