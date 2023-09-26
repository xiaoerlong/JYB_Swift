//
//  TradeUserModel.swift
//  JYB_Swift
//
//  Created by kim on 2023/9/26.
//

import Foundation

/// 全局访问的用户模型
struct TradeUserModel {
    var user_name: String
    var account_type: AccountType
    var market_account_type: Int // 交易盘型
    var session: String
    var last_login_time: String
    
    enum AccountType: Int {
        case cash = 0
        case margin = 1
        case ae = 99
    }
}
