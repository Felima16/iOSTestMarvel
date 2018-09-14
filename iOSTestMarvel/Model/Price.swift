//
//  Price.swift
//  iOSTestMarvel
//
//  Created by Fernanda de Lima on 14/09/18.
//  Copyright © 2018 FeLima. All rights reserved.
//

import Foundation

import RealmSwift
import Realm

class Prices: Object, Decodable{
    @objc dynamic var type:String = ""
    @objc dynamic var price:Double = 0
    
    private enum PricesCodingKeys:String,CodingKey{
        case type
        case price
    }
    
    convenience init(type:String, price:Double) {
        self.init()
        self.type = type
        self.price = price
    }
    
    convenience required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: PricesCodingKeys.self)
        let type = try container.decode(String.self, forKey: .type)
        let price = try container.decode(Double.self, forKey: .price)
        self.init(type: type, price: price)
    }
    
    required init() {
        super.init()
    }
    
    required init(value: Any, schema: RLMSchema) {
        super.init(value: value, schema: schema)
    }
    
    required init(realm: RLMRealm, schema: RLMObjectSchema) {
        super.init(realm: realm, schema: schema)
    }
}
