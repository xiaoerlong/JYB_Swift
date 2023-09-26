//
//  JYBTabBarViewController.swift
//  JYB_Swift
//
//  Created by kim on 2020/12/30.
//

import UIKit

class SomeClass: NSObject {
    @objc dynamic var someProperty: Int
    init(someProperty: Int) {
        self.someProperty = someProperty
    }
}

class JYBTabBarViewController: UITabBarController {
    
    struct Item {
        var title: String
        var normalImage: String
        var selectedImage: String
    }
    
    var products = [NSObject]()
    
    var observation: NSKeyValueObservation?

    override func viewDidLoad() {
        super.viewDidLoad()
 
        viewControllers = [
            createViewControllers(Item(title: "首页", normalImage: "selectStock", selectedImage: "selectStock_selected"), HomePageVC()),
            createViewControllers(Item(title: "报价", normalImage: "market", selectedImage: "market_selected")),
            createViewControllers(Item(title: "自选", normalImage: "porfolio", selectedImage: "porfolio_selected")),
            createViewControllers(Item(title: "资讯", normalImage: "news_tabbar_icon", selectedImage: "news_tabbar_icon_selected"), JYBNewsViewController()),
            createViewControllers(Item(title: "交易", normalImage: "trade", selectedImage: "trade_selected"), JYBTradeViewController()),
        ]
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        configFlex()
    }

    private func createViewControllers(_ item: Item, _ controller: UIViewController = UIViewController()) -> UIViewController {
        let nav = JYBNavigationController.init(rootViewController: controller)
        nav.tabBarItem.title = item.title
        nav.tabBarItem.image = UIImage.init(named: item.normalImage)?.withRenderingMode(.alwaysOriginal)
        nav.tabBarItem.selectedImage = UIImage.init(named: item.selectedImage)?.withRenderingMode(.alwaysOriginal)
        return nav
    }
    
    private func configFlex() {
        let floatView = JYBFloatView.init(CGRect.init(x: 0, y: 200, width: 50, height: 50), imageName: "FLEX", imagesAndTitle: nil, bgColor: .gray, animationColor: nil)
        floatView.clickBlocks = { i in
            FLEXManager.shared.showExplorer()
        }
        if let window = UIApplication.shared.delegate?.window {
            window?.addSubview(floatView)
        }
    }
}
