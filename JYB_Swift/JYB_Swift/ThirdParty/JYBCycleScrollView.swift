//
//  JYBCycleScrollView.swift
//  JYB_Swift
//
//  Created by kim on 2021/1/13.
//

import UIKit

/// 自定义轮播图
class JYBCycleScrollView: UIView {
    
    let JYBCycleCollectionCellIdentifier = "JYBCycleCollectionCellIdentifier"

    lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: flowLayout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(JYBCycleCollectionCell.self, forCellWithReuseIdentifier: JYBCycleCollectionCellIdentifier)
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    private var urls: [String] = [String]()

    init(with urls: [String]) {
        super.init(frame: CGRect.zero)
        self.urls = urls
        if let first = urls.first, let last = urls.last {
            self.urls.insert(last, at: 0)
            self.urls.append(first)
        }
        
        addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets.zero)
        }
        
        collectionView.contentSize = CGSize.init(width: CGFloat(self.urls.count) * kScreenWidth, height: 0)
        collectionView.contentOffset = CGPoint.init(x: kScreenWidth, y: 0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension JYBCycleScrollView: UICollectionViewDataSource, UIScrollViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return urls.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: JYBCycleCollectionCellIdentifier, for: indexPath) as! JYBCycleCollectionCell
        cell.imageView.image = UIImage.init(named: urls[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if collectionView.contentOffset.x == 0 { // 第一张图片
            collectionView.setContentOffset(CGPoint.init(x: collectionView.bounds.size.width * CGFloat(urls.count - 2), y: 0), animated: false)
        } else if collectionView.contentOffset.x == collectionView.bounds.size.width * CGFloat(urls.count - 1) { // 最后一张图片
            collectionView.setContentOffset(CGPoint.init(x: collectionView.bounds.size.width, y: 0), animated: false)
        }
    }
    
}

class JYBCycleCollectionCell: UICollectionViewCell {
    lazy var imageView: UIImageView! = {
        let imageView = UIImageView()
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets.zero)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
