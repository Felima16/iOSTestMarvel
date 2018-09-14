//
//  Comics.swift
//  iOSTestMarvel
//
//  Created by Fernanda de Lima on 13/09/2018.
//  Copyright © 2018 FeLima. All rights reserved.
//

import Foundation
import RealmSwift
import Realm

class Comics: Object, Decodable{
    @objc dynamic var title:String = ""
    @objc dynamic var thumbnail:Thumbnail?
    @objc dynamic var desc:String?
    var dates = List<Dates>()
    var prices = List<Prices>()
    @objc dynamic var creators:Creators?
    @objc dynamic var characters:Characters?
    
    enum CodingKeys:String,CodingKey{
        case description //= "description"
        case title
        case thumbnail
        case dates
        case prices
        case creators
        case characters
    }
    
    convenience init(title:String, thumbnail:Thumbnail, desc:String?, dates: List<Dates>, prices: List<Prices>,creators:Creators, characters:Characters) {
        self.init()
        self.title = title
        self.thumbnail = thumbnail
        self.desc = desc
        self.dates = dates
        self.prices = prices
        self.creators = creators
        self.characters = characters
    }
    
    convenience required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let title = try container.decode(String.self, forKey: .title)
        let thumbnail = try container.decode(Thumbnail.self, forKey: .thumbnail)
        let desc = try? container.decode(String.self, forKey: .description)
        let creators = try container.decode(Creators.self, forKey: .creators)
        let characters = try container.decode(Characters.self, forKey: .characters)
        let datesArray = try container.decode([Dates].self, forKey: .dates)
        let pricesArray = try container.decode([Prices].self, forKey: .prices)
        
        let datesList = List<Dates>()
        datesList.append(objectsIn: datesArray)
        
        let pricesList = List<Prices>()
        pricesList.append(objectsIn: pricesArray)
        
        self.init(title: title, thumbnail: thumbnail, desc: desc, dates: datesList, prices: pricesList, creators: creators, characters: characters)

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

class Thumbnail: Object, Codable{
    @objc dynamic var path:String = ""
    @objc dynamic var ext:String = ""
    
    private enum ThumbnailCodingKeys:String,CodingKey{
        case ext = "extension"
        case path = "path"
    }
}

class Dates: Object, Codable{
    @objc dynamic var type:String = ""
    @objc dynamic var date:String = ""
}

class Prices: Object, Codable{
    @objc dynamic var type:String = ""
    @objc dynamic var price:Int = 0
}

class Item: Object, Codable{
    @objc dynamic var name:String = ""
}

enum ItemCodingKeys: String, CodingKey {
    case items
}
