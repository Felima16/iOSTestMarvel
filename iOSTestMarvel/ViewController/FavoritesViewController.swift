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
    
    
}
