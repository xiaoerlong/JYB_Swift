//
//  JYBBaseViewController.swift
//  JYB_Swift
//
//  Created by kim on 2022/2/28.
//

import UIKit

class JYBBaseViewController: UIViewController {

    var navHeight: CGFloat {
        self.navigationController?.navigationBar.frame.size.height ?? 44
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        /// 如果所有的 ChildViewController 都继承于 BaseViewController，且想在 viewDidLoad 中统一设置导航栏的『左按钮』，
        /// 那么，只能设置 backBarButtonItem ，而不能设置 leftBarButtonItem，原因如下：
        ///
        /// previousVC 是上一个页面，nextVC 是下一个页面，当发生 push 时，有如下规则：
        /// 1、如果 nextVC 的 leftBarButtonItem != nil，那么将在 navigationBar 的左边显示 nextVC 指定的 leftBarButtonItem；
        /// 2、如果 nextVC 的 leftBarButtonItem == nil，previousVC 的 backBarButtonItem != nil，那么将在 navigationBar 的左边显示 previousVC 指定的 backBarButtonItem；
        /// 3、如果两者都为 nil 则：
        ///   3.1、nextVC 的 navigationItem.hidesBackButton = YES，那么 navigationBar 将隐藏左侧按钮；
        ///   3.2、否则 navigationBar的左边将显示系统提供的默认返回按钮；
        ///
        /// 我们从以上规则中发现：
        /// 1、leftBarButtonItem 的优先级比 backBarButtonItem 要高；
        /// 2、backBarButtonItem 是来自上一个页面，如果当前 VC 是第一个页面，那么它没有上一个页面，也就没有 backBarButtonItem；
        /// 3、leftBarButtonItem 是来自当前页面，与上个页面无关，因此，如果当前 VC 是第一个页面，那么设置了 leftBarButtonItem 就会很奇怪；
        ///
        if #available(iOS 14.0, *) {
            navigationItem.backBarButtonItem = UIBarButtonItem.init(title: nil, image: UIImage(), primaryAction: nil, menu: nil)
        } else {
            // Fallback on earlier versions
            navigationItem.backBarButtonItem = UIBarButtonItem.init(image: UIImage(), style: .plain, target: nil, action: nil)
        }
        navigationItem.backBarButtonItem?.tintColor = .black

        
        
        // 设置导航栏背景为透明色图片
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        // 设置导航栏阴影为透明图片
        navigationController?.navigationBar.shadowImage = UIImage()
        
    }

}

extension JYBBaseViewController {
    // 添加自定义导航栏背景
    func addNavBar(_ color: UIColor) {
        let size = CGSize.init(width: view.bounds.width, height: navHeight)
        let navImageView = UIImageView.init(image: UIImage.image(with: color, size: size))
        navImageView.tag = 100
        view.addSubview(navImageView)
        navImageView.snp.makeConstraints { make in
            make.left.right.equalTo(0)
            if #available(iOS 11.0, *) {
                make.top.equalTo(view.safeAreaInsets.top)
            } else {
                make.top.equalTo(0)
            }
            make.height.equalTo(kStatusHeight + navHeight)
        }
    }
    
    // 添加自定义导航栏背景
    func addNavBar2() {
        let navView = JYBNavigationBar.init(frame: CGRect.init(x: 0, y: 0, width: view.bounds.width, height: navHeight))
        navView.style1()
        view.addSubview(navView)
        navView.snp.makeConstraints { make in
            make.left.right.equalTo(0)
            make.top.equalTo(0)
            make.height.equalTo(kStatusHeight + navHeight)
        }
    }
}
