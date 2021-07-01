//
//  MainNetworkClient.swift
//  JYB_Swift
//
//  Created by kim on 2021/3/25.
//

import Foundation

class MainNetworkClient {
    typealias callback = (Any?, String?) -> Void
    
    static func requestCustomIcons(completion: callback? = nil) {
        MainProvider.request(.getCustomIcons) { (result) in
            switch result {
            case let .success(response):
                print(response)
            case let .failure(error):
                print("\(error.localizedDescription)")
                if let completion = completion {
                    completion(nil, error.localizedDescription)
                }
            }
        }
    }
    
    static func requestHomeIconList(completion: callback? = nil) {
        MainProvider.request(MainAPI.homeIconList) { (result) in
            switch result {
            case let .success(response):
                print(response)
            case let .failure(error):
                print("\(error.localizedDescription)")
                if let completion = completion {
                    completion(nil, error.localizedDescription)
                }
            }
        }
    }
}
