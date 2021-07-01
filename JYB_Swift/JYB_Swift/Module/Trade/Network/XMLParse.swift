//
//  XMLParse.swift
//  JYB_Swift
//
//  Created by kim on 2021/1/4.
//

import Foundation

class XMLEncode {
    // 编码成XML格式
}

class XMLParse: NSObject {
    
    // 记录当前节点的名字
    var currentNodeName: String!
    
    func parseXML() {
        guard let path = Bundle.main.path(forResource: "test", ofType: "xml") else {
            print("找不到文件路径")
            return
        }
        let xmlURL = URL(fileURLWithPath: path)
        let parser = XMLParser(contentsOf: xmlURL)
        parser?.delegate = self
        parser?.parse()
        
        do {
            let result = try String.init(contentsOf: xmlURL, encoding: .utf8)
            print(result)
        } catch {
            print("error:\(error)")
        }
    }
}

extension XMLParse: XMLParserDelegate {
    func parserDidStartDocument(_ parser: XMLParser) {
        print("开始解析")
    }
    
    func parserDidEndDocument(_ parser: XMLParser) {
        print("结束解析")
    }
    
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print("parseError:\(parseError.localizedDescription)")
    }
    
    func parser(_ parser: XMLParser, validationErrorOccurred validationError: Error) {
        print("validationError:\(validationError.localizedDescription)")
    }
    
    // 获取节点及属性
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        // 记录当前节点
        currentNodeName = elementName
        
        // 打印当前节点的属性及值
        if elementName == "person" {
            if let id = attributeDict["id"] {
                print("id:\(id)")
            }
        }
    }
    
    // 获取节点的文本内容
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        let str = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        // 输出当前节点和文本
        if str != "" {
            print("当前节点:\(currentNodeName!)的文本:\(str)")
        }
    }
}
