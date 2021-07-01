//
//  HomeAppModel.swift
//  JYB_Swift
//
//  Created by kim on 2021/3/24.
//

import UIKit

struct HomeAppModel: HandyJSON {
    var id: String?
    var isTop: Bool = false
    var org: String?
    var iconNo: String?
    var menuIcon: String?
    var chsName: String?
    var browserWay: String?
    var version: String?
    var redirectLink: String?
    var isDefault: String?
    var menuIconNew: String?
    var recommendIcon: String?
    var resourceType: String?
    var type: String?
    var groupName: String?
    var mode: String?
    var sorting: String?
    var versionExclude: String?
    var chtName: String?
    
    var isLastedUse: Bool = false // 是否为最近使用
    var lastedSort: TimeInterval = 0 // 最近使用排序(以时间戳排序)
}
