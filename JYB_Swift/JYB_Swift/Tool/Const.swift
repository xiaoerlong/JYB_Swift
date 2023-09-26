//
//  Const.swift
//  JYB_Swift
//
//  Created by kim on 2021/1/4.
//

import Foundation
import UIKit

typealias BYTE = CUnsignedChar


let kScreenWidth = UIScreen.main.bounds.size.width
let kScreenHeight = UIScreen.main.bounds.size.height
let kStatusHeight = UIApplication.shared.statusBarFrame.height


// MARK: Color
let JYBColor_SeparateLine = UIColor(hex: 0xe5e5e5)
let JYBColor_Gray = UIColor(hex: 0x999999)


// MARK: Notification
let ThemeNotificationName = Notification.Name.init("ThemeNotificationName")
let UserLoginSuccess = Notification.Name.init("UserLoginSuccess")


// MARK: Const
// 用户信息存储
let USERINFORMATION = "user_information_V5.0.0"
