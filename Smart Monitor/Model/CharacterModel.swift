//
//  CharacterModel.swift
//  Smart Monitor
//
//  Created by Dhanraj Kawade on 10/10/20.
//

import Foundation

// structs to parse character data

struct CharacterModel : Codable {
    
    var code:Int?
    var status:String?
    var copyright:String?
    var attributionText:String?
    var attributionHTML:String?
    var etag:String?
    var data:CharacterData?
}

struct CharacterData : Codable {
    
    var offset:Int?
    var limit:Int?
    var total:Int?
    var count:Int?
    var results:[CharacterResult]?
}

struct CharacterResult : Codable {
    
    var id:Int?
    var name:String?
    var description:String?
    var modified:String?
    var resourceURI:String?
    var urls:[Urls]?
    var series:Series?
    var thumbnail:Thumbnail?
    var comics:Creators?
    var stories:Creators?
    var events:Creators?
}
