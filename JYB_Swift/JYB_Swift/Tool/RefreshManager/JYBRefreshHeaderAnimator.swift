//
//  JYBRefreshHeaderAnimator.swift
//  JYB_Swift
//
//  Created by kim on 2021/1/29.
//

import UIKit

class JYBRefreshHeaderAnimator: UIView, ESRefreshProtocol, ESRefreshAnimatorProtocol, ESRefreshImpactProtocol {
    open var pullToRefreshDescription = "下拉刷新"
    open var releaseToRefreshDescription = "释放刷新"
    open var loadingDescription = "更新中..."
    
    
    var view: UIView { return self }
    var insets: UIEdgeInsets = .zero
    var trigger: CGFloat = 60.0 // 要执行刷新的临界点
    var executeIncremental: CGFloat = 60.0
    var state: ESRefreshViewState = .pullToRefresh
        
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage.init(named: "pullRefresh_normal1")
        return imageView
    }()
    private let stateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = JYBColor_Gray
        label.font = UIFont.systemFont(ofSize: 11)
        return label
    }()
    private let lastUpdatedTimeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = JYBColor_Gray
        label.font = UIFont.systemFont(ofSize: 11)
        let formatter = DateFormatter()
        formatter.dateFormat = "MM月dd日 HH:mm"
        label.text = formatter.string(from: Date())
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        stateLabel.text = pullToRefreshDescription
        addSubview(imageView)
        addSubview(stateLabel)
        addSubview(lastUpdatedTimeLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func refreshAnimationBegin(view: ESRefreshComponent) {
        stateLabel.text = loadingDescription
        var images = [UIImage]()
        for idx in 1...4 {
            if let image = UIImage.init(named: "pullDownLoad0\(idx)") {
                images.append(image)
            }
        }
        imageView.animationImages = images
        imageView.animationDuration = 0.5
        imageView.animationRepeatCount = 0
        imageView.startAnimating()
    }
    
    func refreshAnimationEnd(view: ESRefreshComponent) {
        stateLabel.text = pullToRefreshDescription
        imageView.stopAnimating()
        imageView.image = UIImage.init(named: "pullRefresh_normal1")
    }
    
    func refresh(view: ESRefreshComponent, progressDidChange progress: CGFloat) {
//        imageView.transform = CGAffineTransform.identity
        imageView.transform = CGAffineTransform.init(rotationAngle: CGFloat.pi)
    }
    
    func refresh(view: ESRefreshComponent, stateDidChange state: ESRefreshViewState) {
        guard self.state != state else {
            return
        }
        self.state = state
        
        switch state {
        case .refreshing, .autoRefreshing:
            stateLabel.text = loadingDescription
            setNeedsLayout()
        case .releaseToRefresh:
            stateLabel.text = releaseToRefreshDescription
            setNeedsLayout()
            impact()
        case .pullToRefresh:
            stateLabel.text = pullToRefreshDescription
            setNeedsLayout()
            imageView.stopAnimating()
            imageView.image = UIImage.init(named: "pullRefresh_normal1")
        default: break
        }
    }
    
    override func layoutSubviews() {
        superview?.layoutSubviews()
        let s = bounds.size
        let w = s.width
        let h = s.height
        let imageSize = imageView.image?.size ?? CGSize.zero
        
        UIView.performWithoutAnimation {
            stateLabel.sizeToFit()
            lastUpdatedTimeLabel.sizeToFit()
            stateLabel.center = CGPoint.init(x: w / 2.0 - 15, y: h / 2.0)
            imageView.frame = CGRect.init(x: stateLabel.frame.minX - imageSize.width - 5, y: (h - imageSize.height) / 2, width: imageSize.width, height: imageSize.height)
            lastUpdatedTimeLabel.center = CGPoint.init(x: stateLabel.frame.maxX + lastUpdatedTimeLabel.frame.width/2 + 5, y: stateLabel.center.y)
        }
    }

}
