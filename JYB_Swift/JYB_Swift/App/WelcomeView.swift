//
//  WelcomeView.swift
//  JYB_Swift
//
//  Created by kim on 2022/2/25.
//

import UIKit

class WelcomeView: UIView {
    static let kWelcomeString = "kWelcomeString"
    
    
    private lazy var doneButton: UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.backgroundColor = UIColor.init(hex: 0xd9b470)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        btn.layer.cornerRadius = 19.0
        btn.layer.masksToBounds = true
        btn.setTitle("立即开启", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.addTarget(self, action: #selector(doneAction), for: .touchUpOutside)
        return btn
    }()
    
    private var lottieViewArray = [UIView]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupContentView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 设置子视图
    private func setupContentView() {
        let lottieImageNameArr = ["launch_guide_1", "launch_guide_2", "launch_guide_3", "launch_guide_4"]
        
        let scrollView = UIScrollView.init(frame: frame)
        scrollView.delegate = self
        scrollView.backgroundColor = .clear
        scrollView.isPagingEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(0)
        }
        
        let scrollContentView = UIView()
        scrollView.addSubview(scrollContentView)
        scrollContentView.snp.makeConstraints { make in
            make.edges.equalTo(0)
            make.centerY.equalTo(scrollView)
        }
        
        for (index, imageName) in lottieImageNameArr.enumerated() {
            let image = UIImage.init(named: imageName)
            let imageView = UIImageView.init(image: image)
            imageView.contentMode = .scaleAspectFit
            imageView.clipsToBounds = true
//            var ratio: CGFloat = 1.0
//            if let imageWidth = image?.size.width {
//                ratio = imageWidth / kScreenWidth
//            }
            lottieViewArray.append(imageView)
            scrollContentView.addSubview(imageView)
            imageView.snp.makeConstraints { make in
                make.left.equalTo(CGFloat(index) * kScreenWidth)
                make.top.bottom.equalTo(0)
                make.width.equalTo(kScreenWidth)
                if index == lottieImageNameArr.count - 1 { // 最后一个
                    make.right.equalTo(0)
                }
            }
        }
        
        scrollContentView.addSubview(doneButton)
        let btnLeft = CGFloat(lottieImageNameArr.count - 1) * kScreenWidth + (kScreenWidth - 250) / 2.0
        doneButton.snp.makeConstraints { make in
            make.bottom.equalTo(-60)
            make.size.equalTo(CGSize.init(width: 250, height: 38))
            make.left.equalTo(btnLeft)
        }
    }
    
    static func showView(_ window: UIWindow) {
        let v = WelcomeView.init(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight))
        if (v.superview != nil) {
            return
        }
        window.addSubview(v)
    }
    
    @objc private func doneAction() {
        UIView.animate(withDuration: 1.0, delay: 0, options: .curveEaseInOut) {
            self.alpha = 0.0
            self.transform = CGAffineTransform.init(scaleX: 1.5, y: 1.5)
        } completion: { finished in
            self.removeFromSuperview()
            UserDefaults.standard.setValue(true, forKey: WelcomeView.kWelcomeString)
        }

    }
}

extension WelcomeView: UIScrollViewDelegate {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if scrollView.contentOffset.x + scrollView.frame.size.width > scrollView.contentSize.width {
            doneAction()
        } else {
            
        }
    }
}
