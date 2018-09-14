//
//  ViewController.swift
//  iOSTestMarvel
//
//  Created by Fernanda de Lima on 12/09/2018.
//  Copyright © 2018 FeLima. All rights reserved.
//

import UIKit

private let reuseIdentifier = "ComicCell"

class HomeViewController: UIViewController {
    
    @IBOutlet weak var comicsCollectionVew: UICollectionView!
    
    fileprivate let itemSpacing:CGFloat = 10
    fileprivate var thumbnailSize:CGSize = CGSize.zero
    
    var start = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        comicsCollectionVew.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        loadCollection()
    }
    
    private func loadCollection(){
        start += API.page * 20
        
        API.get(Result.self, endpoint: .comics(start), success: { (data) in
            print(data)
            
            localMan.allComics.append(contentsOf: data.data.results)
            API.page += 1
            DispatchQueue.main.async {
                self.comicsCollectionVew.reloadData()
            }
        }) { (error) in
            print(error.localizedDescription)
        }
    }

}

extension HomeViewController : UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return localMan.allComics.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ComicCell
        cell.titleLabel.text = localMan.allComics[indexPath.row].title
        cell.dateLabel.text = localMan.allComics[indexPath.row].dates[0].date
        
        let imagePath = "\(localMan.allComics[indexPath.row].thumbnail?.path).\(localMan.allComics[indexPath.row].thumbnail?.ext)"
        
        if let url = URL(string: imagePath){
            let data = try? Data(contentsOf:url)
            cell.comicImageView.image = UIImage(data: data!)
        }
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //print("Called collectionView collectionViewLayout sizeForItemAt")
        // Calculate thumbnail size based on device
        if traitCollection.userInterfaceIdiom == .pad {
            //print("iPad")
            if UIDevice.current.orientation.isLandscape {
                thumbnailSize.width = floor((collectionView.frame.size.width - itemSpacing * 5) / 4)
            } else {
                thumbnailSize.width = floor((collectionView.frame.size.width - itemSpacing * 4) / 3)
            }
        } else if traitCollection.userInterfaceIdiom == .phone {
            //print("iPhone")
            thumbnailSize.width = floor((collectionView.frame.size.width - itemSpacing * 3) / 2)
        }
        thumbnailSize.height = thumbnailSize.width * 1.15
        return thumbnailSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        //print("Called collectionView collectionViewLayout insetForSectionAt")
        return UIEdgeInsets(top: itemSpacing, left: itemSpacing, bottom: itemSpacing, right: itemSpacing)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detail = storyboard?.instantiateViewController(withIdentifier: "detailsViewController") as! DetailsViewController
        detail.index = indexPath.row
        self.navigationController?.pushViewController(detail, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if (indexPath.row == localMan.allComics.count - 1 ) { //it's your last cell
            if API.maxPages(){
                loadCollection()
            }
        }
    }
}
