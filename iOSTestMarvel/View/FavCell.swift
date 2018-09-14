//
//  FavCell.swift
//  iOSTestMarvel
//
//  Created by Fernanda de Lima on 14/09/2018.
//  Copyright © 2018 FeLima. All rights reserved.
//

import UIKit

class FavCell: UITableViewCell {

    //IBOutlet
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    //IBAction
    @IBAction func favoriteActionButton(_ sender: Any) {
        if localMan.isExistComic(comic: nameLabel.text!){
            let predicate = NSPredicate(format: "name = %@", nameLabel.text!)
            let index = localMan.comics.index(matching: predicate)
            localMan.deleteComic(index: index!)
            favoriteButton.setImage(#imageLiteral(resourceName: "starIconA"), for: .normal)
        }else{
            let button = sender as! UIButton
            let comicRealm = localMan.allComics[button.tag]
            localMan.addComic(comic: comicRealm)
            favoriteButton.setImage(#imageLiteral(resourceName: "starIconB"), for: .normal)
        }
    }


}
