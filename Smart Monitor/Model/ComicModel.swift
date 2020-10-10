//
//  ComicModel.swift
//  Smart Monitor
//
//  Created by Dhanraj Kawade on 10/10/20.
//

import Foundation

// structs to parse comic data

struct ComicModel : Codable {
    
    var code:Int?
    var status:String?
    var copyright:String?
    var attributionText:String?
    var attributionHTML:String?
    var etag:String?
    var data:ComicData?
}

struct ComicData : Codable {
    
    var offset:Int?
    var limit:Int?
    var total:Int?
    var count:Int?
    var results:[ComicResult]?
}

struct ComicResult : Codable {
    
    var id:Int?
    var digitalId:Int?
    var title:String?
    var issueNumber:Int?
    var variantDescription:String?
    var description:String?
    var modified:String?
    var isbn:String?
    var upc:String?
    var diamondCode:String?
    var ean:String?
    var issn:String?
    var format:String?
    var pageCount:Int?
    var resourceURI:String?
    var thumbnail:Thumbnail?
    
    //#TODO:- Extra Parameters
//    var urls:[Urls]?
//    var series:Series?
//    var variants:[Series]?
//    var dates:[Dates]?
//    var prices:[Price]?
//    var creators:Creators?
//    var characters:Creators?
//    var stories:Creators?
//    var events:Creators?
}

struct Urls : Codable {
    
    var type:String?
    var url:String?
}

struct Series : Codable {
    
    var resourceURI:String?
    var name:String?
    var items:[Items]?
}

struct Dates : Codable {
    
    var type:String?
    var date:String?
}

struct Price : Codable {
    
    var type:String?
    var price:Int?
}

struct Thumbnail: Codable {
    var path: String
    var `extension`: String
    
    var url: URL? {
        URL(string: "\(path).\(`extension`)")
    }
}

struct Creators : Codable {
    
    var available:Int?
    var returned:Int?
    var collectionURI:String?
    var items:[Items]?
}

struct Items : Codable {
    
    var resourceURI:String?
    var name:String?
    var role:String?
}

