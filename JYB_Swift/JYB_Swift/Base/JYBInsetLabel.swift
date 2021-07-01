//
//  JYBInsetLabel.swift
//  JYB_Swift
//
//  Created by kim on 2021/1/12.
//

import UIKit

class JYBInsetLabel: UILabel {

    var contentInset: UIEdgeInsets?
    
    override func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
        guard let contentInset = contentInset else {
            return super.textRect(forBounds: bounds, limitedToNumberOfLines: numberOfLines)
        }
        /*
        调用父类该方法
        注意传入的UIEdgeInsetsInsetRect(bounds, self.edgeInsets),bounds是真正的绘图区域
        */
        var rect = super.textRect(forBounds: bounds.inset(by: contentInset), limitedToNumberOfLines: numberOfLines)
        //根据edgeInsets，修改绘制文字的bounds
        rect.origin.x -= contentInset.left
        rect.origin.y -= contentInset.top
        rect.size.width += contentInset.left + contentInset.right
        rect.size.height += contentInset.top + contentInset.bottom
        return rect
    }

}
