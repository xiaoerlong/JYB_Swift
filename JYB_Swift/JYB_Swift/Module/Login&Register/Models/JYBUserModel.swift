//
//  JYBUserModel.swift
//  JYB_Swift
//
//  Created by kim on 2021/2/2.
//

import UIKit

class JYBUserModel: HandyJSON {
    var pkgData: PkgData?
    var readSource: String?
    var session: String?
    var uid: String?
    var userId: String?
    var profile: Profile?
    var passport: HandyJSON?
    
    var account: String?
    var password: String?
    
    required internal init() {}
    
    static let `default` = JYBUserModel()
    
    // 保存用户登录信息
    func saveUserMessage() {
        let userModel = JYBUserModel.default
        userModel.clearUserMessage()
        
        userModel.session = session
        userModel.userId = userId
        // TODO: 赋值更多
    }
    
    func clearUserMessage() {
        session = nil
        uid = nil
        profile = nil
        pkgData = nil
        readSource = nil
        passport = nil
        
        account = nil
        password = nil
    }
    
    func avatarImage() -> UIImage? {
        var targetImage: UIImage?
        if let uid = JYBUserModel.default.uid, uid.count > 0 {
            targetImage = UIImage.init(contentsOfFile: "")
            if let image = targetImage {
                targetImage = image.roundImage()?.scale(to: CGSize.init(width: 32, height: 32))
            } else {
                targetImage = UIImage.init(named: "pc-avatar-login")
            }
        } else {
            targetImage = UIImage.init(named: "avatar-notlogin")
        }
        targetImage = targetImage?.withRenderingMode(.alwaysOriginal)
        return targetImage
    }
}

struct Passport: HandyJSON {
    var mail: String?
    var ph_verified: Int = 0
    var mail_verified: Int = 0
    var un: String?
    var has_pass: Int = 0
    var ph: String?
    var _3rd_bind: _3rd_bind?
}

struct _3rd_bind: HandyJSON {
    var simulatetrade: Simulatetrade?
    var hq: Hq?
    var fb: Fb?
}

struct Fb: HandyJSON {
    var uid: String?
    var unn: String?
}

struct Hq: HandyJSON {
    var uid: String?
    var unn: String?
}

struct Simulatetrade: HandyJSON {
    var uid: String?
    var unn: String?
}

struct Profile: HandyJSON {
    var unn: String?
    var lang: String?
    var head_url: String?
    var personalProfile: String?
}

struct PkgData: HandyJSON {
    var ggt: String?
    var authorityMsg: String?
    var pl: String?
    var chinaUser: String?
    var mk: [String]?
    var marketPowerList: [MarketPowerList]?
    var country_id: String?
    var pkg: [Pkg]?
}

struct Pkg: HandyJSON {
    var id: String?
    var date: String?
    var total: Int = 0
}

struct MarketPowerList: HandyJSON {
    var powerLevel: Int = 0
    var powerType: Int = 0
    var attached: Attacted?
    var market: String?
}

struct Attacted: HandyJSON {
    var tradeDetailsTotal: Int = 0
}
