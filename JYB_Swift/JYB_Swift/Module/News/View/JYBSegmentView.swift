//
//  JYBSegmentView.swift
//  JYB_Swift
//
//  Created by kim on 2021/1/18.
//

import UIKit

protocol JYBSegmentViewDelegate {
    // tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    func segmentView(_ segmentView: JYBSegmentView, didSelectRowAt index: Int)
}

class JYBSegmentView: UIView {

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.delegate = self
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var moreButton: UIButton = {
        let button = UIButton.init(type: .custom)
        button.setImage(UIImage.init(named: "arrow_down"), for: .normal)
        button.addTarget(self, action: #selector(tapMoreButton), for: .touchUpInside)
        return button
    }()
    
    var delegate: JYBSegmentViewDelegate?
    
    private var _currentIndex: Int = 0
    var currentIndex: Int {
        get {
            return _currentIndex
        }
        set {
            if itemViews.count == 0 {
                return
            }
            if newValue < 0 || newValue > itemViews.count - 1 {
                return
            }
            if _currentIndex < itemViews.count {
                let button = itemViews[_currentIndex]
                button.isSelected = false
            }
            let button = itemViews[newValue]
            button.isSelected = true
            _currentIndex = newValue
            adjustScrollView()
        }
    }
    
    private let titles = ["最新", "推荐", "自选", "新股递表", "大V专栏", "中签分析", "AiPO数据网", "打新A站"]
    private var itemViews = [UIButton]()
    
    init() {
        super.init(frame: .zero)
        setupView()
        fillScrollView()
        setSelectItem(0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(scrollView)
        addSubview(moreButton)
        scrollView.addSubview(contentView)
        scrollView.snp.makeConstraints { (make) in
            make.left.equalTo(13)
            make.top.bottom.equalTo(0)
            make.right.equalTo(moreButton.snp.left)
        }
        moreButton.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(0)
            make.right.equalTo(0)
            make.width.equalTo(30)
        }
        contentView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets.zero)
            make.centerY.equalTo(scrollView)
        }
    }
    
    private func fillScrollView() {
        var lastView: UIView?
        for (index, title) in titles.enumerated() {
            let button = UIButton.init(type: .custom)
            button.tag = index
            button.setTitle(title, for: .normal)
            button.setTitleColor(.white, for: .normal)
            button.setTitleColor(.red, for: .selected)
            button.addTarget(self, action: #selector(tapItemButton(_ :)), for: .touchUpInside)
            contentView.addSubview(button)
            itemViews.append(button)
            let size = button.sizeThatFits(.zero)
            button.snp.makeConstraints { (make) in
                make.top.bottom.equalTo(contentView)
                make.width.equalTo(size.width + 10)
                if let lastView = lastView {
                    make.left.equalTo(lastView.snp.right)
                } else {
                    make.left.equalTo(0)
                }
            }
            lastView = button
        }
        lastView?.snp.makeConstraints({ (make) in
            make.right.equalTo(0)
        })
    }
    
    private func setSelectItem(_ index: NSInteger) {
        let itemView = itemViews[index]
        itemView.isSelected = true
        currentIndex = index
        adjustScrollView()
    }
    
    @objc private func tapItemButton(_ sender: UIButton) {
        let itemView = itemViews[currentIndex]
        itemView.setTitleColor(.white, for: .normal)
        setSelectItem(sender.tag)
        adjustScrollView()
        delegate?.segmentView(self, didSelectRowAt: sender.tag)
    }
    
    @objc private func tapMoreButton() {
        
    }
    
    private func adjustScrollView() {
        let currentDiffOffsetX = scrollView.contentSize.width - scrollView.frame.size.width
        let itemView = itemViews[currentIndex]
        let itemDiffX = itemView.center.x - scrollView.center.x
        if itemDiffX > 0 {
            scrollView.setContentOffset(CGPoint.init(x: min(itemDiffX, currentDiffOffsetX), y: 0), animated: true)
        } else {
            scrollView.setContentOffset(CGPoint.zero, animated: true)
        }
    }
}

extension JYBSegmentView: UIScrollViewDelegate {
    
}
