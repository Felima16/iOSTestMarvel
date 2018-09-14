//
//  Thumbnail.swift
//  iOSTestMarvel
//
//  Created by Fernanda de Lima on 14/09/18.
//  Copyright © 2018 FeLima. All rights reserved.
//

import Foundation
import RealmSwift
import Realm

class Thumbnail: Object, Decodable{
    @objc dynamic var path:String = ""
    @objc dynamic var ext:String = ""
    
    private enum ThumbnailCodingKeys:String,CodingKey{
        case ext = "extension"
        case path = "path"
    }
    
    convenience init(path:String, ext:String) {
        self.init()
        self.path = path
        self.ext = ext
    }
    
    convenience required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ThumbnailCodingKeys.self)
        let path = try container.decode(String.self, forKey: .path)
        let ext = try container.decode(String.self, forKey: .ext)
        self.init(path: path, ext: ext)
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
