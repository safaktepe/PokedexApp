//
//  MainViewController.swift
//  PokedexApp
//
//  Created by Mert Şafaktepe on 5.07.2022.
//

import UIKit
import Kingfisher

class MainViewController: UIViewController {

    //MARK: - Variables and Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    let customCellId                 =  "PokeCell"
    let leftRightPadding             = 15.0
    var mainViewModel                : MainViewModel = MainViewModel()
    
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        title = "Pokedex"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    //MARK: - Configuration for CollectionView
    func configureCollectionView() {
        
        collectionView.dataSource                = self
        collectionView.delegate                  = self
        let nibCell                              = UINib(nibName: customCellId, bundle: nil)
        collectionView.register(nibCell, forCellWithReuseIdentifier: customCellId)
        collectionView.collectionViewLayout      = UICollectionViewFlowLayout()
        let flow                                 = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        flow.sectionInset                        = UIEdgeInsets(top: 20, left: leftRightPadding, bottom: 0, right: leftRightPadding)
    }
    
}

    //MARK: - CollectionView Extensions

extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        mainViewModel.pokemonList.count
    }
    
    
    //MARK: CellForItemAt
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell                    = collectionView.dequeueReusableCell(withReuseIdentifier: customCellId, for: indexPath) as! PokeCell
        let chosedPokemon           = mainViewModel.pokemonList[indexPath.item]
        cell.cellNameLabel.text     = chosedPokemon.name
        var imageUrl                = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(indexPath.item + 1).png"
        cell.cellImageView.kf.setImage(with: URL(string: imageUrl))
        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        <#code#>
//    }
    
    
        //MARK:  didSelectItemAt
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
        let currentData                   = mainViewModel.pokemonList[indexPath.row]
        let detailVC                      = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController
//        detailVC?.viewModel.pokeId      = detailVC?.viewModel.getPokemonIndex(pokemon: currentData)
        detailVC?.viewModel.pokeId        =  (indexPath.row + 1)

        guard let detailViewController    = detailVC else { return }
        DispatchQueue.main.async {
//        detailViewController.pokeId       = self.mainViewModel.getPokemonIndex(pokemon: currentCell)
        }
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
}



        //MARK: Size of cells
extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let screenSize                     = UIScreen.main.bounds
        let screenWidth                    = screenSize.width
        let screenHeight                   = screenSize.height
        
        return CGSize(width: (screenWidth - (3 * leftRightPadding)) / 2, height: screenHeight / 4)
    }
}
    
