//
//  HomeAppsTopView.swift
//  JYB_Swift
//
//  Created by kim on 2021/3/25.
//

import UIKit

class HomeAppsTopView: UIView {
    // MARK: Properties
    lazy var topBgIV: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        return stackView
    }()
    

    // MARK: init
    required init() {
        super.init(frame: .zero)
        addSubview(topBgIV)
        addSubview(stackView)
        topBgIV.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
        stackView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Public
    func refresh(with models: [HomeAppModel]) {
        for subview in stackView.arrangedSubviews {
            subview.removeFromSuperview()
        }
        for obj in models {
            let control = HomeAppCell.init(with: .top)
            self.snp.makeConstraints { (make) in
                make.width.equalTo(kScreenWidth/5)
            }
            control.bgBtn.addTarget(self, action: #selector(tapCell(_ :)), for: .touchUpInside)
            control.model = obj
            if models.count < 5 {
                control.label.font = UIFont.systemFont(ofSize: 13)
            }
            stackView.addArrangedSubview(control)
        }
    }
    
    // MARK: Action
    @objc private func tapCell(_ sender: UIButton) {
        guard let cell = sender.superview as? HomeAppCell else {
            return
        }
        HomeAppsVC.goto(with: cell.model)
    }
}
