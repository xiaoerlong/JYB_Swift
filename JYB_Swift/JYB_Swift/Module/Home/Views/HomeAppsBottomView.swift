//
//  HomeAppsBottomView.swift
//  JYB_Swift
//
//  Created by kim on 2021/3/25.
//

import UIKit

class HomeAppsBottomView: UIView {
    // MARK: Properties
    lazy var moreCell: HomeAppCell = {
        let cell = HomeAppCell.init(with: .bottom)
        cell.iconIV.image = UIImage.init(named: "hp-app-more")
        cell.label.text = "更多"
        cell.snp.makeConstraints { (make) in
            make.width.equalTo(kScreenWidth/5)
        }
        cell.layoutIfNeeded()
        // 更新版本或者新装，添加小红点
        if AppManager.manager.isNewVersion() {
            cell.iconIV.showBadge()
        }
        return cell
    }()
    
    private lazy var stackView2: UIStackView = {
        let stackView = UIStackView()
        return stackView
    }()
    
    private lazy var stackView1: UIStackView = {
        let stackView = UIStackView()
        return stackView
    }()
    
    // MARK: Init
    init() {
        super.init(frame: .zero)
        addSubview(stackView2)
        stackView2.snp.makeConstraints { (make) in
            make.left.bottom.equalTo(self)
            make.height.equalTo(70)
            make.right.lessThanOrEqualTo(self)
        }
        addSubview(stackView1)
        stackView1.snp.makeConstraints { (make) in
            make.left.top.equalTo(self)
            make.height.equalTo(70)
            make.right.lessThanOrEqualTo(self)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Public
    func refresh(with models: [HomeAppModel]) {
        for subview in stackView1.arrangedSubviews {
            subview.removeFromSuperview()
        }
        for subview in stackView2.arrangedSubviews {
            subview.removeFromSuperview()
        }
        // 首页最多显示9个图标
        for (index, model) in models.enumerated() {
            let control = HomeAppCell.init(with: .bottom)
            control.snp.makeConstraints { (make) in
                make.width.equalTo(kScreenWidth/5)
            }
            control.bgBtn.addTarget(self, action: #selector(tapCell(_ :)), for: .touchUpInside)
            if index < 5 {
                stackView1.addArrangedSubview(control)
                control.model = model
            } else if index < 9 {
                stackView2.addArrangedSubview(control)
                control.model = model
            } else {
                break
            }
        }
        if models.count < 5 {
            stackView1.addArrangedSubview(moreCell)
        } else {
            stackView2.addArrangedSubview(moreCell)
        }
        self.snp.updateConstraints { (make) in
            var height: CGFloat = 70
            if stackView2.arrangedSubviews.count > 0 {
                height = 70.0 * 2.0
            }
            make.height.equalTo(height)
        }
    }
    
    // MARK: Action
    @objc private func tapCell(_ sender: UIButton) {
        let cell = sender.superview as! HomeAppCell
        HomeAppsVC.goto(with: cell.model)
    }
}
