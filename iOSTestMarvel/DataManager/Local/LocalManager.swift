//
//  LocalMangaer.swift
//  iOSTestMarvel
//
//  Created by Fernanda de Lima on 13/09/2018.
//  Copyright © 2018 FeLima. All rights reserved.
//

import Foundation
import RealmSwift

let localMan = LocalManager.instance

class LocalManager: NSObject {
    
    //Singleton struct
    static let instance = LocalManager()
    
    var allComics:[Comics]=[]
    
    let realm = try! Realm()
    lazy var comics: Results<Comics> = { self.realm.objects(Comics.self) }()
    
    //add new object on realm
    func addComic(comic: Comics){
        try! realm.write {
            self.realm.add(comic)
        }
        comics = realm.objects(Comics.self)
    }
    
    //delete object from
    func deleteComic(index: Int){
        try! realm.write {
            realm.delete(comics[index])
        }
        comics = realm.objects(Comics.self)
    }
    
    func isExistComic(comic:String) -> Bool{
        let predicate = NSPredicate(format: "name = %@", comic)
        let comicsRealm = realm.objects(Comics.self).filter(predicate)
        
        if comicsRealm.count > 0{
            return true
        }else{
            return false
        }
        
    }
    
}

