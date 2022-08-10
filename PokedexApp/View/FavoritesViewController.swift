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
        setGesture()
//      var lists : [DetailPokemon] = LocalDatabaseManager.getAllObjects
        myTableView.delegate    = self
        myTableView.dataSource  = self
        self.myTableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
    }
    
    override func viewDidAppear(_ animated: Bool) {
         setFavList()
         myTableView.reloadData()
    }
    func setFavList() {
         listOfBookmarks      = LocalDatabaseManager.getAllObjects
    }
    
    func setGesture() {
        let gesture            = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
        myTableView.addGestureRecognizer(gesture)
    }
    
    @objc func handleLongPress(gesture: UILongPressGestureRecognizer) {
        let location                 = gesture.location(in: myTableView)
        guard let selectedIndex      = myTableView.indexPathForRow(at: location) else { return }
        print(selectedIndex.row)
        let alertController = UIAlertController(title: "Remove Pokemon?", message: nil, preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { _ in
            self.listOfBookmarks.remove(at: selectedIndex.item)
            self.myTableView.deleteRows(at: [selectedIndex], with: .fade)
            LocalDatabaseManager.saveAllObjects(allObjects: self.listOfBookmarks)
        }))
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alertController, animated: true)
        
        
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
        let cell                  = myTableView.dequeueReusableCell(withIdentifier: "cell") as! TableViewCell
        cell.favNameLabel.text    = listOfBookmarks[indexPath.row].name
        cell.favIdLabel.text      = String("#\(listOfBookmarks[indexPath.row].id)")
//        cell.favImageView.image   = UIImage(named: "bulbasaur")
        cell.favImageView.kf.setImage(with: URL(string: setImage(pokeId: listOfBookmarks[indexPath.row].id)))
        return cell
    }
    
    func setImage(pokeId: Int) -> String {
        var imageUrl   = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(pokeId).png" 
        return imageUrl
    }
    
}
