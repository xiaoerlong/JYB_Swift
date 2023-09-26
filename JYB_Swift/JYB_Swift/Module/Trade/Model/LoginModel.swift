//
//  LoginModel.swift
//  JYB_Swift
//
//  Created by kim on 2023/8/23.
//

import Foundation
import XMLCoder

enum Language: String, Codable {
    case chs = "CHS"
    case cht = "CHT"
    case eng = "ENG"
}

struct LoginRequest: Codable {
    let user_id: String // 登录 ID
    let password: String // 用户密码
    var terminal_type: String = "IPHONE"
    var language: Language = .chs
    var encoding: String = "UTF8"
    var session: String? = nil // 回话 id
    var station: String? = nil // 券商机构
    let extra: Extra // 附加数据
    
    struct Extra: Codable, DynamicNodeEncoding {
        var login_type: Int = 0 // 登录类型
        var phone_code: String? = nil // 手机号
        var area_code: String? = nil // 区号
        var opt_code: String? = nil // 验证码
        var device_code: String? = UUID().uuidString // 设备编码
        var device_name: String? = UIDevice.current.name // 设备名称
        var otp_type: String? = nil
        var trust_device: String? = nil
        var app_version: String? = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
        
        static func nodeEncoding(for key: CodingKey) -> XMLEncoder.NodeEncoding {
            return .attribute
        }
    }
    
}

struct LoginResponse: Codable {
    var result: TradeResult
    var err_msg: String?
    var last_login_time: String?
    var user_name: String?
    var account_type: Int
    var Market_AccountType: Int // 市场
    var hash_code: Int
    var session: String?
    var login_type: Int?
    var opt_code: String?
    var device_code: String?
    var device_name: String?
    var app_version: String?
}
