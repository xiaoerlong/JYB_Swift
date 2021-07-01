//
//  HomeAppsVC.swift
//  JYB_Swift
//
//  Created by kim on 2021/3/24.
//

import UIKit

class HomeAppsVC: UIViewController {
    
    lazy var topView: UIView = {
        let view = HomeAppsTopView()
        view.snp.makeConstraints { (make) in
            make.height.equalTo(70)
        }
        return view
    }()
    
    lazy var bottomView: UIView = {
        let view = HomeAppsBottomView()
        return view
    }()
    
    var topModels = [HomeAppModel]()
    var bottomModels = [HomeAppModel]()
    var appModels = [HomeAppModel]()
    
    // MARK: Life Cycle
    static let shared = HomeAppsVC()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        let customResult = UserDefaults.standard.object(forKey: "HPAppCustomDict") as? [String: Any]
        let allResult = UserDefaults.standard.object(forKey: "HPAppAllDict") as? [String: Any]
        createAllModels(with: allResult)
        createCustomModels(with: customResult)
        dealWithAppModels()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    
    // MARK: Public
    public func request() {
        let group = DispatchGroup()
        group.enter()
        requestCustomIconList {
            group.leave()
        }
        group.enter()
        requestHomeIconList {
            group.leave()
        }
        group.notify(queue: DispatchQueue.main) {
            self.dealWithAppModels()
        }
    }
    
    // 请求自定义数据
    private func requestCustomIconList(_ completion: @escaping ()-> Void) {
        MainNetworkClient.requestCustomIcons { (res, err) in
            
        }
    }
    
    // 请求全部数据
    private func requestHomeIconList(_ completion: @escaping ()-> Void) {
        MainNetworkClient.requestHomeIconList { (res, err) in
            
        }
    }
    
    public func updateCustomIconList(with myModels: [HomeAppModel]) {
        bottomModels = myModels
        
        
    }
    
    public static func goto(with appModel: HomeAppModel?) {
        guard let model = appModel else {
            return
        }
        
    }

    // MARK: Private
    private func createAllModels(with result: [String: Any]?) {
        guard let result = result else { return }
        if result.count == 0 {
            return
        }
        appModels.removeAll()
        guard let arr = result["list"] as? [[String: Any]] else {
            return
        }
        for dict in arr {
            if let model = HomeAppModel.deserialize(from: dict) {
                let notA = model.resourceType == "register" || model.chsName == "财经电台"
                if notA {
                    continue
                }
                if !model.isTop {
                    appModels.append(model)
                }
            }
        }
    }
    
    private func createCustomModels(with result: [String: Any]?) {
        guard let result = result else { return }
        if result.count == 0 {
            return
        }
        topModels.removeAll()
        bottomModels.removeAll()
        guard let arr = result["list"] as? [[String: Any]] else {
            return
        }
        for dict in arr {
            if let model = HomeAppModel.deserialize(from: dict) {
                let notA = model.resourceType == "register" || model.chsName == "财经电台"
                if notA {
                    continue
                }
                if model.isTop {
                    topModels.append(model)
                } else {
                    bottomModels.append(model)
                }
            }
        }
    }
    
    private func dealWithAppModels() {
        
    }

}
