//
//  TestBViewController.swift
//  JYB_Swift
//
//  Created by kim on 2021/1/26.
//

import UIKit

class TestBViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .green
        let label = UILabel()
        label.text = "B"
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        view.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.center.equalTo(view)
        }
    }

}
