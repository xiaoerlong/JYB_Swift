//
//  JYBNewsViewController.swift
//  JYB_Swift
//
//  Created by kim on 2021/1/18.
//

import UIKit

class JYBNewsViewController: UIViewController {
    
    private lazy var segmentView: JYBSegmentView = {
        let segmentView = JYBSegmentView()
        segmentView.delegate = self
        return segmentView
    }()
    
    private lazy var pageController: UIPageViewController = {
        let controller = UIPageViewController.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        controller.dataSource = self
        controller.delegate = self
        controller .setViewControllers([JYBNewsChannelViewController()], direction: .forward, animated: false, completion: nil)
        return controller
    }()
    
    private var currentIndex: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        setNavigationBar()
        setupView()
    }
    
    private func setNavigationBar() {
        navigationItem.title = "资讯"
        let leftItem = UIBarButtonItem.init(image: UIImage.init(named: "Home_notLogin"), style: .plain, target: self, action: #selector(pushToPersonCenter))
        navigationItem.leftBarButtonItem = leftItem
        let rightItem1 = UIBarButtonItem.init(image: UIImage.init(named: "hp-message"), style: .plain, target: self, action: #selector(methodTips))
        let rightItem2 = UIBarButtonItem.init(image: UIImage.init(named: "pc-setting"), style: .plain, target: self, action: #selector(setting))
        navigationItem.rightBarButtonItems = [rightItem2, rightItem1]
    }
    
    private func setupView() {
        self.themeChangedHandler = { [unowned self] in
            self.view.backgroundColor = AppTheme.manager.deepSkinBackgroundColor
        }
        view.addSubview(segmentView)
        segmentView.snp.makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.top.equalTo(0)
            make.height.equalTo(36)
        }
        
        addChild(pageController)
        view.addSubview(pageController.view)
        pageController.view.snp.makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.top.equalTo(segmentView.snp.bottom)
            if #available(iOS 11.0, *) {
                make.bottom.equalTo(view.safeAreaLayoutGuide)
            } else {
                make.bottom.equalTo(0)
            }
        }
        pageController.didMove(toParent: self)
        
    }
    
    private func getVC(at index: Int) -> UIViewController {
        currentIndex = index
        if index == 0 {
            return JYBNewsChannelViewController()
        }
        return TestAViewController()
    }
    
    @objc private func pushToPersonCenter() {
        let personCenterVC = JYBPersonCenterViewController()
        navigationController?.pushViewController(personCenterVC, animated: true)
    }

    @objc private func methodTips() {
        
    }
    
    @objc private func setting() {
        let controller = JYBWebViewController()
        navigationController?.pushViewController(controller, animated: true)
    }
}

extension JYBNewsViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let index = segmentView.currentIndex - 1
        if index < 0 {
            return nil
        }
        return getVC(at: index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let index = segmentView.currentIndex + 1
        if index >= 8 {
            return nil
        }
        return getVC(at: index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed {
            // 获取controller的位置
            segmentView.currentIndex = currentIndex
        }
    }
    
}

extension JYBNewsViewController: JYBSegmentViewDelegate {
    func segmentView(_ segmentView: JYBSegmentView, didSelectRowAt index: Int) {
        pageController.setViewControllers([getVC(at: index)], direction: (index > currentIndex ? .forward : .reverse), animated: true, completion: nil)
    }
}
