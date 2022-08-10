//
//  FavroritesViewController.swift
//  PokedexApp
//
//  Created by Mert Şafaktepe on 31.07.2022.
//

import UIKit
import VerticalCardSwiper

class FavoritesViewController: UIViewController, VerticalCardSwiperDatasource {
    func numberOfCards(verticalCardSwiperView: VerticalCardSwiperView) -> Int {
        return listOfBookmarks.count
    }
    
    func setImage(pokeId: Int) -> String {
        var imageUrl   = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(pokeId).png"
        return imageUrl
    }
    
   
       
    
    func cardForItemAt(verticalCardSwiperView: VerticalCardSwiperView, cardForItemAt index: Int) -> CardCell {
        if let cardCell = verticalCardSwiperView.dequeueReusableCell(withReuseIdentifier: "SwipeCell", for:index) as? SwipeCell {
            cardCell.swCardImage.kf.setImage(with: URL(string: setImage(pokeId: listOfBookmarks[index].id)))
            cardCell.swIdLabel.text = String("#\(listOfBookmarks[index].id)")
            cardCell.swTitleLabel.text = listOfBookmarks[index].name
            return cardCell
        }
        return CardCell()
    }
    
 
    @IBOutlet weak var myTableView: UITableView!
    var onComplete: ( () -> Void )?
    let localDB = LocalDatabaseManager()
    var listOfBookmarks : [DetailPokemon] = []
    private var cardSwiper: VerticalCardSwiper!

    override func viewDidLoad() {
        super.viewDidLoad()
        setFavList()
        setGesture()
        setCardSwiper()
        cardSwiper.delegate = self
        cardSwiper.datasource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
         setFavList()
        cardSwiper.reloadData()
//         myTableView.reloadData()
    }
    func setFavList() {
         listOfBookmarks      = LocalDatabaseManager.getAllObjects
    }
    
    func setCardSwiper() {

        cardSwiper = VerticalCardSwiper(frame: view.frame)
        view.addSubview(cardSwiper)
        cardSwiper.firstItemTransform = 0.2
        cardSwiper.topInset = 120
        cardSwiper.datasource = self
        cardSwiper.register(nib: UINib(nibName: "SwipeCell", bundle: nil), forCellWithReuseIdentifier: "SwipeCell")
    }
   
    func setGesture() {
        let gesture            = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
        cardSwiper?.addGestureRecognizer(gesture)
    }
    
    
    
    
    @objc func handleLongPress(gesture: UILongPressGestureRecognizer) {
        let location                 = gesture.location(in: cardSwiper)
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

extension FavoritesViewController: VerticalCardSwiperDelegate {
    func sizeForItem(verticalCardSwiperView: VerticalCardSwiperView, index: Int) -> CGSize {
        return CGSize(width: verticalCardSwiperView.frame.width * 0.75, height: verticalCardSwiperView.frame.height * 0.75)

    }
}
