//
//  JYBLoginClient.swift
//  JYB_Swift
//
//  Created by kim on 2021/2/2.
//

import Foundation

// MARK: Login
extension JYBNetworkClient {
    static func login(username: String, password: String, _ completion: callback? = nil) {
        LoginProvider.request(.login(userName: username, password: password)) { (result) in
            switch result {
            case let .success(response):
                let data = response.data
                let statusCode = response.statusCode
                if statusCode != 200 {
                    return
                }
                guard let json = String.init(data: data, encoding: .utf8) else {
                    return
                }
                print(json)
                var userModel = JYBUserModel.default
                userModel = JYBUserModel.deserialize(from: json, designatedPath: "data")!
                if let completion = completion {
                    completion(userModel, nil)
                }
                UserDefaults.standard.setValue(data, forKey: USERINFORMATION)
                print(userModel)
            case let .failure(error):
                print("\(error.localizedDescription)")
                if let completion = completion {
                    completion(nil, error.localizedDescription)
                }
            }
        }
    }
}
