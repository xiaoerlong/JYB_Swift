//
//  CommClient.swift
//  JYB_Swift
//
//  Created by kim on 2023/8/2.
//

import Foundation
import SwiftyRSA

// 通信包定义
struct CMS_CLIENT_CHALLENGE_SERVER {
    var pkgSize: CInt           // 包大小（include sizeof(MDPHead)）
    var type: CUnsignedShort    // 协议类型
    var EncryptInfo: [CUnsignedChar] // 经过RSA public key加密的 ( 挑战信息 + key ). 128
}

struct MDPHead {
    var pkgSize: CInt           // 包大小（include sizeof(MDPHead)）
    var type: CUnsignedShort    // 协议类型
}

struct XMLHead {
    var pkgSize: CInt           // 包大小（include sizeof(XMLHead)）
    var type: CUnsignedShort    // 协议类型
}

struct CHALLENGE_INFO: Codable {
    var headMark: [CUnsignedChar] = [CUnsignedChar](repeating: 0, count: 4)   // 头部标记
    var date: CUnsignedLong         // 日期
    var challengeInfo: [CUnsignedChar]  // 挑战信息
    var key: [CUnsignedChar]        // 加密的key
    var endMark: [CUnsignedChar] = [CUnsignedChar](repeating: 0, count: 4)   // 尾部标记
    
    init() {
        headMark = [CUnsignedChar](repeating: 0, count: 4)
        date = 0
        challengeInfo = [CUnsignedChar](repeating: 0, count: 24)
        key = [CUnsignedChar](repeating: 0, count: 24)
        endMark = [CUnsignedChar](repeating: 0, count: 4)
    }
}

struct IITG_QUERY_XML {
    let pkgSize: CInt           // 包大小
    let type: CUnsignedShort    // 协议类型
    let msgNum: CInt            // Msg序号
}


class CommClient: NSObject {
    var inputStream: InputStream!
    var outputStream: OutputStream!
    
    
    func connectToServer() {
        var readStream: Unmanaged<CFReadStream>?
        var writeStream: Unmanaged<CFWriteStream>?
        
        CFStreamCreatePairWithSocketToHost(kCFAllocatorDefault, "203.85.34.230" as CFString, 10001, &readStream, &writeStream)
        
        inputStream = readStream!.takeRetainedValue()
        outputStream = writeStream!.takeRetainedValue()
        
        inputStream.delegate = self
        
        // 添加到 runloop
        inputStream.schedule(in: .current, forMode: .common)
        outputStream.schedule(in: .current, forMode: .common)
        
        // 开启
        inputStream.open()
        outputStream.open()
    }
}

// MARK: 实现三次握手过程
extension CommClient {
    // 1.MDPHead+CHALLENGE_INFO
    func challengeFirst() {
       let obj = Test()
        obj.challenge(outputStream)
    }
    
    func joinChat(username: String) {
      //1
      let data = "iam:\(username)".data(using: .utf8)!
      

      //3
      data.withUnsafeBytes {
        guard let pointer = $0.baseAddress?.assumingMemoryBound(to: UInt8.self) else {
          print("Error joining chat")
          return
        }
        //4
        outputStream.write(pointer, maxLength: data.count)
      }
    }
}

extension CommClient: StreamDelegate {
    func stream(_ aStream: Stream, handle eventCode: Stream.Event) {
        switch eventCode {
        case .endEncountered:
            print("endEncounterer")
        case .errorOccurred:
            print("errorOccurred")
        case .hasBytesAvailable:
            print("hasBytesAvailable")
            
        case .hasSpaceAvailable:
            print("hasBytesAvailable")
        case .openCompleted:
            print("openCompleted")
        default:
            print("Other")
        }
    }
}
