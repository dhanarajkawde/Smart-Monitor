//
//  ComicCharactersListViewController.swift
//  Smart Monitor
//
//  Created by Dhanraj Kawade on 09/10/20.
//

import UIKit

/// Class to display character list
class ComicCharactersListViewController: UIViewController {
    
    // MARK:- IB Outlets
    @IBOutlet weak var collectioViwCharacter: UICollectionView!
    @IBOutlet weak var imgViwNoData: UIImageView!
    
    // MARK:- Variavle Declaration
    var arrCharacters:[CharacterResult]?
    var comicId:String?
    var offSet = 0
    var limit = 20
    var total = 0
    
    // MARK:- View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectioViwCharacter.register(UINib(nibName: Identifiers.CharacterCollectionViewCell, bundle: .main), forCellWithReuseIdentifier: Identifiers.CharacterCollectionViewCell)
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: (self.view.frame.size.width / 2) - 10, height: 200)
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumInteritemSpacing = 0.0
        self.collectioViwCharacter.collectionViewLayout = flowLayout
        
        self.getComicCharactersList()
        
        self.title = Localizable.Characters
    }
    
    // MARK:- API Call
    
    /// Get Character List
    func getComicCharactersList() {
        
        DispatchQueue.main.async {
            self.showProgress(msg: "")
        }
        
        ComicViewModel.sharedInstance.getComicCharactersListAPI(offSet: self.offSet, limit: self.limit, comicId: self.comicId) { (result, response) in
            
            DispatchQueue.main.async {
                self.stopProgress()
            }
            
            self.total = result?.data?.total ?? 0
            
            if self.total == 0 {
                DispatchQueue.main.async {
                    self.imgViwNoData.isHidden = false
                }
                return
            }
            
            if self.offSet == 0 {
                self.arrCharacters = result?.data?.results
            }
            else {
                self.arrCharacters?.append(contentsOf: (result?.data?.results)!)
            }
            
            DispatchQueue.main.async {
                
                self.collectioViwCharacter.reloadData()
            }
        }
    }
}

// MARK:- UICollectionViewDelegate, UICollectionViewDataSource
extension ComicCharactersListViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.arrCharacters?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let characterCollectionViewCell:CharacterCollectionViewCell = self.collectioViwCharacter.dequeueReusableCell(withReuseIdentifier: Identifiers.CharacterCollectionViewCell, for: indexPath) as! CharacterCollectionViewCell
        
        characterCollectionViewCell.setData(characterData: self.arrCharacters?[indexPath.row])
        
        return characterCollectionViewCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: Identifiers.Main, bundle: nil)
        let characterDetailsViewController:CharacterDetailsViewController = storyboard.instantiateViewController(withIdentifier: Identifiers.CharacterDetailsViewController) as! CharacterDetailsViewController
        
        characterDetailsViewController.objCharacter = self.arrCharacters?[indexPath.row]
        
        self.navigationController?.pushViewController(characterDetailsViewController, animated: true)
    }
}
