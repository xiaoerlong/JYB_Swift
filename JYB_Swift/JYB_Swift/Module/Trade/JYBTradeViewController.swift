//
//  JYBTradeViewController.swift
//  JYB_Swift
//
//  Created by kim on 2020/12/30.
//

import UIKit

class JYBTradeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setNavigationBar()
        setupView()
    }
    
    private func setNavigationBar() {
        navigationItem.title = "交易"
        let leftItem = UIBarButtonItem.init(image: UIImage.init(named: "Home_notLogin"), style: .plain, target: self, action: #selector(pushToPersonCenter))
        navigationItem.leftBarButtonItem = leftItem
        let rightItem = UIBarButtonItem.init(image: UIImage.init(named: "nav-icon-change"), style: .plain, target: self, action: #selector(pushToBindBrokerController))
        navigationItem.rightBarButtonItem = rightItem
    }
    
    private func setupView() {
        view.backgroundColor = UIColor.white
        
        let loginVC = JYBTradeLoginViewController()
        addChild(loginVC)
        view.addSubview(loginVC.view)
        loginVC.view.frame = view.bounds
        loginVC.didMove(toParent: self)
    }
    
    //MARK: Action
    @objc private func pushToPersonCenter() {
        let personCenterVC = JYBPersonCenterViewController()
        navigationController?.pushViewController(personCenterVC, animated: true)
    }
    
    @objc private func pushToBindBrokerController() {
        print("绑定券商")
    }
}
