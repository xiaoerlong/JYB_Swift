//
//  TestCViewController.swift
//  JYB_Swift
//
//  Created by kim on 2021/1/26.
//

import UIKit

class TestCViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .blue
        let label = UILabel()
        label.text = "C"
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        view.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.left.top.equalTo(view)
        }
    }

}
