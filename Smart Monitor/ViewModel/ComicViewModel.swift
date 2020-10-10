//
//  ComicViewModel.swift
//  Smart Monitor
//
//  Created by Dhanraj Kawade on 09/10/20.
//

import Foundation

// Class to get and parse comic/charcater Data
class ComicViewModel: NSObject {
    
    static let sharedInstance = ComicViewModel()
    
    /// Get Comic list API call
    /// - Parameters:
    ///   - offSet: offset
    ///   - limit: limit to fetch data
    ///   - isSearch: searched data
    ///   - searchText: serach string
    ///   - completion: completion description
    func getComicListAPI(offSet:Int?, limit:Int?, isSearch:Bool, searchText:String?, completion: @escaping (ComicModel?, HTTPURLResponse?) -> Void) {
        
        var type = ""
        
        if isSearch { // searching for comic
            type = String(format: APIConstant.comicsStartWith, searchText ?? "")
        }
        else {
            type = APIConstant.comics
        }
        
        let parameters = type + "\(APIConstant.offset)=\(offSet ?? 0)&\(APIConstant.limit)=\(limit ?? 0)&"
        let url = Endpoint.createEndpoint(parameters: parameters)
        
        APIClient.sharedInstance.makeJsonAPICall(url: url, params: nil, method: .GET, success: { (data, response, error) in
            
            do
            {
                if let jsonData = data
                {
                    let comics = try JSONDecoder().decode(ComicModel.self, from: jsonData)
                    completion(comics, response)
                }
            }
            catch
            {
                print(error.localizedDescription)
                completion(nil, response)
            }
            
        }, failure: { (data, response, error) in
            
            completion(nil, response)
        })
    }
    
    /// Get character list API call
    /// - Parameters:
    ///   - offSet: offset
    ///   - limit: limit to fetch data
    ///   - comicId: get characters based on comic id
    ///   - completion: completion description
    func getComicCharactersListAPI(offSet:Int?, limit:Int?, comicId:String?, completion: @escaping (CharacterModel?, HTTPURLResponse?) -> Void) {
        
        let charId = String(format: APIConstant.characters, comicId ?? "")
        
        let parameters = charId + "\(APIConstant.offset)=\(offSet ?? 0)&\(APIConstant.limit)=\(limit ?? 0)&"
        let url = Endpoint.createEndpoint(parameters: parameters)
        
        APIClient.sharedInstance.makeJsonAPICall(url: url, params: nil, method: .GET, success: { (data, response, error) in
            
            do
            {
                if let jsonData = data
                {
                    let comics = try JSONDecoder().decode(CharacterModel.self, from: jsonData)
                    completion(comics, response)
                }
            }
            catch
            {
                print(error.localizedDescription)
                completion(nil, response)
            }
            
        }, failure: { (data, response, error) in
            
            completion(nil, response)
        })
    }
}
