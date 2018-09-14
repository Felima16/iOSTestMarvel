//
//  Creators.swift
//  iOSTestMarvel
//
//  Created by Fernanda de Lima on 14/09/2018.
//  Copyright © 2018 FeLima. All rights reserved.
//

import Foundation
import RealmSwift
import Realm

class Creators: Object, Decodable{
    //    @objc dynamic var items:[Item] = [Item]()
    var items = List<Item>()
    
    convenience init( items: List<Item>) {
        self.init()
        self.items = items
    }
    
    convenience required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ItemCodingKeys.self)
        let itemsArray = try container.decode([Item].self, forKey: .items)
        let itemsList = List<Item>()
        itemsList.append(objectsIn: itemsArray)
        self.init(items: itemsList)
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
