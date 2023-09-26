//
//  AppDelegate.swift
//  JYB_Swift
//
//  Created by kim on 2020/12/30.
//

import UIKit

class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        initThirdSDK()
        initAppTool()
        initAppEnvironment()
        
//        AppTheme.manager.setLastedTheme()
//        AppManager.manager.saveVersion()
        
        return true
    }
}

// MARK: 第三方SDK初始化
extension AppDelegate {
    private func initThirdSDK() {
        setupFBSDK()
        setupJPush()
        setupLoginOauthSDK()
        setupUMSocial()
        setupBugly()
    }
    
    // Facebook
    private func setupFBSDK() {
        
    }
    
    // JPush
    private func setupJPush() {
        
    }
    
    // 一键登录SDK
    private func setupLoginOauthSDK() {
        
    }
    
    // 友盟
    private func setupUMSocial() {
        
    }
    
    // bugly
    private func setupBugly() {
        
    }
}

// MARK: App工具类初始化
extension AppDelegate {
    private func initAppTool() {
        setupAvoidCrash()
        startMonitor()
        addTimerWhenAppDidLaunch()
    }
    
    // AvoidCrash
    private func setupAvoidCrash() {
        
    }
    
    // 开启网络监听
    private func startMonitor() {
        
    }
    
    // 开启用户操作监听
    private func addTimerWhenAppDidLaunch() {
        if JYBApplication.shared.responds(to: Selector.init(("resetIdelTimer"))) {
            JYBApplication.shared.perform(Selector.init(("resetIdelTimer")))
        }
    }
}

// MARK: App运行环境配置
extension AppDelegate {
    private func initAppEnvironment() {
        setupRootWindow()
//        requestServerList()
//        requestUserLoginInfo()
        displayAppIntroduceView()
        

        UserDefaults.standard.setValue(Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString"), forKey: "AppVersion")
    }
    
    // 设置根视图
    private func setupRootWindow() {
        window = UIWindow.init(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white
        window?.rootViewController = JYBNavigationController.init(rootViewController: JYBTradeLoginViewController())
//        window?.rootViewController = TestViewController()
        window?.makeKeyAndVisible()
    }
    
    // 请求服务器地址
    private func requestServerList() {
        MainNetworkClient1.requestJYBServer()
    }
    
    // 请求行情购买配置信息
    
    
    // 请求用户登录信息
    private func requestUserLoginInfo() {
        if let _ = JYBUserModel.default.userId {
            print("refresh token")
            
        } else {
            MainServerClient.anonymousLogin {
                CloudServerClient.requestJsonWebToken()
                MainServerClient.queryUserServicePkgs()
            }
        }
        print("查询服务包")
        print("查询用户未读消息") // 可以放到后面吧
    }
    
    // 显示欢迎页
    private func displayAppIntroduceView() {
        guard let window = window else { return }
        let currentVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
        guard let currentVersion = currentVersion else { return }
        if let AppVersion = UserDefaults.standard.value(forKey: "AppVersion") as? String, currentVersion > AppVersion {
            UserDefaults.standard.setValue(false, forKey: WelcomeView.kWelcomeString)
        }
        if UserDefaults.standard.bool(forKey: WelcomeView.kWelcomeString) {
            return
        }
        WelcomeView.showView(window)
    }
}
