//
//  MainViewController.swift
//  PokedexApp
//
//  Created by Mert Şafaktepe on 5.07.2022.
//

import UIKit
import Kingfisher

class MainViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    let customCellId =  "PokeCell"
    let leftRightPadding = 15.0
    var chosenPoke: Pokemon?
    
    let detailVC = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        collectionView.dataSource = self
        let nibCell = UINib(nibName: customCellId, bundle: nil)
        collectionView.register(nibCell, forCellWithReuseIdentifier: customCellId)
        collectionView.delegate = self
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        let flow = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        flow.sectionInset = UIEdgeInsets(top: 20, left: leftRightPadding, bottom: 0, right: leftRightPadding)
        
        fetchData()
        getDetails()
    }
    
    func getDetails() {
        Webservice().getSelectedPokemonData(url: "https://pokeapi.co/api/v2/pokemon/1/") { selectedPokemon, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
        }
    }
    
    func fetchData() {
         Webservice().getData { pokemonData, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
             DispatchQueue.main.async {
                 self.collectionView.reloadData()
             }
             print(pokemonData?.results.count)
             self.chosenPoke = pokemonData
        }
   }
        
    
    
}
        
extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        20
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: customCellId, for: indexPath) as! PokeCell
        let chosedPokemon = (chosenPoke?.results[indexPath.item])
        //cell.setup(with: chosedPokemon)
        cell.cellNameLabel.text = chosedPokemon?.name
        cell.cellImageView.kf.setImage(with: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png"))
        
        //(with: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png")
        
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let app = chosenPoke?.results[indexPath.item]
        print(app?.name)
        detailVC?.pokeNameLabel?.text = app?.name
        guard let detailViewController = detailVC else { return }
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        return CGSize(width: (screenWidth - (3 * leftRightPadding)) / 2, height: screenHeight / 3)
    }
}
