//
//  APIClient.swift
//  Smart Monitor
//
//  Created by Dhanraj Kawade on 09/10/20.
//

import Foundation

//HTTP Methods
enum HttpMethod : String {
    case  GET
    case  POST
    case  DELETE
    case  PUT
}

class APIClient {
    
    //TODO: remove app transport security arbitary constant from info.plist file once we get API's
    var request : URLRequest?
    var session : URLSession?
    
    static let sharedInstance = APIClient()
    
    func makeJsonAPICall(url: String,params: Dictionary<String, Any>?, method: HttpMethod, success:@escaping ( Data?, HTTPURLResponse?, Error? ) -> Void, failure: @escaping ( Data? ,HTTPURLResponse?  , NSError? )-> Void) {
        
        request = URLRequest(url: URL(string: url)!)
        
        if let params = params {
            
            let  jsonData = try? JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
            
            request?.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request?.setValue("application/json", forHTTPHeaderField: "Accept")
            request?.httpBody = jsonData
        }
        request?.httpMethod = method.rawValue
        
        let configuration = URLSessionConfiguration.default
        
        configuration.timeoutIntervalForRequest = 60
        configuration.timeoutIntervalForResource = 60
        
        session = URLSession(configuration: configuration)
        
        session?.dataTask(with: request! as URLRequest) { (data, response, error) -> Void in
            
            if let data = data {
                
                success(data, response as? HTTPURLResponse, error as NSError?)

            }else {
                
                failure(data , response as? HTTPURLResponse, error as NSError?)
            }
        }.resume()
    }
}
