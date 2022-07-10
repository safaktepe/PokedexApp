//
//  MainViewController.swift
//  PokedexApp
//
//  Created by Mert Şafaktepe on 5.07.2022.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    let customCellId =  "PokeCell"
    let leftRightPadding = 15.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        let nibCell = UINib(nibName: customCellId, bundle: nil)
        collectionView.register(nibCell, forCellWithReuseIdentifier: customCellId)
        collectionView.delegate = self
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        let flow = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        flow.sectionInset = UIEdgeInsets(top: 20, left: leftRightPadding, bottom: 0, right: leftRightPadding)

        
    }
}

extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dummies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: customCellId, for: indexPath) as! PokeCell
        cell.setup(with: dummies[indexPath.row])
        return cell
        
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
