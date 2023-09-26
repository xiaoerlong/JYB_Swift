//
//  TradeResult.swift
//  JYB_Swift
//
//  Created by kim on 2023/9/26.
//

import Foundation

// 定义交易错误码
enum TradeResult: String, Error, Codable {
    case success = "1"
    case TSCI_110_00004
}
