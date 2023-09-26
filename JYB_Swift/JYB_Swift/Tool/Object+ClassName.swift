//
//  Object+ClassName.swift
//  JYB_Swift
//
//  Created by kim on 2023/8/24.
//

import Foundation

extension NSObject {
    var className: String {
        return String(describing: type(of: self))
    }
    
    class var className: String {
        return String(describing: self)
    }
}
