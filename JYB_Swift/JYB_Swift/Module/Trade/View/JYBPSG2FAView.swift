//
//  JYBPSG2FAView.swift
//  JYB_Swift
//
//  Created by kim on 2023/8/24.
//

import UIKit

class JYBPSG2FAView: UIView {
    typealias MyBlock = () -> Void
    
    var cancelBlock: MyBlock?
    var confirmBlock: ((String) -> Void)?
    
    @IBOutlet weak var textField: UITextField!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    private func setup() {
        clipsToBounds = true
        layer.cornerRadius = 5
    }
    @IBAction func cancelAction(_ sender: Any) {
        if let block = cancelBlock {
            block()
        }
    }
    
    @IBAction func loginAction(_ sender: Any) {
        guard let text = textField.text, !text.isEmpty else { return }
        if let block = confirmBlock {
            block(text)
        }
    }
}
