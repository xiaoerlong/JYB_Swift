//
//  JYBTradeLoginViewController.swift
//  JYB_Swift
//
//  Created by kim on 2020/12/30.
//

import UIKit
import RxSwift
import SwiftEntryKit

class JYBTradeLoginViewController: UIViewController {
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage.init(named: "GYG_LOGO")
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "辉立证券"
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    private lazy var textAreaView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: 0xf2f6f7)
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 0.5
        view.layer.borderColor = UIColor(hex: 0x308fff).cgColor
        
        let accountTextField = UITextField()
        accountTextField.borderStyle = .none
        accountTextField.placeholder = "交易账号"
        accountTextField.tag = 100
        accountTextField.text = "222225"
        view.addSubview(accountTextField)
        
        let passwordTextField = UITextField()
        passwordTextField.borderStyle = .none
        passwordTextField.isSecureTextEntry = true
        passwordTextField.placeholder = "交易密码"
        passwordTextField.text = "ts1456"
        passwordTextField.tag = 200
        view.addSubview(passwordTextField)
        
        let spaceLine = UIView()
        spaceLine.backgroundColor = UIColor(hex: 0xd9d9d9)
        view.addSubview(spaceLine)
        
        accountTextField.snp.makeConstraints { (make) in
            make.left.equalTo(5)
            make.top.equalTo(0)
            make.right.equalTo(-5)
        }
        passwordTextField.snp.makeConstraints { (make) in
            make.left.right.equalTo(accountTextField)
            make.top.equalTo(spaceLine.snp.bottom)
            make.bottom.equalTo(0)
            make.height.equalTo(accountTextField)
        }
        spaceLine.snp.makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.height.equalTo(1)
            make.top.equalTo(accountTextField.snp.bottom)
        }
        
        return view
    }()
    
    private lazy var forgetButton: UIButton = {
        let button = UIButton.init(type: .custom)
        button.setTitle("忘记密码", for: .normal)
        button.setTitleColor(UIColor(hex: 0x308fff), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button.addTarget(self, action: #selector(forgetPassword), for: .touchUpInside)
        return button
    }()
    
    private lazy var savePasswordButton: JYBLayoutButton = {
        let button = JYBLayoutButton.init(10, at: .left)
        button.setTitle("下单时记住密码", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button.setImage(UIImage.init(named: "tradeLoginUnSelPwd"), for: .normal)
        button.setImage(UIImage.init(named: "tradeLoginSelPwd"), for: .selected)
        button.addTarget(self, action: #selector(savePassword(_ :)), for: .touchUpInside)
        return button
    }()
    
    private lazy var serverChooseButton: JYBLayoutButton = {
        let button = JYBLayoutButton.init(10, at: .right)
        button.setTitle("辉立UAT测试服务器", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button.setImage(UIImage.init(named: "zhishu-xiangxia"), for: .normal)
        button.addTarget(self, action: #selector(chooseServer), for: .touchUpInside)
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(hex: 0x308fff).cgColor
        return button
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton.init(type: .custom)
        button.setTitle("确认", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        button.setBackgroundImage(UIImage.init(named: "pubulishbutton"), for: .normal)
        button.addTarget(self, action: #selector(login), for: .touchUpInside)
        button.layer.cornerRadius = 5
        return button
    }()
    
    private lazy var declareLabel: UILabel = {
        let label = UILabel()
        let str = "点击\"确认\"按钮,即表示您同意《辉立证券免责声明》"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 10)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.7
        label.textAlignment = .center
        var attrStr = NSMutableAttributedString.init(string: str)
        if let range = str.getNSRange(from: "《辉立证券免责声明》") {
            attrStr.setAttributes([NSAttributedString.Key.foregroundColor: UIColor(hex: 0x308fff)], range: NSMakeRange(range.location, str.count - range.location))
        }
        label.attributedText = attrStr
        
        let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(pushToDeclareVC))
        tapGesture.cancelsTouchesInView = false
        label.addGestureRecognizer(tapGesture)
        label.isUserInteractionEnabled = true
        return label
    }()
    
    private lazy var contactButton: UIButton = {
        let button = UIButton.init(type: .custom)
        button.setTitle("联系券商", for: .normal)
        button.setTitleColor(UIColor(hex: 0x308fff), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.addTarget(self, action: #selector(contactBroker), for: .touchUpInside)
        return button
    }()
    
    private lazy var openAccountButton: UIButton = {
        let button = UIButton.init(type: .custom)
        button.setTitle("3分钟极速开户", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.addTarget(self, action: #selector(openAccount), for: .touchUpInside)
        button.setBackgroundImage(UIImage.init(named: "openAccount_rightNow"), for: .normal)
        button.layer.cornerRadius = 5
        return button
    }()
    
    private lazy var explainLabel: UILabel = {
        let label = UILabel()
        label.text = "捷利交易宝作为服务提供商，仅为您提供相关券商的开户通道及交易平台，交易宝本身并不直接从事证券开户业务及证券交易业务。"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 12)
        label.numberOfLines = 0
        return label
    }()
    
    private let viewModel = JYBTradeLoginViewModel()
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        addConstraints()
    }
    
    private func setupView() {
        view.backgroundColor = UIColor.white
        
        bindingViewModel()
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(logoImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(textAreaView)
        contentView.addSubview(forgetButton)
        contentView.addSubview(savePasswordButton)
        contentView.addSubview(serverChooseButton)
        contentView.addSubview(loginButton)
        contentView.addSubview(declareLabel)
        contentView.addSubview(contactButton)
        contentView.addSubview(openAccountButton)
        contentView.addSubview(explainLabel)
    }
    
    private func addConstraints() {
        scrollView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets.zero)
        }
        contentView.snp.makeConstraints { (make) in
            make.top.left.bottom.right.equalTo(0)
            make.centerX.equalTo(scrollView)
        }
        logoImageView.snp.makeConstraints { (make) in
            make.centerX.equalTo(contentView)
            make.top.equalTo(30)
            make.size.equalTo(CGSize.init(width: 65, height: 65))
        }
        nameLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.top.equalTo(logoImageView.snp.bottom).offset(10)
            make.height.equalTo(18)
        }
        textAreaView.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.top.equalTo(nameLabel.snp.bottom).offset(27)
            make.height.equalTo(90)
        }
        forgetButton.snp.makeConstraints { (make) in
            make.left.equalTo(textAreaView)
            make.top.equalTo(textAreaView.snp.bottom).offset(5)
            make.size.equalTo(CGSize.init(width: 70, height: 20))
        }
        savePasswordButton.snp.makeConstraints { (make) in
            make.left.equalTo(textAreaView)
            make.top.equalTo(forgetButton.snp.bottom).offset(5)
            make.size.equalTo(CGSize.init(width: 133, height: 33))
        }
        serverChooseButton.snp.makeConstraints { (make) in
            make.right.equalTo(textAreaView)
            make.centerY.equalTo(savePasswordButton)
            make.size.equalTo(CGSize.init(width: 150, height: 33))
        }
        loginButton.snp.makeConstraints { (make) in
            make.left.right.equalTo(textAreaView)
            make.top.equalTo(serverChooseButton.snp.bottom).offset(15)
            make.height.equalTo(45)
        }
        declareLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(textAreaView)
            make.centerX.equalTo(contentView)
            make.top.equalTo(loginButton.snp.bottom).offset(10)
            make.height.equalTo(20)
        }
        contactButton.snp.makeConstraints { (make) in
            make.top.equalTo(declareLabel.snp.bottom).offset(5)
            make.centerX.equalTo(contentView)
            make.size.equalTo(CGSize.init(width: 100, height: 30))
        }
        openAccountButton.snp.makeConstraints { (make) in
            make.left.right.equalTo(textAreaView)
            make.top.equalTo(contactButton.snp.bottom).offset(15)
            make.height.equalTo(45)
        }
        explainLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(textAreaView)
            make.top.equalTo(openAccountButton.snp.bottom).offset(15)
            make.bottom.equalTo(-20)
        }
    }
    
    // MARK: Binding Model
    private func bindingViewModel() {
        viewModel.statusRelay.observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] status in
                switch status {
                case .normal:
                    print("登录成功")
                    break
                case .psg_2fa:
                    self?.presentPSGView()
                }
            })
            .disposed(by: disposeBag)
    }
    
    // 弹出 PSG 二重验证码
    private func presentPSGView() {
        
        // Create a basic toast that appears at the top
        var attributes = EKAttributes.centerFloat

        // Set its background to white
        attributes.entryBackground = .color(color: .white)
        // display time
        attributes.displayDuration = .infinity
        attributes.positionConstraints.verticalOffset = 0 // 将垂直偏移设置为0以使弹框从中间弹出
        
        attributes.entranceAnimation = .init(
            translate: .init(duration: 0.7, anchorPosition: .automatic, spring: .init(damping: 1, initialVelocity: 0)),
                         scale: .init(from: 0.6, to: 1, duration: 0.7),
                         fade: .init(from: 0.8, to: 1, duration: 0.3))

        // Colored entry background and dimmed screen background
        attributes.entryBackground = .color(color: .standardContent)
        attributes.screenBackground = .color(color: EKColor(UIColor(white: 0.5, alpha: 0.5)))
        
        // 交互方式
        attributes.entryInteraction = .absorbTouches
        
        attributes.positionConstraints.size = EKAttributes.PositionConstraints.Size(
            width: EKAttributes.PositionConstraints.Edge.ratio(value: 0.9),
            height: EKAttributes.PositionConstraints.Edge.intrinsic
        )
        
        let customView = Bundle.main.loadNibNamed("JYBPSG2FAView", owner: nil)?.first as! JYBPSG2FAView
        customView.cancelBlock = {
            SwiftEntryKit.dismiss()
        }
        customView.confirmBlock = { text in
            self.viewModel.secondLogin(opt_code: text)
            SwiftEntryKit.dismiss()
        }

        // Display the view with the configuration
        SwiftEntryKit.display(entry: customView, using: attributes)
    }
    
    // MARK: Action
    @objc private func forgetPassword() {
        
    }
    
    @objc private func savePassword(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    
    @objc private func chooseServer() {
        
    }
    
    @objc private func login() {
        guard let accountTextField = textAreaView.viewWithTag(100) as? UITextField, let account = accountTextField.text else {
            return
        }
        guard let passwordTextField = textAreaView.viewWithTag(200) as? UITextField, let password = passwordTextField.text else {
            return
        }
        viewModel.login(account: account, password: password)
    }
    
    @objc private func contactBroker() {
        
    }
    
    @objc private func openAccount() {
        self.presentPSGView()
    }
    
    @objc private func pushToDeclareVC() {
        print("免责声明")
    }
}
