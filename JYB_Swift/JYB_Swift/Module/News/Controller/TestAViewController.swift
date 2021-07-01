//
//  TestAViewController.swift
//  JYB_Swift
//
//  Created by kim on 2021/1/26.
//

import UIKit

class TestAViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .red
        let label = UILabel()
        label.text = "A"
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        view.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.center.equalTo(view.snp.center)
        }
        
       
        var transform = CGAffineTransform.identity
        transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        UIView.animate(withDuration: 1) {
            label.transform = transform
        } completion: { (finished) in
//            label.transform = CGAffineTransform.identity
        }
    }
    

}
