//
//  JYBSettingItemControl.swift
//  JYB_Swift
//
//  Created by kim on 2021/1/15.
//

import UIKit

class JYBSettingItemControl: UIControl {

    private lazy var leftStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.alignment = .center
        return stackView
    }()
    
    private lazy var rightStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.alignment = .center
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(leftStackView)
        addSubview(rightStackView)
        
        leftStackView.snp.makeConstraints { (make) in
            make.left.equalTo(13)
            make.centerY.height.equalTo(self)
        }
        rightStackView.snp.makeConstraints { (make) in
            make.right.equalTo(-13)
            make.centerY.height.equalTo(self)
        }
    }
    
    func leftStackViewAddSub(_ block: () -> UIView) {
        let view = block()
        leftStackView.addArrangedSubview(view)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
