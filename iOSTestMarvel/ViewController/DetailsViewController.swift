//
//  DetailsViewController.swift
//  iOSTestMarvel
//
//  Created by Fernanda de Lima on 14/09/2018.
//  Copyright © 2018 FeLima. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var comicImageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var charactersLabel: UITextView!
    @IBOutlet weak var creatorsLabel: UITextView!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    @IBAction func favoriteActionButton(_ sender: Any) {
        if localMan.isExistComic(comic: nameLabel.text!){
            let predicate = NSPredicate(format: "title = %@", nameLabel.text!)
            let index = localMan.comics.index(matching: predicate)
            localMan.deleteComic(index: index!)
            favoriteButton.setImage(#imageLiteral(resourceName: "starIconA"), for: .normal)
        }else{
//            let button = sender as! UIButtonc
//            let comicRealm = localMan.allComics[button.tag]
            localMan.addComic(comic: comic)
            favoriteButton.setImage(#imageLiteral(resourceName: "starIconB"), for: .normal)
        }
    }
    
    var comic: Comics = Comics()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadInfos()
    }
    
    private func loadInfos(){
        nameLabel.text = comic.title
        
        let imagePath = "\(comic.thumbnail?.path ?? "").\(comic.thumbnail?.ext ?? "")"
        if let url = URL(string: imagePath){
            let data = try? Data(contentsOf:url)
            comicImageView.image = UIImage(data: data!)
        }
        
        descriptionTextView.text = comic.desc
        
        let date = Utils.convertStringToDate(date: comic.dates[0].date)
        dateLabel.text = "Publicação \(date.toMediumDateString())"
        
        priceLabel.text = "Preço: \(comic.prices.first?.price ?? 0.0)"
        
        var characters = ""
        for c in (comic.characters?.items)!{
            characters = characters == "" ?  "\(c.name)" : "\(characters), \(c.name)"
        }
        charactersLabel.text = "Personagens: \(characters)"
        
        var creators = ""
        for c in (comic.creators?.items)!{
            creators = creators == "" ?  "\(c.name)" : "\(creators), \(c.name)"
        }
        creatorsLabel.text = "Criadores: \(creators)"
        
        let image = localMan.isExistComic(comic: nameLabel.text!) ? #imageLiteral(resourceName: "starIconB") : #imageLiteral(resourceName: "starIconA")
        favoriteButton.setImage(image, for: .normal)
        
    }

}
