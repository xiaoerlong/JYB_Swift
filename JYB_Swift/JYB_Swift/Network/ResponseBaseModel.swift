//
//  ResponseBaseModel.swift
//  JYB_Swift
//
//  Created by kim on 2022/2/25.
//

import Foundation

struct ResponseBaseModel: HandyJSON {
    var result: Int?
    var msg: String?
    var data: Dictionary<String, AnyObject>?
    
    init() {
    }
    
    
}
