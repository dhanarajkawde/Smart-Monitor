//
//  EndPoint.swift
//  Smart Monitor
//
//  Created by Dhanraj Kawade on 09/10/20.
//

import Foundation
import SwiftHash

struct Endpoint {
    
    static let basePath = "https://gateway.marvel.com:443/v1/public/"
    static let publicKey = "e76f8687a2d65f38d79f2942f9077ad0"
    static let privateKey = "be09dbff6e48cee2efd67920169b679fcd62e258"
    
    static func createEndpoint(parameters: String) -> String {
        let url = Endpoint.basePath + parameters + getCredentials()
        return url
    }
    
    static func getCredentials() -> String {
        let ts = String(Date().timeIntervalSince1970)
        let hash = MD5(ts+Endpoint.privateKey+Endpoint.publicKey).lowercased()
        return "ts=\(ts)&apikey=\(Endpoint.publicKey)&hash=\(hash)"
    }
}
