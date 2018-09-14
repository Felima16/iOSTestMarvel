//
//  Results.swift
//  iOSTestMarvel
//
//  Created by Fernanda de Lima on 14/09/2018.
//  Copyright © 2018 FeLima. All rights reserved.
//

import Foundation
import RealmSwift
import Realm

class Result: Decodable{
    var code:Int = 0
    var data:Infos = Infos()
    
    convenience init( code:Int, data:Infos) {
        self.init()
        self.code = code
        self.data = data
    }
    
    convenience required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ResultsCodingKeys.self)
        let code = try container.decode(Int.self, forKey: .code)
        let data = try container.decode(Infos.self, forKey: .data)
        self.init(code: code, data: data)
    }
    
}

class Infos: Decodable{
    var total:Int = 0
    var results = List<Comics>()
    
    convenience init( total:Int, results:List<Comics>) {
        self.init()
        self.total = total
        self.results = results
    }
    
    convenience required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ResultsCodingKeys.self)
        let total = try container.decode(Int.self, forKey: .total)
        let resultsArray = try container.decode([Comics].self, forKey: .results)
        let resultsList = List<Comics>()
        resultsList.append(objectsIn: resultsArray)
        self.init(total: total, results: resultsList)
    }
    
    
}

enum ResultsCodingKeys:String,CodingKey{
    case code
    case data
    case total
    case results

}
