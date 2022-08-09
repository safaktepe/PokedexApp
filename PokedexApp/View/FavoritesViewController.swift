//
//  FavroritesViewController.swift
//  PokedexApp
//
//  Created by Mert Şafaktepe on 31.07.2022.
//

import UIKit

class FavoritesViewController: UIViewController {
 
    @IBOutlet weak var myTableView: UITableView!
    var onComplete: ( () -> Void )?
    let localDB = LocalDatabaseManager()
    var listOfBookmarks : [DetailPokemon] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setFavList()
                
//      var lists : [DetailPokemon] = LocalDatabaseManager.getAllObjects
        myTableView.delegate    = self
        myTableView.dataSource  = self
        self.myTableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setFavList()
    }
    func setFavList() {
         listOfBookmarks = LocalDatabaseManager.getAllObjects
    }
}


extension FavoritesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfBookmarks.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell                  =  myTableView.dequeueReusableCell(withIdentifier: "cell") as! TableViewCell
        cell.favNameLabel.text    = listOfBookmarks[indexPath.row].name
        cell.favIdLabel.text      = String(listOfBookmarks[indexPath.row].id) 
//        cell.favImageView.image   = UIImage(named: "bulbasaur")
        cell.favImageView.kf.setImage(with: URL(string: setImage(pokeId: listOfBookmarks[indexPath.row].id)))
        return cell
    }
    
    func setImage(pokeId: Int) -> String {
        var imageUrl   = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(pokeId).png" 
        return imageUrl
    }
    
}
