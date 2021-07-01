//
//  JYBLoginOptionViewController.swift
//  JYB_Swift
//
//  Created by kim on 2021/1/12.
//

import UIKit

class JYBLoginOptionViewController: UIViewController {

    private var titleLabel: UILabel! = {
        let label = UILabel()
        label.text = "登录交易宝 体验更多服务"
        label.font = UIFont.systemFont(ofSize: 19)
        label.textAlignment = .center
        return label
    }()
    
    private var stackView: UIStackView! = {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        return stackView
    }()
    
    private var lineView: UIView! = {
        let view = UIView()
        return view
    }()
    
    private var stackView2: UIStackView! = {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        addConstraint()
        self.themeChangedHandler = { [unowned self] in
            self.lineView.backgroundColor = AppTheme.manager.deep_262c3e_f9f9f9
            self.titleLabel.textColor = AppTheme.manager.deep_c2c2c2_333333
            self.view.backgroundColor = AppTheme.manager.itemBackgroundColor
        }
    }
    
    private func addNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(userLoginSuccess), name: UserLoginSuccess, object: nil)
    }
    
    @objc private func userLoginSuccess() {
        print("登录成功")
    }
    
    private func setupView() {
        view.layer.cornerRadius = 5
        
        view.addSubview(titleLabel)
        view.addSubview(stackView)
        view.addSubview(lineView)
        view.addSubview(stackView2)
        
        let phoneView = createButton("pc-login_phone")
        stackView.addArrangedSubview(phoneView)
        phoneView.snp.makeConstraints { (make) in
            make.height.equalTo(80)
        }
        stackView.addArrangedSubview(createButton("thirdLogin_weixin"))
        stackView.addArrangedSubview(createButton("thirdLogin_weibo"))
        stackView.addArrangedSubview(createButton("pc-login_more"))
        
        stackView2.addArrangedSubview(createOtherButton("会员中心", "pc-vip-a"))
        stackView2.addArrangedSubview(createOtherButton("行情服务", "pc-market-service"))
        stackView2.addArrangedSubview(createOtherButton("我的订阅", "pc-subscribe"))
    }
    
    private func addConstraint() {
        titleLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(view)
            make.top.equalTo(15)
            make.height.equalTo(20)
        }
        stackView.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.height.equalTo(80)
        }
        lineView.snp.makeConstraints { (make) in
            make.left.right.equalTo(stackView)
            make.top.equalTo(stackView.snp.bottom)
            make.height.equalTo(0.5)
        }
        stackView2.snp.makeConstraints { (make) in
            make.left.right.equalTo(stackView)
            make.top.equalTo(lineView.snp.bottom).offset(10)
            make.height.equalTo(72)
        }
    }
    
    private func createButton(_ imageName: String) -> UIView {
        let view = UIView()
        let button = UIButton.init(type: .custom)
        button.setImage(UIImage.init(named: imageName), for: .normal)
        button.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
        view.addSubview(button)
        button.snp.makeConstraints { (make) in
            make.center.equalTo(view)
        }
        
        if imageName != "pc-login_phone" {
            return view
        }
        let label = JYBInsetLabel()
        label.text = "推荐使用"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = .white
        label.backgroundColor = UIColor(hex: 0xea6a2c)
        label.contentInset = UIEdgeInsets.init(top: 0, left: 5, bottom: 0, right: 5)
        label.addRounded(with: [.topLeft, .topRight, .bottomRight], radii: CGSize.init(width: 9, height: 9), rect: CGRect.init(x: 0, y: 0, width: 50, height: 18))
        view.addSubview(label)
        
        label.snp.makeConstraints { (make) in
            make.top.equalTo(view).offset(10)
            make.left.equalTo(view.snp.centerX)
            make.size.equalTo(CGSize.init(width: 50, height: 18))
        }
        
        return view
    }
    
    private func createOtherButton(_ title: String, _ imageName: String) -> UIButton {
        let button = JYBLayoutButton.init(5, at: .top)
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        button.setTitleColor(AppTheme.manager.deepSkinGrayColor, for: .normal)
        button.setImage(UIImage.init(named: imageName), for: .normal)
        button.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
        return button
    }
    
    @objc private func tapButton() {
        let navi = JYBNavigationController.init(rootViewController: JYBLoginViewController())
        navi.modalPresentationStyle = .fullScreen
        present(navi, animated: true, completion: nil)
    }
}
