//
//  Dates.swift
//  iOSTestMarvel
//
//  Created by Fernanda de Lima on 14/09/18.
//  Copyright © 2018 FeLima. All rights reserved.
//

import Foundation
import RealmSwift
import Realm

class Dates: Object, Decodable{
    @objc dynamic var type:String = ""
    @objc dynamic var date:String = ""
    
    private enum DatesCodingKeys:String,CodingKey{
        case type
        case date
    }
    
    convenience init(type:String, date:String) {
        self.init()
        self.type = type
        self.date = date
    }
    
    convenience required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: DatesCodingKeys.self)
        let type = try container.decode(String.self, forKey: .type)
        let date = try container.decode(String.self, forKey: .date)
        self.init(type: type, date: date)
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
