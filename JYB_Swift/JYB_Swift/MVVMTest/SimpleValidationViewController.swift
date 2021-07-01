//
//  SimpleValidationViewController.swift
//  JYB_Swift
//
//  Created by kim on 2021/5/18.
//

import UIKit

class SimpleValidationViewController: UIViewController {
    @IBOutlet weak var usernameOutlet: UITextField!
    @IBOutlet weak var usernameValidOutlet: UILabel!
    
    @IBOutlet weak var passwordOutlet: UITextField!
    @IBOutlet weak var passwordValidOutlet: UILabel!
    
    @IBOutlet weak var doSomethingOutlet: UIButton!
    
    var disposeBag: DisposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        let minimalUsernameLength = 5
        let minimalPasswordLength = 5
        
        
        
        
        // 用户名是否有效
        let usernameValid = usernameOutlet.rx.text.orEmpty
            // 用户名 -》 用户名是否有效
            .map { $0.count >= minimalUsernameLength }
            .share(replay: 1)
        
        // 用户名是否有效 -》密码输入框是否可用
        usernameValid
            .bind(to: passwordOutlet.rx.isEnabled)
            .disposed(by: disposeBag)
        
        // 用户名是否有效 -> 用户名提示语是否隐藏
        usernameValid
            .bind(to: usernameValidOutlet.rx.isHidden)
            .disposed(by: disposeBag)
        
        
        // 密码是否有效
        let passwordValid = passwordOutlet.rx.text.orEmpty
            .map({ $0.count > minimalPasswordLength })
            .share(replay: 1)
        
        // 密码是否有效 -》密码提示语是否隐藏
        passwordValid
            .bind(to: passwordValidOutlet.rx.isHidden)
            .disposed(by: disposeBag)
        
        // 所有输入是否有效
        let everythingValid = Observable.combineLatest(
            usernameValid,
            passwordValid
        ) { $0 && $1 } // 取用户名和密码同时有效
        .share(replay: 1)
        
        // 所有输入是否有效 -》 绿色按钮是否可点击
        everythingValid
            .bind(to: doSomethingOutlet.rx.isEnabled)
            .disposed(by: disposeBag)
        
        // 点击绿色按钮 -》 弹出提示框
        doSomethingOutlet.rx.tap
            .subscribe(onNext:  { [weak self] in
                self?.showAlert()
            })
            .disposed(by: disposeBag)
        
        
        let numbers: Observable<Int> = Observable.create { observer -> Disposable in
                observer.onNext(0)
                observer.onNext(1)
                observer.onNext(2)
                observer.onNext(3)
                observer.onNext(4)
                observer.onNext(5)
                observer.onNext(6)
                observer.onNext(7)
                observer.onNext(8)
                observer.onNext(9)
                observer.onCompleted()
            
            return Disposables.create()
        }

        numbers.subscribe(onNext: { num in
            print(num)
        }, onError: nil, onCompleted: nil, onDisposed: nil)
        .disposed(by: disposeBag)
        
        
        let first = PublishSubject<String>()
        let second = PublishSubject<String>()
        Observable.combineLatest(first, second) { $0 + $1 }
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
        first.onNext("1")
        second.onNext("A")
        first.onNext("2")
        second.onNext("B")
        second.onNext("C")
        second.onNext("D")
        first.onNext("3")
        first.onNext("4")
        first.onNext("5")
        
        let disposeBag = DisposeBag()

        let sequence = Observable<String>.create { observer in
            observer.onNext("🍎")
            observer.onNext("🍐")
            observer.onCompleted()
            return Disposables.create()
        }

        sequence
            .debug("Fruit")
            .subscribe()
            .disposed(by: disposeBag)
        
    }
    

    func showAlert() {
        let alertView = UIAlertView(title: "RxExample", message: "This is wonderful", delegate: nil, cancelButtonTitle: "OK")
        alertView.show()
    }
}
