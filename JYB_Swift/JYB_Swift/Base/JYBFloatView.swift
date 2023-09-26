//
//  JYBFloatView.swift
//  JYB_Swift
//
//  Created by kim on 2022/3/1.
//

import UIKit

// 悬浮窗视图
class JYBFloatView: UIView {

    typealias Blocks = ((Int) -> Void)
    
    var clickBlocks: Blocks?
    private var frameWidth: CGFloat = 0
    private var isShowTab: Bool = false
    private var imagesAndTitle: [String: String]?
    private var bgColor: UIColor?
    private var circleShape: CAShapeLayer?
    private var animationColor: UIColor?
    
    private var animationGroup: CAAnimationGroup?
    private var pan: UIPanGestureRecognizer = UIPanGestureRecognizer()
    private var tap: UITapGestureRecognizer = UITapGestureRecognizer()
    private var mainImageButton: UIButton = UIButton()
    private var contentView: UIView = UIView()
    
    
    // 默认构造器
    init(_ frame: CGRect, imageName: String, imagesAndTitle: Dictionary<String, String>?, bgColor: UIColor?, animationColor: UIColor?) {
        self.frameWidth = frame.size.width
        self.imagesAndTitle = imagesAndTitle
        self.animationColor = animationColor
        self.bgColor = bgColor
        
        super.init(frame: frame)
        mainImageButton = UIButton.init(type: .custom)
        mainImageButton.frame = CGRect.init(x: 0, y: 0, width: frame.width, height: frame.height)
        mainImageButton.setImage(UIImage.init(named: imageName), for: .normal)
        mainImageButton.alpha = 0.3
        mainImageButton.addTarget(self, action: #selector(click), for: .touchUpInside)
        if animationColor != nil {
            mainImageButton.addTarget(self, action: #selector(mainBtnTouchDown), for: .touchDown)
        }
        addSubview(mainImageButton)
        
        pan = UIPanGestureRecognizer.init(target: self, action: #selector(locationChange))
        pan.delaysTouchesBegan = false
        addGestureRecognizer(pan)
        tap = UITapGestureRecognizer.init(target: self, action: #selector(click))
        addGestureRecognizer(tap)
        
        doBorder(width: 1.0, color: nil, radius: frameWidth / 2.0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func draw(_ rect: CGRect) {
        superview?.draw(rect)
        
        drawDash()
    }
    
    private func drawDash() {
        let ctx = UIGraphicsGetCurrentContext()
        ctx?.beginPath()
        ctx?.setLineWidth(0.1)
        ctx?.setStrokeColor(UIColor.white.cgColor)
        ctx?.setLineDash(phase: 0, lengths: [2, 1])
        if let imagesAndTitle = imagesAndTitle {
            for i in 0..<imagesAndTitle.count {
                ctx?.move(to: CGPoint.init(x: contentView.frame.origin.x + CGFloat(i) * frameWidth, y: 10.0))
                ctx?.addLine(to: CGPoint.init(x: contentView.frame.origin.x + CGFloat(i) * frameWidth, y: frameWidth - 10.0))
            }
        }
        ctx?.strokePath()
    }
    
    @objc private func click(p: UITapGestureRecognizer) {
        stopAnimation()
        
        mainImageButton.alpha = 0.8
        
        if let clickBlocks = clickBlocks {
            clickBlocks(0)
        }
        // 拉出悬浮窗
        if center.x == 0 {
            center = CGPoint.init(x: frame.width / 2.0, y: center.y)
        } else if center.x == kScreenWidth {
            center = CGPoint.init(x: kScreenWidth - frame.width / 2.0, y: center.y)
        } else if center.y == 0 {
            center = CGPoint.init(x: center.x, y: frame.height / 2.0)
        } else if center.y == kScreenHeight {
            center = CGPoint.init(x: center.x, y: kScreenHeight - frame.height / 2.0)
        }
        // 展示按钮列表
        isShowTab = true
        if !isShowTab {
            
        } else {
            isShowTab = false
            layer.masksToBounds = false
            
            UIView.animate(withDuration: 0.1) {
                self.contentView.alpha = 0
                if self.frame.origin.x + self.mainImageButton.frame.origin.x <= kScreenWidth / 2.0 {
                    self.frame = CGRect.init(x: self.frame.origin.x, y: self.frame.origin.y, width: self.frameWidth, height: self.frameWidth)
                } else {
                    self.mainImageButton.frame = CGRect.init(x: 0, y: 0, width: self.frameWidth, height: self.frame.width)
                    self.frame = CGRect.init(x: self.frame.origin.x + CGFloat(self.imagesAndTitle?.count ?? 0) * (self.frameWidth + 5.0), y: self.frame.origin.y, width: self.frameWidth, height: self.frameWidth)
                }
                self.backgroundColor = UIColor.clear
            }
            self.perform(#selector(changeStatus), with: nil, afterDelay: 3.0)
        }
    }
    
    @objc private func mainBtnTouchDown() {
        
    }
    
    @objc private func locationChange(p: UIPanGestureRecognizer) {
        let panPoint = p.location(in: UIApplication.shared.keyWindow)
        if p.state == .began {
            NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(changeStatus), object: nil)
            mainImageButton.alpha = 0.8
        } else if p.state == .changed {
            center = CGPoint.init(x: panPoint.x, y: panPoint.y)
        } else if p.state == .ended {
            stopAnimation()
            perform(#selector(changeStatus), with: nil, afterDelay: 3.0)
            
            UIView.animate(withDuration: 0.3) {
                if panPoint.x <= kScreenWidth / 2.0 {
                    if panPoint.y <= 40 + self.frame.height / 2.0 && panPoint.x >= 20 + self.frame.width / 2.0 {
                        self.center = CGPoint.init(x: panPoint.x, y: self.frame.height / 2.0)
                    } else if panPoint.y >= kScreenHeight - self.frame.height / 2.0 - 40 && panPoint.x >= 20 + self.frame.width / 2.0 {
                        self.center = CGPoint.init(x: panPoint.x, y: kScreenHeight - self.frame.height / 2.0)
                    } else if panPoint.x < self.frame.width / 2.0 + 20 && panPoint.y > kScreenHeight - self.frame.height / 2.0 {
                        self.center = CGPoint.init(x: self.frame.width / 2.0, y: kScreenHeight - self.frame.height / 2.0)
                    } else {
                        self.center = CGPoint.init(x: self.frame.width / 2, y: panPoint.y < self.frame.height / 2.0 ? self.frame.height / 2.0 : panPoint.y)
                    }
                } else {
                    if panPoint.y <= 40 + self.frame.height / 2.0 && panPoint.x < kScreenWidth - self.frame.width / 2.0 - 20 {
                        self.center = CGPoint.init(x: panPoint.x, y: self.frame.height / 2.0)
                    } else if panPoint.y >= kScreenHeight - self.frame.height / 2.0 - 40 && panPoint.x < kScreenWidth - 20 - self.frame.width / 2.0 {
                        self.center = CGPoint.init(x: panPoint.x, y: kScreenHeight - self.frame.height / 2.0)
                    } else if panPoint.x > kScreenWidth - self.frame.width / 2.0 - 20 && panPoint.y < self.frame.height / 2.0 {
                        self.center = CGPoint.init(x: self.frame.width / 2.0, y: kScreenHeight - self.frame.height / 2.0)
                    } else {
                        self.center = CGPoint.init(x: self.frame.width / 2, y: panPoint.y > (kScreenHeight - self.frame.height / 2.0) ? (kScreenHeight - self.frame.height / 2.0) : panPoint.y)
                    }
                }
            }
        }
    }
    
    @objc private func buttonAnimation() {
        
    }
    
    @objc private func changeStatus() {
        UIView.animate(withDuration: 1.0) {
            self.mainImageButton.alpha = 0.3
        }
        UIView.animate(withDuration: 0.5) {
            var x: CGFloat = self.center.x
            if self.center.x < 20 + self.frame.width / 2.0 {
                x = 0
            } else if self.center.x > kScreenWidth - 20 - self.frame.width / 2.0 {
                x = kScreenWidth
            }
            var y: CGFloat = self.center.y
            if self.center.y < 40 + self.frame.height / 2.0 {
                y = 0
            } else if self.center.y > kScreenHeight - 40 - self.frame.height / 2.0 {
                y = kScreenHeight
            }
            
            if (x == 0 && y == 0) ||
                (x == 0 && y == kScreenHeight) ||
                (x == kScreenWidth && y == 0) ||
                (x == kScreenWidth && y == kScreenHeight) {
                y = self.center.y
            }
            
            self.center = CGPoint.init(x: x, y: y)
        }
    }
    
    private func doBorder(width: CGFloat, color: UIColor?, radius: CGFloat) {
        layer.cornerRadius = radius
        layer.borderWidth = width
        if let color = color {
            layer.borderColor = color.cgColor
        } else {
            layer.borderColor = UIColor.white.cgColor
        }
    }
    
    private func stopAnimation() {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(buttonAnimation), object: nil)
        circleShape?.removeFromSuperlayer()
    }
}
