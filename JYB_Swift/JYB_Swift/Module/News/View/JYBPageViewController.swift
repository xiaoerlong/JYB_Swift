//
//  JYBPageViewController.swift
//  JYB_Swift
//
//  Created by kim on 2021/1/26.
//

import UIKit

class JYBPageViewController: UIViewController {

    var viewControllers = [UIViewController]()
    var currentIndex: NSInteger = 0
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isPagingEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.red.cgColor
        
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalTo(0)
        }
        
        for (index, controller) in viewControllers.enumerated() {
            addChild(controller)
            scrollView.addSubview(controller.view)
            controller.didMove(toParent: self)
            controller.view.snp.makeConstraints { (make) in
                make.size.equalTo(view)
                make.top.equalTo(0)
                make.left.equalTo(CGFloat(index) * view.frame.size.width)
            }
            
//            controller.view.layoutIfNeeded()
        }
        scrollView.contentSize = CGSize.init(width: CGFloat(viewControllers.count) * view.frame.size.width, height: 0)
    }

}
