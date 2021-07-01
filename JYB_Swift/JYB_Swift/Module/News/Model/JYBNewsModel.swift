//
//  JYBNewsModel.swift
//  JYB_Swift
//
//  Created by kim on 2021/1/28.
//

import UIKit

struct BaseModel: HandyJSON {
    var result: Int?
    var msg: String?
    var data: JYBNewsContainerModel?
    init() {

    }
}

struct JYBNewsContainerModel: HandyJSON {
    var page: Int = 0
    var total_num: Int = 0
    var lastId: String?
    var list: [JYBNewsModel]?
}

struct JYBNewsStockModel: HandyJSON {

    var m_code: String?
    var m_name: String?
    var type: String?

    init() {

    }

    mutating func mapping(mapper: HelpingMapper) {
        mapper.specify(property: &m_code, name: "code")
        mapper.specify(property: &m_name, name: "name")
    }

}

struct JYBNewsModel: HandyJSON {
    var m_nid: String?
    var m_title: String?
    var m_time: String?
    var m_views: Int = 0
    var m_reviews: Int = 0
    var m_source: String?
    var m_sourceURL: String?
    var m_summary: String?
    var m_img: String?
    var m_originImag: String?
    var m_stocks: [JYBNewsStockModel]?

    init() {

    }

    mutating func mapping(mapper: HelpingMapper) {
        mapper.specify(property: &m_nid, name: "nid")
        mapper.specify(property: &m_title, name: "title")
        mapper.specify(property: &m_time, name: "time")
        mapper.specify(property: &m_views, name: "views")
        mapper.specify(property: &m_reviews, name: "reviews")
        mapper.specify(property: &m_source, name: "source")
        mapper.specify(property: &m_summary, name: "summary")
        mapper.specify(property: &m_img, name: "img")
        mapper.specify(property: &m_stocks, name: "stocks")
    }
}


//struct BaseModel: Mappable {
//    init?(map: Map) {
//        
//    }
//    
//    mutating func mapping(map: Map) {
//        result <- map["result"]
//        
//    }
//    
//    var result: Int!
//    var msg: String!
//    var data: JYBNewsModel!
//}
//
//struct JYBNewsStockModel: HandyJSON {
//    
//    var m_code: String?
//    var m_name: String?
//    var type: String?
//    
//    init() {
//        
//    }
//    
//    mutating func mapping(mapper: HelpingMapper) {
//        mapper.specify(property: &m_code, name: "code")
//        mapper.specify(property: &m_name, name: "name")
//    }
//    
//}
//
//struct JYBNewsModel: HandyJSON {
//    var m_nid: String?
//    var m_title: String?
//    var m_time: String?
//    var m_views: Int = 0
//    var m_reviews: Int = 0
//    var m_source: String?
//    var m_sourceURL: String?
//    var m_summary: String?
//    var m_img: String?
//    var m_originImag: String?
//    var m_stocks: [JYBNewsStockModel]?
//    
//    init() {
//        
//    }
//    
//    mutating func mapping(mapper: HelpingMapper) {
//        mapper.specify(property: &m_nid, name: "nid")
//        mapper.specify(property: &m_title, name: "title")
//        mapper.specify(property: &m_time, name: "time")
//        mapper.specify(property: &m_views, name: "views")
//        mapper.specify(property: &m_reviews, name: "reviews")
//        mapper.specify(property: &m_source, name: "source")
//        mapper.specify(property: &m_summary, name: "summary")
//        mapper.specify(property: &m_img, name: "img")
//        mapper.specify(property: &m_stocks, name: "stocks")
//    }
//}
