//
//  JYBLoginViewModel.swift
//  JYB_Swift
//
//  Created by kim on 2021/5/17.
//

import UIKit

class JYBLoginViewModel: NSObject {
    var errMsg: String?
    
    var account: String?
    var password: String?
    /// 登录按钮的点击状态
    var validLogin: Bool = false
    /// 是否正在执行
    var executing: Bool = false
    /// 请求失败信息
    var error: String?
    /// 请求成功数据
    var responseObject: Any?
    
    
    /// 登录
    func login() {
        guard let account = account else {
            return
        }
        guard let password = password else {
            return
        }
        executing = true
        JYBNetworkClient.login(username: account, password: password) { (response, errMsg) in
            self.executing = false
            if let errMsg = errMsg {
                self.error = errMsg
                return
            }
            if let userModel = response as? JYBUserModel {
                NotificationCenter.default.post(name: UserLoginSuccess, object: nil)
                JYBUserModel.default.account = account
                JYBUserModel.default.password = password
                // 保存历史登录账号
                UserDefaults.standard.setValue(account, forKey: "historyUserAccount")
                self.responseObject = userModel
            }
        }
    }
}
