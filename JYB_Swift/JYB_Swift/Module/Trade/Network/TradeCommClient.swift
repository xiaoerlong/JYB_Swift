//
//  TradeCommClient.swift
//  JYB_Swift
//
//  Created by kim on 2021/1/11.
//

import Foundation

// 通信包定义
struct MDPHead {
    var pkgSize: CInt           // 包大小（include sizeof(MDPHead)）
    var type: CUnsignedShort    // 协议类型
}

struct XMLHead {
    var pkgSize: CInt           // 包大小（include sizeof(XMLHead)）
    var type: CUnsignedShort    // 协议类型
}

struct CHALLENGE_INFO {
    let headMark: [CUnsignedChar]   // 头部标记
    let date: CUnsignedLong         // 日期
    let challengeInfo: [CUnsignedChar]  // 挑战信息
    let key: [CUnsignedChar]        // 加密的key
    let endMark: [CUnsignedChar]    // 尾部标记
}

struct IITG_QUERY_XML {
    let pkgSize: CInt           // 包大小
    let type: CUnsignedShort    // 协议类型
    let msgNum: CInt            // Msg序号
}

/// 通讯对象，定义了通讯行为
class TradeCommClient {
    private var readStream: InputStream?
    private var writeStream: OutputStream?
    
    private var isConnect = false
    
    func connect() -> Bool {
        if isConnect {
            return true
        }
        
        let tradeThread = Thread.init(target: self, selector: #selector(threadEntry), object: nil)
        tradeThread.name = "com.trade.jyb"
        tradeThread.start()
        
        
        
        return false
    }
    
    func disconnect() {
        isConnect = false
        guard let readStream = readStream, let writeStream = writeStream else {
            return
        }
        readStream.delegate = nil
        readStream.remove(from: .current, forMode: .default)
        readStream.close()
        
        writeStream.delegate = nil
        writeStream.remove(from: .current, forMode: .default)
        writeStream.close()
    }
}

extension TradeCommClient {
    @objc private func threadEntry() {
        if isConnect {
            return
        }
        
        var cfreadStream: Unmanaged<CFReadStream>?
        var cfwriteStream: Unmanaged<CFWriteStream>?
        CFStreamCreatePairWithSocketToHost(kCFAllocatorDefault, "203.85.34.230" as CFString, 10001, &cfreadStream, &cfwriteStream)
        
        
    }
    
    private func play() {
        
    }
}
