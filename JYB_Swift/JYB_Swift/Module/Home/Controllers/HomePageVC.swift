//
//  HomePageVC.swift
//  JYB_Swift
//
//  Created by kim on 2021/3/25.
//

import UIKit

class HomePageVC: UIViewController {
    // MARK: Properties
    // view的整体
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView.init(arrangedSubviews: [HomeAppsVC.shared.topView, scrollView])
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    // scrollView的内容视图
    private lazy var stackViewInScrollView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        // HomeAppsVC
        addChild(HomeAppsVC.shared)
        stackView.addArrangedSubview(HomeAppsVC.shared.bottomView)
        HomeAppsVC.shared.didMove(toParent: self)
        // other
        let controller = UIViewController()
        controller.view.backgroundColor = .red
        addChild(controller)
        stackView.addArrangedSubview(controller.view)
        controller.didMove(toParent: self)
        return stackView
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.alwaysBounceVertical = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.backgroundColor = AppTheme.manager.deepSkinBlackColor
        if #available(iOS 11.0, *) {
            scrollView.contentInsetAdjustmentBehavior = .never
        }
        scrollView.addSubview(stackViewInScrollView)
        stackViewInScrollView.snp.makeConstraints { (make) in
            make.edges.equalTo(scrollView)
            make.width.equalTo(scrollView)
        }
        return scrollView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = AppTheme.manager.deepSkinBlackColor
//        edgesForExtendedLayout = .all
//        view.addSubview(stackView)
//        stackView.snp.makeConstraints { (make) in
//            make.edges.equalTo(view)
//        }
//
//        HomeAppsVC.shared.request()
        
//        guard let url = JYBUserModel.default.profile?.head_url else {
//            return
//        }
        let imageView = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: 32, height: 32))
        imageView.image = JYBUserModel.default.avatarImage()
//        imageView.kf.setImage(with: URL(string: url), placeholder: JYBUserModel.default.avatarImage())
        
        let leftItem = UIBarButtonItem.init(customView: imageView)
        navigationItem.leftBarButtonItem = leftItem
    }
    

    
}
