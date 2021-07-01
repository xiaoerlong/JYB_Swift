//
//  Theme.swift
//  JYB_Swift
//
//  Created by kim on 2020/12/30.
//

import UIKit

/// APP主题
class AppTheme {
    static let manager = AppTheme()
    
    enum `Type`: String, CaseIterable {
        case `default` = "白天模式" // 默认
        case dark = "夜间模式" // 暗色
    }
    
    private var theme: Type {
        set {}
        get {
            guard let themeType = UserDefaults.standard.value(forKey: "ThemeType") as? String else {
                return .default
            }
            return Type(rawValue: themeType) ?? .default
        }
    }
    var currentTheme: Type {
        return theme
    }
    
    typealias SwitchThemeBlock = () -> Void
    
    func setLastedTheme() {
        setTheme(theme)
    }
    
    // 设置主题
    func setTheme(_ type: Type) {
        self.theme = type
        UserDefaults.standard.setValue(type.rawValue, forKey: "ThemeType")
        NotificationCenter.default.post(name: ThemeNotificationName, object: nil)
    }
    
}

extension AppTheme {
    func imageName(_ name: String) -> String {
        switch theme {
        case .default:
            return name
        case .dark:
            return name + "_deep"
        }
    }
}

// MARK: NavigationBar
extension AppTheme {
    var navigationBarBackgroundImage: UIImage? {
        switch theme {
        case .default:
            return UIImage.init(named: "navigation-bg")
        case .dark:
            return UIImage.image(with: UIColor(hex: 0x1d2332))
        }
    }
}

extension AppTheme {
    var itemBackgroundColor: UIColor {
        switch theme {
        case .default:
            return .white
        case .dark:
            return UIColor(hex: 0x1b202c)
        }
    }
    
    var deep_c2c2c2_333333: UIColor {
        switch theme {
        case .default:
            return UIColor(hex: 0x333333)
        case .dark:
            return UIColor(hex: 0xc2c2c2)
        }
    }
    
    var deep_262c3e_f9f9f9: UIColor {
        switch theme {
        case .default:
            return UIColor(hex: 0xF9F9F9)
        case .dark:
            return UIColor(hex: 0x262C3E)
        }
    }
    
    var deepSkinGrayColor: UIColor {
        switch theme {
        case .default:
            return UIColor(hex: 0x999999)
        case .dark:
            return UIColor(hex: 0x88929e)
        }
    }
    
    var deepSkinBlackColor: UIColor {
        switch theme {
        case .default:
            return UIColor(hex: 0x333333)
        case .dark:
            return UIColor(hex: 0xffffff)
        }
    }
    
    var deepSkinBackgroundColor: UIColor {
        switch theme {
        case .default:
            return UIColor(hex: 0xeeeeee)
        case .dark:
            return UIColor(hex: 0x0f131d)
        }
    }
    
    var deepSkinSeparateLineColor: UIColor {
        switch theme {
        case .default:
            return UIColor(hex: 0xe5e5e5)
        case .dark:
            return UIColor(hex: 0x040910)
        }
    }
}
