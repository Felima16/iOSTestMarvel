//
//  API.swift
//  iOSTestEokoe
//
//  Created by Fernanda de Lima on 11/09/2018.
//  Copyright © 2018 FeLima. All rights reserved.
//

import Foundation
import UIKit

enum Endpoint {
    
    case comics(Int)
    
    func pathEndpoint() ->String {
        switch self {
        case .comics(let start):
            return "v1/public/comics?limit=20&offset=\(start)&apikey=a2c5e01e9a387aa258fe0f2a5a2b5c66"

        }
    }
    
}


class API{
    
    static var page = 0
    
    static let baseUrl = "https://gateway.marvel.com:443/"
    
    static func get <T: Any>
        (_ type: T.Type,
         endpoint: Endpoint,
         success:@escaping (_ item: T) -> Void,
         fail:@escaping (_ error: Error) -> Void) -> Void where T:Codable {

        let url = "\(baseUrl)\(endpoint.pathEndpoint())"
        
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        //create session to connection
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
            do {
                
                //verify response
                if let httpResponse = response as? HTTPURLResponse {
                    if httpResponse.statusCode == 200{ //it's ok
                        //verify if have response data
                        if let data = data{
                            let jsonDecoder = JSONDecoder()
                            let jsonArray = try jsonDecoder.decode(type.self, from: data)
                            success(jsonArray)
                        }
                    }
                }
                
            } catch {
                fail(error)
            }
            
        })
        
        task.resume()
    }
    
}
