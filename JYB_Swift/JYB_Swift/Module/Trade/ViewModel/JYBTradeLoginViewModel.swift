//
//  JYBTradeLoginViewModel.swift
//  JYB_Swift
//
//  Created by kim on 2023/8/24.
//

import Foundation
import XMLCoder
import RxSwift
import RxRelay

enum LoginStatusCode {
    case normal
    case psg_2fa
}

class JYBTradeLoginViewModel: NSObject {
    public var statusRelay = PublishRelay<LoginStatusCode>.init()
    
    private let commClient = ClientComm()
    private var loginRes: LoginResponse?
    private var userName: String?
    private var pass: String?
    
    override init() {
        super.init()
        commClient.delegate = self
    }
    
    // 首次登录
    func login(account: String, password: String) {
        userName = account
        pass = password
        let header = XMLHeader(version: 1.0, encoding: "UTF-8", standalone: "yes")
        
        let login_req = LoginRequest(user_id: account, password: password, extra: LoginRequest.Extra())
        
        do {
            let encoder = XMLEncoder()
            encoder.outputFormatting = [.prettyPrinted]
            let encodeXML = try encoder.encode(login_req, withRootKey: "login", rootAttributes: ["msgnum": "398"], header: header)
            if let str = String(data: encodeXML, encoding: .utf8) {
                commClient.sendMessage(str)
            }
        } catch {
            print("xml编码错误:\(error)")
        }
    }
    
    // 2FA 登录
    func secondLogin(opt_code: String) {
        guard let user_name = userName, let pass = pass, let session = loginRes?.session else { return }
        let header = XMLHeader(version: 1.0, encoding: "UTF-8", standalone: "yes")
        
        var extra = LoginRequest.Extra()
        extra.opt_code = opt_code
        
        let login_req = LoginRequest(user_id: user_name, password: pass, session: session, extra: extra)
        
        do {
            let encoder = XMLEncoder()
            encoder.outputFormatting = [.prettyPrinted]
            let encodeXML = try encoder.encode(login_req, withRootKey: "login", rootAttributes: ["msgnum": "399"], header: header)
            if let str = String(data: encodeXML, encoding: .utf8) {
                commClient.sendMessage(str)
            }
        } catch {
            print("xml编码错误:\(error)")
        }
    }
}

extension JYBTradeLoginViewModel: ClientCommDelegate {
    // 收到数据
    func processResponseData(_ recStr: String) {
        do {
            let login_res = try XMLDecoder().decode(LoginResponse.self, from: Data(recStr.utf8))
            loginRes = login_res
            switch login_res.result {
            case .success:
                statusRelay.accept(.normal)
            case .TSCI_110_00004:
                statusRelay.accept(.psg_2fa)
            }
        } catch {
            print("xml解码错误:\(error)")
        }
    }
}
