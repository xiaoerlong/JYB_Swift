//
//  JYBLayoutButton.swift
//  JYB_Swift
//
//  Created by kim on 2020/12/31.
//

import UIKit

class JYBLayoutButton: UIButton {
    
    enum ImagePosition {
        case top
        case left
        case right
        case bottom
    }
    
    private var spacing: CGFloat = 0
    private var position: ImagePosition?
    
    convenience init(_ spacing: CGFloat, at position: ImagePosition) {
        self.init(type: .custom)
        
        self.spacing = spacing
        self.position = position
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        guard let position = position else {
            return
        }
        let titleSize = titleLabel?.frame.size ?? CGSize.zero
        let imageSize = imageView?.frame.size ?? CGSize.zero
        let imageOffsetX = (imageSize.width + titleSize.width) / 2 - imageSize.width / 2//image中心移动的x距离
        let labelOffsetX = (imageSize.width + titleSize.width / 2) - (imageSize.width + titleSize.width) / 2 //label中心移动的x距离
        
        switch position {
        case .top:
            imageEdgeInsets = UIEdgeInsets.init(top: -titleSize.height/2-spacing/2,
                                                left: labelOffsetX,
                                                bottom: titleSize.height/2+spacing/2,
                                                right: -labelOffsetX)
            titleEdgeInsets = UIEdgeInsets.init(top: imageSize.height/2+spacing/2,
                                                left: -imageOffsetX,
                                                bottom: -imageSize.height/2-spacing/2,
                                                right: imageOffsetX)
        case .bottom:
            imageEdgeInsets = UIEdgeInsets.init(top: titleSize.height/2+spacing/2,
                                                left: labelOffsetX,
                                                bottom: -titleSize.height/2-spacing/2,
                                                right: -labelOffsetX)
            titleEdgeInsets = UIEdgeInsets.init(top: -imageSize.height/2-spacing/2,
                                                left: -imageOffsetX,
                                                bottom: imageSize.height/2+spacing/2,
                                                right: imageOffsetX)
        case .left:
            imageEdgeInsets = UIEdgeInsets.init(top: 0,
                                                left: -spacing/2,
                                                bottom: 0,
                                                right: spacing/2)
            titleEdgeInsets = UIEdgeInsets.init(top: 0,
                                                left: spacing/2,
                                                bottom: 0,
                                                right: -spacing/2)
        case .right:
            imageEdgeInsets = UIEdgeInsets.init(top: 0,
                                                left: titleSize.width+spacing/2,
                                                bottom: 0,
                                                right: -titleSize.width-spacing/2)
            titleEdgeInsets = UIEdgeInsets.init(top: 0,
                                                left: -imageSize.width-spacing/2,
                                                bottom: 0,
                                                right: imageSize.width+spacing/2)
        }
    }

}
