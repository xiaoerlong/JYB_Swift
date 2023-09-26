//
//  UserServicePkgsModel.swift
//  JYB_Swift
//
//  Created by kim on 2022/2/28.
//

import Foundation


struct UserServicePkgsModel: HandyJSON {
    var ggt: String?
    var pt: String? // 当前行情 0：延时 1：实时 2BMP
    var pl: String? // 用户档位 1 5 10
    var country_id: String?
    var IPAddress: String?
    var ChinaUser: String?
    var authorityMsg: String?
    var UsDelayQuotation: String?
    var SupportGroupAccount: String?
    var MarketPowerList: [MarketPowerList]?
    
}
