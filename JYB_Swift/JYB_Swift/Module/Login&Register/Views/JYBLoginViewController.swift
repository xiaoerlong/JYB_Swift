//
//  JYBLoginViewController.swift
//  JYB_Swift
//
//  Created by kim on 2021/2/2.
//

import UIKit

/// 交易宝登录页面
class JYBLoginViewController: UIViewController {

    // MARK: Properties
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "密码登录"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        return label
    }()
    
    private lazy var codeView: UIView = {
        let view = UIView()
        let control = UIControl()
        view.addSubview(control)
        
        let label = UILabel()
        label.text = "+86"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 13)
        control.addSubview(label)
                
        let textField = UITextField.init()
        textField.borderStyle = .none
        textField.placeholder = "请输入手机号"
        view.addSubview(textField)
        
        label.snp.makeConstraints { (make) in
            make.centerY.equalTo(control)
            make.centerX.equalTo(control).offset(-10)
        }
        
        control.snp.makeConstraints { (make) in
            make.left.top.bottom.equalTo(0)
            make.width.equalTo(80)
        }
        textField.snp.makeConstraints { (make) in
            make.left.equalTo(control.snp.right)
            make.top.right.bottom.equalTo(0)
        }
        return view
    }()
    
    private lazy var phoneTextField: UITextField = {
        let textField = UITextField()
        textField.delegate = self
        textField.borderStyle = .none
        textField.clearButtonMode = .whileEditing
        textField.clipsToBounds = true
        textField.layer.cornerRadius = 4
        textField.leftViewMode = .always
        textField.leftView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 15, height: 0))
        var attributes = [NSAttributedString.Key.foregroundColor: UIColor.init(hex: 0xcccccc), NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15)]
        textField.attributedPlaceholder = NSAttributedString.init(string: "请输入用户名或手机号码登录", attributes: attributes)
        textField.defaultTextAttributes = attributes
        textField.addTarget(self, action: #selector(textFieldDidChanged(_ :)), for: .editingChanged)
        return textField
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.delegate = self
        textField.borderStyle = .none
        textField.clearButtonMode = .whileEditing
        textField.clipsToBounds = true
        textField.layer.cornerRadius = 4
        textField.leftViewMode = .always
        textField.leftView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 15, height: 0))
        var attributes = [NSAttributedString.Key.foregroundColor: UIColor.init(hex: 0xcccccc), NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15)]
        textField.attributedPlaceholder = NSAttributedString.init(string: "请输入密码", attributes: attributes)
        textField.defaultTextAttributes = attributes
        textField.isSecureTextEntry = true
        textField.addTarget(self, action: #selector(textFieldDidChanged(_ :)), for: .editingChanged)
        if #available(iOS 11.0, *) {
            textField.textContentType = .password
        }
        return textField
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton.init(type: .custom)
        button.setTitle("忘记密码?", for: .normal)
        button.backgroundColor = UIColor.init(hex: 0x2d2f3d)
        button.clipsToBounds = true
        button.layer.cornerRadius = 4
        button.setTitleColor(UIColor.init(hex: 0xCCCCCC), for: .normal)
        button.addTarget(self, action: #selector(forgetBtnClicked), for: .touchUpInside)
        return button
    }()
    
    private lazy var protocolLabel: UILabel = {
        let label = UILabel()
        label.text = "点击表示已同意用户使用协议和隐私政策"
        let str0 = "点击即表示您已同意"
        let str1 = "用户使用协议"
        let str2 = "隐私政策"
        let str = str0 + str1 + "和" + str2
        let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12),
                          NSAttributedString.Key.foregroundColor: UIColor.init(hex: 0xcccccc)]
        let maStr = NSMutableAttributedString.init(string: str, attributes: attributes)
        label.attributedText = maStr
        return label
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton.init(type: .custom)
        button.setTitle("登录", for: .normal)
        button.backgroundColor = UIColor.init(hex: 0x308FFF)
        button.layer.cornerRadius = 4
        button.clipsToBounds = false
        button.isEnabled = false
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(UIColor.init(hex: 0xeeeeee), for: .disabled)
        button.setBackgroundColor(color: UIColor.init(hex: 0x308fff), for: .normal)
        button.setBackgroundColor(color: UIColor.init(hex: 0x234e89), for: .disabled)
        button.addTarget(self, action: #selector(tapLoginAction), for: .touchUpInside)
        return button
    }()
    
    private var viewModel = JYBLoginViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        
        
    }
    
    private func setupView() {
        view.backgroundColor = AppTheme.manager.deepSkinBackgroundColor
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "popback"), style: .plain, target: self, action: #selector(tapBack))
        view.addSubview(titleLabel)
        view.addSubview(phoneTextField)
        view.addSubview(passwordTextField)
        view.addSubview(button)
        view.addSubview(protocolLabel)
        view.addSubview(loginButton)
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(loginButton)
            make.top.equalTo(26)
        }
        phoneTextField.snp.makeConstraints { (make) in
            make.left.right.equalTo(loginButton)
            make.top.equalTo(titleLabel.snp.bottom).offset(20).priority(.medium)
            make.height.equalTo(45)
        }
        passwordTextField.snp.makeConstraints { (make) in
            make.left.equalTo(loginButton)
            make.top.equalTo(phoneTextField.snp.bottom).offset(15)
            make.height.equalTo(phoneTextField)
            make.right.equalTo(button.snp.left).offset(-10)
        }
        button.snp.makeConstraints { (make) in
            make.right.equalTo(loginButton)
            make.height.equalTo(passwordTextField)
            make.width.equalTo(85)
            make.centerY.equalTo(passwordTextField)
        }
        protocolLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(loginButton)
            make.top.equalTo(passwordTextField.snp.bottom).offset(20)
        }
        loginButton.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.top.equalTo(protocolLabel.snp.bottom).offset(20)
            make.height.equalTo(50)
        }
    }
    
    private func bindViewModel() {
        
    }
    
    // MARK: Action
    @objc private func tapBack() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func tapLoginAction() {
        view.endEditing(true)
        
        guard let account = phoneTextField.text else {
            return
        }
        guard let password = passwordTextField.text else {
            return
        }
        print("Start Loading...")
        JYBNetworkClient.login(username: account, password: password) { (response, errMsg) in
            print("Stop Loading...")
            if let errMsg = errMsg {
                print(errMsg)
                return
            }
            if let _ = response as? JYBUserModel {
                NotificationCenter.default.post(name: UserLoginSuccess, object: nil)
                JYBUserModel.default.account = account
                JYBUserModel.default.password = password
                // 保存历史登录账号
                UserDefaults.standard.setValue(account, forKey: "historyUserAccount")
                self.refreshAfterLoginSuccess()
                self.loginSuccessCallback()
                
                if let delegate = UIApplication.shared.delegate as? AppDelegate {
                    delegate.window?.rootViewController = JYBTabBarViewController()
                }
            }
        }
    }

    @objc private func forgetBtnClicked() {
        
    }
    
    // 登录成功后的操作
    private func refreshAfterLoginSuccess() {
        NotificationCenter.default.post(name: UserLoginSuccess, object: nil)
    }
    
    private func loginSuccessCallback() {
        self.dismiss(animated: true) {
            print("登录成功")
        }
    }
    
}

extension JYBLoginViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == phoneTextField {
            // 有非手机字符
            do {
                let regular = try NSRegularExpression.init(pattern: "[^0-9]", options: .allowCommentsAndWhitespace)
                let hasOtherCharater = regular.matches(in: string, options: .anchored, range: NSMakeRange(0, string.count)).count
                if hasOtherCharater > 0 {
                    return false
                }
                // 超过手机位数
                let text = textField.text
                let rag = text?.toRange(range)
                let str = text?.replacingCharacters(in: rag!, with: string)
                if let count = str?.count, count > 11 {
                    return false
                }
            } catch {
                return false
            }
        }
        return true
    }
    
    @objc private func textFieldDidChanged(_ textField: UITextField) {
        validateLoginBtn()
    }
}

extension JYBLoginViewController {
    private func validateLoginBtn() {
        if let phoneCount = phoneTextField.text?.count, let pwdCount = passwordTextField.text?.count, phoneCount > 0 && pwdCount > 0 {
            loginButton.isEnabled = true
        } else {
            loginButton.isEnabled = false
        }
        
    }
}
