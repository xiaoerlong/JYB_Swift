//
//  JYBSettingViewController.swift
//  JYB_Swift
//
//  Created by kim on 2021/1/13.
//

import UIKit

enum SettingItemEnum: Int {
    case display = 0 // 显示设置
    case language = 1 // 语言设置
    case style = 2 // 风格设置
    case clear = 3 // 清理缓存
    case authority = 4 // 权限管理
    case message = 5 // 消息通知
    case wechat = 6 // 微信通知
    case about = 7 // 关于捷利交易宝
    case server = 8 // 服务器设置
    case lighting = 9 // 屏幕常亮
}

struct SettingItem {
    var leftTitle: String
    var rightTitle: String?
    var type: SettingItemEnum
}

class JYBSettingViewController: UIViewController {

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.alignment = .center
        stackView.spacing = 1
        
        return stackView
    }()
    
    
    
    private var items = [
        SettingItem(leftTitle: "显示设置", rightTitle: "红涨绿跌", type: .display),
        SettingItem(leftTitle: "语言设置", rightTitle: "简体中文", type: .language),
        SettingItem(leftTitle: "风格设置", rightTitle: AppTheme.manager.currentTheme.rawValue, type: .style),
        SettingItem(leftTitle: "清理缓存", rightTitle: "1.7M", type: .clear),
        SettingItem(leftTitle: "权限管理", rightTitle: "已开启", type: .authority),
        SettingItem(leftTitle: "消息通知", rightTitle: nil, type: .message),
        SettingItem(leftTitle: "微信通知", rightTitle: nil, type: .wechat),
        SettingItem(leftTitle: "关于捷利交易宝", rightTitle: nil, type: .about),
        SettingItem(leftTitle: "服务器设置", rightTitle: nil, type: .server),
        SettingItem(leftTitle: "屏幕常亮", rightTitle: nil, type: .lighting)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        for var item in items {
            if item.type == .style {
                item.rightTitle = AppTheme.manager.currentTheme.rawValue
            }
        }
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "设置"
    }
    
    private func setupView() {
        self.themeChangedHandler = { [unowned self] in
            self.view.backgroundColor = AppTheme.manager.deepSkinBackgroundColor
            self.scrollView.backgroundColor = AppTheme.manager.deepSkinBackgroundColor
            self.stackView.backgroundColor = AppTheme.manager.deepSkinBackgroundColor
        }
        
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        scrollView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets.zero)
        }
        stackView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets.zero)
            make.centerX.equalTo(scrollView)
        }
        
        for item in items {
            let itemView = createItem(item)
            stackView.addArrangedSubview(itemView)
            itemView.snp.makeConstraints { (make) in
                make.height.equalTo(50)
                make.width.equalTo(stackView)
            }
        }
    }
    
    private func createItem(_ item: SettingItem) -> UIControl {
        let control = UIControl()
        control.tag = item.type.rawValue
        control.addTarget(self, action: #selector(tapControl(_ :)), for: .touchUpInside)
        
        let leftLabel = UILabel()
        leftLabel.text = item.leftTitle
        leftLabel.themeChangedHandler = {
            leftLabel.textColor = AppTheme.manager.deepSkinBlackColor
        }
        leftLabel.font = UIFont.systemFont(ofSize: 14)
        control.addSubview(leftLabel)
        
        let rightLabel = UILabel()
        rightLabel.text = item.rightTitle
        rightLabel.themeChangedHandler = {
            rightLabel.textColor = AppTheme.manager.deepSkinBlackColor
        }
        rightLabel.font = UIFont.systemFont(ofSize: 12)
        rightLabel.textAlignment = .right
        control.addSubview(rightLabel)
        
        let arrowImageView = UIImageView()
        arrowImageView.image = UIImage.init(named: AppTheme.manager.imageName("pc-arrow-right"))
        control.addSubview(arrowImageView)
        
        leftLabel.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(control)
            make.left.equalTo(13)
        }
        arrowImageView.snp.makeConstraints { (make) in
            make.right.equalTo(-13)
            make.centerY.equalTo(control)
            make.size.equalTo(CGSize.init(width: 14, height: 14))
        }
        rightLabel.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(control)
            make.right.equalTo(arrowImageView.snp.left).offset(-10)
        }
        
        return control
    }

    
    @objc private func tapControl(_ control: UIControl) {
        switch SettingItemEnum(rawValue: control.tag) {
        case .display:
            return
        case .language:
            return
        case .style:
            let vc = JYBThemeSettingViewController()
            navigationController?.pushViewController(vc, animated: true)
        case .clear:
            return
        case .authority:
            return
        case .message:
            return
        case .wechat:
            return
        case .about:
            return
        case .server:
            return
        case .lighting:
            return
            
        case .none:
            return
        }
        
    }
    
}
