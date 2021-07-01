//
//  JYBUserNavigationBar.swift
//  JYB_Swift
//
//  Created by kim on 2021/2/2.
//

import UIKit

/// 带有用户标识的导航栏
class JYBUserNavigationBar: UIView {

    private lazy var leftStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    private lazy var rightStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(leftStackView)
        addSubview(rightStackView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
