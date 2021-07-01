//
//  TradeClient.swift
//  JYB_Swift
//
//  Created by kim on 2020/12/31.
//

/// 交易客户端
import Foundation
import CocoaAsyncSocket


/// 交易对象
class Trader: NSObject {
    init(with broker: NSString) {
        
    }
}

class TradeClient: NSObject {
    static let shared = TradeClient()
    
    private var cocoaSocket: GCDAsyncSocket?
    private var connected: Bool = false
    private var connectTimer: Timer!

    // 建立连接
    func cocoaSocketConnect() {
        if connected {
            return
        }
        cocoaSocket = GCDAsyncSocket.init(delegate: self, delegateQueue: DispatchQueue.main)
        do {
            try cocoaSocket?.connect(toHost: "203.85.34.230", onPort: 10001, withTimeout: 20)
        } catch {
            print("连接失败:\(error)")
        }
        
    }
    
    // 断开连接
    func cocoaSocketDisConnect() {
        cocoaSocket?.delegate = nil
        cocoaSocket?.disconnect()
    }
    
    // 发送业务数据
    func writeData(_ data: Data) {
        
    }
}

extension TradeClient {
    //MARK: 握手流程
    struct CMS_CLIENT_CHALLENGE_SERVER {
        var pkgSize: Int        // 包大小
        var type: CShort        // 协议类型 31300
        var encryptInfo: [BYTE] // RSA公钥加密
        
        init() {
            pkgSize = 0
            type = 31300
            encryptInfo = []
        }
    }
    
    struct CHALLENGE_INFO {
        var headMark: [BYTE]
        
    }
    
    func challenge() {
        var pkg = CMS_CLIENT_CHALLENGE_SERVER()
        pkg.pkgSize = MemoryLayout<CMS_CLIENT_CHALLENGE_SERVER>.size
        pkg.type = 31300
        
        
    }
}

extension TradeClient {
    /// MARK:建立心跳连接
    func addTimer() {
        connectTimer = Timer.init(timeInterval: 5.0, target: self, selector: #selector(longConnectToSocket), userInfo: nil, repeats: true)
        RunLoop.current.add(connectTimer, forMode: .common)
    }
    
    // 心跳连接
    @objc private func longConnectToSocket() {
        
    }
}

extension TradeClient {
    /// 登录交易
    func login(account: String, password: String) {
        if connected == false {
            cocoaSocketConnect()
        }
        // 将对象转为xml字符串
        let loginRequest = LoginRequest()
        guard let xmlString = loginRequest.toXMLString() else {
            print("模型转换成xml失败")
            return
        }
        print("xmlString:\(xmlString)")
        // MDPHead + XMLHead + int + XML
        var pkgSize = MemoryLayout<CInt>.size + MemoryLayout<CShort>.size + MemoryLayout<CInt>.size
        
        var mdpHead = MDPHead(pkgSize: 0, type: 0)
        mdpHead.type = 31303
        mdpHead.pkgSize = CInt(pkgSize)
        let mdpHeadData = Data(bytes: &mdpHead, count: MemoryLayout.size(ofValue: mdpHead))
        
        var xmlHead = XMLHead(pkgSize: 0, type: 0)
        xmlHead.type = 51000
        xmlHead.pkgSize = CInt(pkgSize)
        let xmlHeadData = Data(bytes: &xmlHead, count: MemoryLayout.size(ofValue: xmlHead))
        
        
        
        var xmlLen = xmlString.count
        
        var data = Data()
        let pkgSizeData = Data(bytes: &pkgSize, count: MemoryLayout.size(ofValue: pkgSize))
        data.append(pkgSizeData)
        
        var msgTp: CUnsignedShort = 51000
        let msgTpData = Data(bytes: &msgTp, count: MemoryLayout.size(ofValue: msgTp))
        data.append(msgTpData)
        
        
        let xmlLenData = Data(bytes: &xmlLen, count: MemoryLayout.size(ofValue: xmlLen))
        data.append(xmlLenData)
        
        var cXML = xmlString.utf8CString
        let cXMLData = Data(bytes: &cXML, count: MemoryLayout.size(ofValue: cXML))
        data.append(cXMLData)
        
        cocoaSocket?.write(data, withTimeout: 20, tag: loginRequest.msgnum)
    }
}

extension TradeClient: GCDAsyncSocketDelegate {
    func socket(_ sock: GCDAsyncSocket, didConnectToHost host: String, port: UInt16) {
        print("连接成功")
        connected = true
        print("服务器IP:\(host),端口号:\(port)")
        sock.readData(withTimeout: -1, tag: 0)
    }
    
    func socketDidDisconnect(_ sock: GCDAsyncSocket, withError err: Error?) {
        print("连接失败:\(err?.localizedDescription ?? "")")
        connected = false
    }
    
    func socket(_ sock: GCDAsyncSocket, didWriteDataWithTag tag: Int) {
        print("写入数据 \(tag)")
    }
    
    // 读取数据
    func socket(_ sock: GCDAsyncSocket, didRead data: Data, withTag tag: Int) {
        let text = String.init(data: data, encoding: .utf8)
        print("读取到数据:\(text ?? "")")
        sock.readData(withTimeout: -1, tag: 0)
    }
}
