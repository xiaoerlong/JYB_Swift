//
//  JYBApplication.swift
//  JYB_Swift
//
//  Created by kim on 2022/2/28.
//

import UIKit

class JYBApplication: UIApplication {
    public var myidelTimer: Timer?
    
    override func sendEvent(_ event: UIEvent) {
        super.sendEvent(event)
        
        if myidelTimer == nil {
            resetIdelTimer()
        }
        if let allTouches = event.allTouches, allTouches.count > 0 {
            if let phase = allTouches.first?.phase {
                if phase == .began {
                    resetIdelTimer()
                }
            }
        }
        
    }
    
    // 重置时钟
    @objc public func resetIdelTimer() {
        myidelTimer?.invalidate()
        myidelTimer = nil
        
        let defaultTime: Double = 60 // 单位 秒
        let timeOut = TimeInterval(defaultTime * 60)
        myidelTimer = Timer.scheduledTimer(timeInterval: timeOut, target: self, selector: #selector(idleTimerExceeded), userInfo: nil, repeats: false)
    }
    
    @objc private func idleTimerExceeded() {
        print("达到超时时间")
    }
}
