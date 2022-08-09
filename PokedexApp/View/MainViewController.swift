//
//  MainViewController.swift
//  PokedexApp
//
//  Created by Mert Şafaktepe on 5.07.2022.
//

import UIKit
import Kingfisher

class MainViewController: UIViewController, UISearchBarDelegate {

    //MARK: - Variables and Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    let customCellId                 = "PokeCell"
    let leftRightPadding             = 15.0
    let searchController             = UISearchController(searchResultsController: nil)
    var mainViewModel                : MainViewModel = MainViewModel()
    var filteredList                 : [Pokemon]!
    var pokemonId: String = ""
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSearchBar()
        configureCollectionView()
        filteredList    = mainViewModel.pokemonList
        title           = "Pokedex"
        navigationController?.navigationBar.prefersLargeTitles = true


    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
        if #available(iOS 13.0, *) {
            searchController.searchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: "Enter Search Here", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
        } else {
            // Fallback on earlier versions
        }

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
    
    func configureSearchBar() {
        navigationItem.searchController                   = searchController
        navigationItem.hidesSearchBarWhenScrolling        = false
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.delegate               = self

    }
}

    //MARK: - CollectionView Extensions

extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        filteredList.count
    }
    
    
    //MARK: CellForItemAt
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell                    = collectionView.dequeueReusableCell(withReuseIdentifier: customCellId, for: indexPath) as! PokeCell
        let chosedPokemon           = filteredList[indexPath.item]
        cell.cellNameLabel.text     = chosedPokemon.name
        
        mainViewModel.getIdFromUrl(url: chosedPokemon.url) { resultId in
        self.pokemonId = resultId!
        }
        var imageUrl                = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(pokemonId).png"
        cell.cellImageView.kf.setImage(with: URL(string: imageUrl))
        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        <#code#>
//    }
    
    
        //MARK:  didSelectItemAt
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
//        let currentData                   = mainViewModel.pokemonList[indexPath.row]
        let detailVC                      = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController
//        detailVC?.viewModel.pokeId      = detailVC?.viewModel.getPokemonIndex(pokemon: currentData)
        let chosedPokemon                 = filteredList[indexPath.item]
        mainViewModel.getIdFromUrl(url: chosedPokemon.url) { resultId in
        self.pokemonId = resultId!
        }
        detailVC?.viewModel.pokeId        =  Int(pokemonId)

        guard let detailViewController    = detailVC else { return }
        DispatchQueue.main.async {
//        detailViewController.pokeId       = self.mainViewModel.getPokemonIndex(pokemon: currentCell)
        }
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
    
    //MARK: - Search Bar
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredList = []
        if searchText == "" {
            filteredList = mainViewModel.pokemonList
        } else {
            for poke in mainViewModel.pokemonList {
                if poke.name.lowercased().contains(searchText.lowercased()) {
                    filteredList.append(poke)
                }
            }
        }
        self.collectionView.reloadData()
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
    
 
