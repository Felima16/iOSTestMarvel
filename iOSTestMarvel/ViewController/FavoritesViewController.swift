//
//  FavoritesViewController.swift
//  iOSTestMarvel
//
//  Created by Fernanda de Lima on 14/09/18.
//  Copyright © 2018 FeLima. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    @IBOutlet weak var favoritesTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        favoritesTableView.reloadData()
    }

}

extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return localMan.comics.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favComicCell") as! FavCell
        cell.nameLabel.text = localMan.comics[indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detail = storyboard?.instantiateViewController(withIdentifier: "detailsViewController") as! DetailsViewController
        
        detail.comic = localMan.comics[indexPath.row]
        self.navigationController?.pushViewController(detail, animated: true)
    }
    
    
}
