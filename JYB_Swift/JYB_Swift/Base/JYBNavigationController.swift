//
//  JYBNavigationController.swift
//  JYB_Swift
//
//  Created by kim on 2020/12/30.
//

import UIKit

class JYBNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.themeChangedHandler = { [unowned self] in
            // navigationBar背景颜色
            self.navigationBar.setBackgroundImage(AppTheme.manager.navigationBarBackgroundImage, for: .default)
        }
        
        // navigationBar中间title颜色
        navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)
        ]
        // navigationBar上item颜色
        navigationBar.tintColor = UIColor.white
        // navigationBar下划线颜色
        navigationBar.shadowImage = UIImage()
        // navigationBar不透明
        navigationBar.isTranslucent = false
    }
    
    // 状态栏颜色
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

extension JYBNavigationController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        
    }
    
    // 拦截跳转事件
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if children.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
        }
        
        // 修改backItem
        if children.count >= 1 {
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "popback"), style: .plain, target: self, action: #selector(tapBack))
        }
        
        super.pushViewController(viewController, animated: animated)
    }
    
    @objc private func tapBack() {
        popViewController(animated: true)
    }
}
