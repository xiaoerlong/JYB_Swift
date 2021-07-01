//
//  JYBNetworkClient.swift
//  JYB_Swift
//
//  Created by kim on 2021/1/27.
//

class JYBNetworkClient {
    typealias callback = (Any?, String?) -> Void
    
    static func requestTagNews(page: Int = 1, num: Int = 20, completion: callback? = nil) {
        NetworkProvider.request(.tagNews(page: page, num: num)) { (result) in
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
                if let user = BaseModel.deserialize(from: json) {
                    print("user:\(user)")
                    if let completion = completion {
                        completion(user.data?.list, nil)
                    }
                }
            case let .failure(error):
                print("\(error.localizedDescription)")
                if let completion = completion {
                    completion(nil, error.localizedDescription)
                }
            }
        }
    }
}


