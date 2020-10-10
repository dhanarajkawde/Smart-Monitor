//
//  APIConstant.swift
//  Smart Monitor
//
//  Created by Dhanraj Kawade on 09/10/20.
//

import Foundation

// struct for API end points
struct APIConstant {
    
    // MARK:- API End Point
    static let comics = "comics?"
    static let comicsStartWith = "comics?titleStartsWith=%@&"
    static let characters = "comics/%@/characters?"
    
    // MARK:- Parameters
    static let offset = "offset"
    static let limit = "limit"
}
