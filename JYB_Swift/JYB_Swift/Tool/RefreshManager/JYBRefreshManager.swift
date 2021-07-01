//
//  JYBRefreshManager.swift
//  JYB_Swift
//
//  Created by kim on 2021/1/29.
//

import UIKit

extension UIScrollView {
    
    func addPullToRefresh(_ handler: @escaping ESRefreshHandler) {
        var header: ESRefreshProtocol & ESRefreshAnimatorProtocol
        header = headerAnimator()
        self.es.addPullToRefresh(animator: header, handler: handler)
    }
    
    func addInfiniteScrolling(_ handler: @escaping ESRefreshHandler) {
        var footer: ESRefreshProtocol & ESRefreshAnimatorProtocol
        footer = footerAnimator()
        self.es.addInfiniteScrolling(animator: footer, handler: handler)
    }
    
    func headerAnimator() -> ESRefreshProtocol & ESRefreshAnimatorProtocol {
        let h = ESRefreshHeaderAnimator.init(frame: .zero)
        h.pullToRefreshDescription = "下拉刷新"
        h.releaseToRefreshDescription = "松开获取最新数据"
        h.loadingDescription = "下拉刷新..."
        return h
    }
    
    func footerAnimator() -> ESRefreshProtocol & ESRefreshAnimatorProtocol {
        let f = ESRefreshFooterAnimator.init(frame: .zero)
        f.loadingMoreDescription = "上拉加载更多"
        f.noMoreDataDescription = "数据已加载完"
        f.loadingDescription = "加载更多..."
        return f
    }
}
