//
//  HomeAppCell.swift
//  JYB_Swift
//
//  Created by kim on 2021/3/25.
//

import UIKit

class HomeAppCell: UIView {

    enum HomeAppType {
        case top
        case bottom
    }
    
    // MARK: Properties
    lazy var bgBtn: UIButton = {
        let btn = UIButton.init(type: .custom)
        return btn
    }()
    
    lazy var iconIV: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    private lazy var badgeIV: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private var type: HomeAppType?

    // MARK: Init
    init(with type: HomeAppType) {
        super.init(frame: .zero)
        self.type = type
        initSubViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Private
    private func initSubViews() {
        addSubview(bgBtn)
        bgBtn.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
        addSubview(iconIV)
        iconIV.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.height.equalTo(28)
            let width = self.type == HomeAppType.bottom ? 28 : 43
            make.width.equalTo(width)
            make.top.equalTo(11)
        }
        addSubview(label)
        label.snp.makeConstraints { (make) in
            make.left.right.equalTo(self)
            make.top.equalTo(iconIV.snp.bottom).offset(4)
        }
        addSubview(badgeIV)
        badgeIV.snp.makeConstraints { (make) in
            make.centerX.equalTo(iconIV.snp.right)
            make.centerY.equalTo(iconIV.snp.top)
            make.width.equalTo(26)
            make.height.equalTo(12)
        }
    }
    
    // MARK: Setter
    private var _model = HomeAppModel()
    var model: HomeAppModel {
        set {
            _model = newValue
            let iconUrl = URL.init(string: newValue.menuIconNew!)
            iconIV.kf.setImage(with: iconUrl)
            label.text = newValue.chsName
            let dotUrl = newValue.recommendIcon!
            if dotUrl.hasSuffix("gif") {
                badgeIV.snp.updateConstraints { (make) in
                    make.width.equalTo(30)
                    make.height.equalTo(25)
                }
            } else {
                badgeIV.snp.updateConstraints { (make) in
                    make.width.equalTo(26)
                    make.height.equalTo(12)
                }
            }
            badgeIV.kf.setImage(with: URL.init(string: dotUrl))
        }
        get {
            return _model
        }
    }
}
