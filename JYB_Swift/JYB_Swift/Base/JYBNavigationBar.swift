//
//  JYBNavigationBar.swift
//  JYB_Swift
//
//  Created by kim on 2022/2/28.
//

import UIKit

class JYBNavigationBar: UIView {
    
    private var leftStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = 20
        return stackView
    }()

    private var rightStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = 20
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = AppTheme.manager.deepSkinBackgroundColor
        addSubview(leftStackView)
        addSubview(rightStackView)
        leftStackView.snp.makeConstraints { make in
            make.bottom.equalTo(0)
            make.left.equalTo(15)
            make.top.equalTo(kStatusHeight)
        }
        rightStackView.snp.makeConstraints { make in
            make.bottom.equalTo(0)
            make.right.equalTo(-15)
            make.left.equalTo(leftStackView.snp.right).offset(10)
            make.top.equalTo(kStatusHeight)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension JYBNavigationBar {
    // 自定义样式1
    func style1() {
        // 自定义输入框样式
        let searchBar = createTextFieldButton()
        leftStackView.addArrangedSubview(searchBar)
        
        let btn1 = UIButton.init(type: .custom)
        btn1.setImage(UIImage.init(named: "hp-message_new"), for: .normal)
        rightStackView.addArrangedSubview(btn1)
        
        let btn2 = UIButton.init(type: .custom)
        btn2.setImage(UIImage.init(named: "common_nav_robot"), for: .normal)
        rightStackView.addArrangedSubview(btn2)
        
        let btn3 = UIButton.init(type: .custom)
        btn3.setImage(UIImage.init(named: "avatar-notlogin"), for: .normal)
        rightStackView.addArrangedSubview(btn3)
    }
    
    private func createTextFieldButton() -> UIControl {
        let control = UIControl()
//        control.backgroundColor = UIColor.init(white: 1, alpha: 0.2)
        control.snp.makeConstraints { make in
            make.height.equalTo(30)
        }
        control.backgroundColor = .red
        control.layer.cornerRadius = 15
        control.layer.masksToBounds = true
        control.addTarget(self, action: #selector(searchAction), for: .touchUpInside)
        
        let imgView = UIImageView.init(image: UIImage.init(named: "hp-search"))
        control.addSubview(imgView)
        imgView.snp.makeConstraints { make in
            make.centerY.equalTo(control)
            make.left.equalTo(10)
            make.size.equalTo(CGSize.init(width: 16, height: 16))
        }
        
        let label = UILabel.init()
        label.text = "股票/资讯"
        label.textColor = .white
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 12)
        control.addSubview(label)
        label.snp.makeConstraints { make in
            make.top.bottom.equalTo(control)
            make.left.equalTo(imgView.snp.right).offset(10)
            make.right.equalTo(0)
        }
        
        return control
    }
    
    @objc private func searchAction() {
        
    }
}
