//
//  Extension.swift
//  JYB_Swift
//
//  Created by kim on 2020/12/30.
//

import Foundation
import UIKit

extension UIColor {
    // 0x123456
    convenience init(hex: UInt32) {
        let red = (hex & 0xFF0000) >> 16
        let green = (hex & 0x00FF00) >> 8
        let blue = (hex & 0x0000FF)
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1)
    }
}

extension UIImage {
    static func image(with color: UIColor) -> UIImage? {
        return image(with: color, size: CGSize.init(width: 1, height: 1))
    }
    
    static func image(with color: UIColor, size: CGSize) -> UIImage? {
        if size.width <= 0 || size.height <= 0 {
            return nil
        }
        let rect = CGRect.init(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    func roundImage() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(self.size, false, UIScreen.main.scale)
        let rect = CGRect.init(origin: CGPoint.zero, size: self.size)
        UIBezierPath.init(ovalIn: rect).addClip()
        self.draw(in: rect)
        let roundImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return roundImage
    }
    
    func scale(to size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(self.size, false, UIScreen.main.scale)
        let rect = CGRect.init(origin: CGPoint.zero, size: size)
        self.draw(in: rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}

extension String {
    // 获取subString的range
    func getNSRange(from subString: String) -> NSRange? {
        guard let r = self.range(of: subString) else {
            return nil
        }
        return NSRange.init(r, in: self)
    }
    
    /// Range -> NSRange
        func toNSRange(_ range: Range<String.Index>) -> NSRange? {
            guard let from = range.lowerBound.samePosition(in: utf16) else { return nil }
            guard let to = range.upperBound.samePosition(in: utf16) else { return nil }
            return NSRange(location: utf16.distance(from: utf16.startIndex, to: from),
                           length: utf16.distance(from: from, to: to))
        }
    
    /// NSRange -> Range
    func toRange(_ range: NSRange) -> Range<String.Index>? {
            guard let from16 = utf16.index(utf16.startIndex, offsetBy: range.location, limitedBy: utf16.endIndex) else { return nil }
            guard let to16 = utf16.index(from16, offsetBy: range.length, limitedBy: utf16.endIndex) else { return nil }
            guard let from = String.Index(from16, within: self) else { return nil }
            guard let to = String.Index(to16, within: self) else { return nil }
            return from ..< to
        }
}

extension UIView {
    func addRounded(with corners: UIRectCorner, radii: CGSize, rect: CGRect) {
        let rounded = UIBezierPath.init(roundedRect: rect, byRoundingCorners: corners, cornerRadii: radii)
        rounded.lineWidth = 0.1
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = rounded.cgPath
        layer.mask = shapeLayer
    }
    
    // 显示小红点
    func showBadge() {
        removeBadge()
        let bview = UIView()
        bview.tag = 888
        bview.layer.cornerRadius = 3
        bview.clipsToBounds = true
        bview.backgroundColor = UIColor.red
        let viewFrame = self.frame
        
        let x: CGFloat = CGFloat(ceil(viewFrame.size.width) - 3)
        let y: CGFloat = 3
        bview.frame = CGRect.init(x: x, y: y, width: 6, height: 6)
        addSubview(bview)
        bringSubviewToFront(bview)
    }
    
    // 隐藏小红点
    func hideBadge() {
        removeBadge()
    }
    
    private func removeBadge() {
        for subview in subviews {
            if subview.tag == 888 {
                subview.removeFromSuperview()
            }
        }
    }
}

// MARK: Theme
extension NSObject {
    fileprivate struct AssociatedKeys {
        static var themeChanged = "themeChanged"
    }
    
    public typealias ThemeChangedClosure = @convention(block) () -> Void
    
    var themeChangedHandler: ThemeChangedClosure? {
        get {
            let closureObject: AnyObject? = objc_getAssociatedObject(self, &AssociatedKeys.themeChanged) as AnyObject
            guard closureObject != nil else {
                return nil
            }
            let closure = unsafeBitCast(closureObject, to: ThemeChangedClosure.self)
            return closure
        }
        
        set {
            guard let value = newValue else {
                return
            }
            let dealObject: AnyObject = unsafeBitCast(value, to: AnyObject.self)
            objc_setAssociatedObject(self, &AssociatedKeys.themeChanged, dealObject, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            changeTheme()
            NotificationCenter.default.addObserver(self, selector: #selector(changeTheme), name: ThemeNotificationName, object: nil)
        }
    }
    
    @objc func changeTheme() {
        if let block = themeChangedHandler {
            block()
        }
    }
}


extension UIButton {
    func setBackgroundColor(color: UIColor, for state: UIControl.State) {
        let rect = CGRect.init(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.setBackgroundImage(img, for: .normal)
    }
}
