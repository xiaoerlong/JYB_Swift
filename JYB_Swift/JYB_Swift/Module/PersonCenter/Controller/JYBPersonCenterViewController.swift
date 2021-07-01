//
//  JYBPersonCenterViewController.swift
//  JYB_Swift
//
//  Created by kim on 2021/1/12.
//

import UIKit

/// 个人中心主页
class JYBPersonCenterViewController: UIViewController {
    
    struct PersonCenterItem {
        var imageName: String
        var title: String
        var detail: String?
    }
    private var items = [
        PersonCenterItem(imageName: "collect", title: "我的收藏", detail: nil),
        PersonCenterItem(imageName: "my_point", title: "我的观点", detail: nil),
        PersonCenterItem(imageName: "活动icon", title: "热门活动", detail: "【2020-2021年度港股新股KOL嘉年华】"),
        PersonCenterItem(imageName: "inviateFriends", title: "邀请好友", detail: nil),
        PersonCenterItem(imageName: "suggest_feedBack", title: "意见反馈", detail: nil),
        PersonCenterItem(imageName: "shareApp", title: "分享APP", detail: nil)
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        setNavigationBar()
        setupView()
        self.themeChangedHandler = { [unowned self] in
            self.view.backgroundColor = AppTheme.manager.deepSkinBackgroundColor
        }
    }
    
    private func setNavigationBar() {
        navigationItem.title = "个人中心"
        let rightItem1 = UIBarButtonItem.init(image: UIImage.init(named: "hp-message"), style: .plain, target: self, action: #selector(methodTips))
        let rightItem2 = UIBarButtonItem.init(image: UIImage.init(named: "pc-setting"), style: .plain, target: self, action: #selector(setting))
        navigationItem.rightBarButtonItems = [rightItem2, rightItem1]
    }
    
    private func setupView() {
        let loginOptionVC = JYBLoginOptionViewController()
        addChild(loginOptionVC)
        view.addSubview(loginOptionVC.view)
        loginOptionVC.didMove(toParent: self)
        loginOptionVC.view.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.top.equalTo(10)
            make.height.equalTo(200)
        }
        
        let cycleView = JYBCycleScrollView.init(with: ["中签分享", "申购了分享图", "弹框底"])
        cycleView.backgroundColor = AppTheme.manager.deepSkinBackgroundColor
        view.addSubview(cycleView)
        cycleView.snp.makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.top.equalTo(loginOptionVC.view.snp.bottom).offset(10)
            make.height.equalTo(60)
        }
        var lastView: UIView = cycleView
        for item in items {
            let itemView = createItem(with: item)
            view.addSubview(itemView)
            itemView.snp.makeConstraints { (make) in
                make.left.right.equalTo(0)
                make.height.equalTo(72)
                make.top.equalTo(lastView.snp.bottom)
            }
            lastView = itemView
        }
    }
    
    @objc private func methodTips() {
        
    }

    @objc private func setting() {
        let vc = JYBSettingViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func tapItem() {
        
    }
    
    private func createItem(with item: PersonCenterItem) -> UIControl {
        let control = UIControl()
        control.addTarget(self, action: #selector(tapItem), for: .touchUpInside)
        let imageView = UIImageView.init(image: UIImage.init(named: item.imageName))
        control.addSubview(imageView)
        let label = UILabel()
        label.text = item.title
        label.textColor = AppTheme.manager.deepSkinBlackColor
        label.font = UIFont.systemFont(ofSize: 16)
        control.addSubview(label)
        let arrowImageView = UIImageView.init(image: UIImage.init(named: AppTheme.manager.imageName("pc-arrow-right")))
        control.addSubview(arrowImageView)
        
        imageView.snp.makeConstraints { (make) in
            make.left.equalTo(13)
            make.centerY.equalTo(control)
            make.size.equalTo(CGSize.init(width: 33, height: 33))
        }
        label.snp.makeConstraints { (make) in
            make.left.equalTo(imageView.snp.right).offset(8)
            make.centerY.equalTo(control)
        }
        arrowImageView.snp.makeConstraints { (make) in
            make.right.equalTo(-13)
            make.centerY.equalTo(control)
            make.size.equalTo(CGSize.init(width: 15, height: 15))
        }
        
        if let detail = item.detail {
            let detailLabel = UILabel()
            detailLabel.text = detail
            detailLabel.textColor = AppTheme.manager.deepSkinBlackColor
            detailLabel.font = UIFont.systemFont(ofSize: 14)
            detailLabel.adjustsFontSizeToFitWidth = true
            detailLabel.minimumScaleFactor = 0.6
            control.addSubview(detailLabel)
            detailLabel.snp.makeConstraints { (make) in
                make.left.equalTo(label.snp.right).offset(5)
                make.right.equalTo(arrowImageView.snp.left).offset(-5)
                make.centerY.equalTo(control)
            }
        }
        
        return control
    }
}

