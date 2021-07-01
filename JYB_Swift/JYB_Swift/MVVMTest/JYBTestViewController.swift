//
//  JYBTestViewController.swift
//  JYB_Swift
//
//  Created by kim on 2021/5/14.
//

import UIKit

class JYBTestViewController: UIViewController {

    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.red.cgColor
        return imageView
    }()
    
    lazy var cameraBtn: UIButton = {
        let button = UIButton.init(type: .custom)
        button.setTitle("Camera", for: .normal)
        button.setTitleColor(UIColor.red, for: .normal)
        return button
    }()
    
    lazy var galleryBtn: UIButton = {
        let button = UIButton.init(type: .custom)
        button.setTitle("Gallery", for: .normal)
        button.setTitleColor(UIColor.red, for: .normal)
        return button
    }()
    
    lazy var cropBtn: UIButton = {
        let button = UIButton.init(type: .custom)
        button.setTitle("Crop", for: .normal)
        button.setTitleColor(UIColor.red, for: .normal)
        return button
    }()
    
    var disposeBag: DisposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(imageView)
        view.addSubview(cameraBtn)
        view.addSubview(galleryBtn)
        view.addSubview(cropBtn)
        imageView.snp.makeConstraints { (make) in
            make.centerX.equalTo(view)
            make.top.equalTo(30)
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.height.equalTo(250)
        }
        cameraBtn.snp.makeConstraints { (make) in
            make.centerX.equalTo(view)
            make.top.equalTo(imageView.snp.bottom).offset(15)
        }
        galleryBtn.snp.makeConstraints { (make) in
            make.centerX.equalTo(view)
            make.top.equalTo(cameraBtn.snp.bottom).offset(15)
        }
        cropBtn.snp.makeConstraints { (make) in
            make.centerX.equalTo(view)
            make.top.equalTo(galleryBtn.snp.bottom).offset(15)
        }
        
        
        cameraBtn.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        
        cameraBtn.rx.tap
            .flatMapLatest { [weak self] _ in
                return UIImagePickerController.rx.createWithParent(self) { picker in
                    picker.sourceType = .camera
                    picker.allowsEditing = false
                }
                .flatMap{ $0.rx.didFinishPickingMediaWithInfo }
                .take(1)
            }
            .map { info in
                return info[.originalImage] as? UIImage
            }
            .bind(to: imageView.rx.image)
            .disposed(by: disposeBag)
        
        // 相册
        galleryBtn.rx.tap
            .flatMapLatest { [weak self] in
                return UIImagePickerController.rx.createWithParent(self) { (picker) in
                    picker.sourceType = .photoLibrary
                    picker.allowsEditing = false
                }
                .flatMap {
                    $0.rx.didFinishPickingMediaWithInfo
                }
                .take(1)
            }
            .map { info in
                return info[.originalImage] as? UIImage
            }
            .bind(to: imageView.rx.image)
            .disposed(by: disposeBag)
    }
}
