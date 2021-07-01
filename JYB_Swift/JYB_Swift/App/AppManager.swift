//
//  AppManager.swift
//  JYB_Swift
//
//  Created by kim on 2021/3/26.
//

import Foundation
import UIKit

/// 应用全局管理数据
class AppManager {
    static let manager = AppManager()
    
    // 上一次的版本号
    var oldVersion: String?
    
    // 存储版本号
    func saveVersion() {
        oldVersion = UserDefaults.standard.value(forKey: "LastBundleVersion") as? String
        
        let currentVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
        UserDefaults.standard.setValue(currentVersion, forKey: "LastBundleVersion")
    }
    
    // 获取当前版本号
    func getCurrentVersion() -> String? {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
    }
    
    // 更新版本或者新装
    func isNewVersion() -> Bool {
        guard let oldVersion = oldVersion else { return true }
        guard let currentVersion = getCurrentVersion() else { return true }
        if oldVersion.compare(currentVersion) == .orderedAscending {
            return true
        }
        return false
    }
}
