//
//  ComicListViewController.swift
//  Smart Monitor
//
//  Created by Dhanraj Kawade on 09/10/20.
//

import UIKit

/// Class to dispplay comic list
class ComicListViewController: UIViewController {

    // MARK:- IB Outlets
    @IBOutlet weak var tblComicList: UITableView!
    @IBOutlet weak var searchBarComic: UISearchBar!
    
    // MARK:- Variable declaration
    var arrComics:[ComicResult]?
    var offSet = 0
    var limit = 20
    var total = 0
    var isSearch = false
    
    // MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tblComicList.register(UINib(nibName: Identifiers.ComicTableViewCell, bundle: .main), forCellReuseIdentifier: Identifiers.ComicTableViewCell)
        self.title = Localizable.Comics
        
        self.getComicList()
    }
    
    // MARK:- API call
    
    /// Get comic list
    /// - Parameter isBegin: initial call
    func getComicList(isBegin:Bool = false) {
        
        DispatchQueue.main.async {
            if !isBegin { // not initial call
                self.showProgress(msg: "")
            }
        }
        
        ComicViewModel.sharedInstance.getComicListAPI(offSet: self.offSet, limit: self.limit, isSearch: self.isSearch, searchText: self.searchBarComic.text ?? "") { (result, response) in
            
            DispatchQueue.main.async {
                if !isBegin { // not initial call
                    self.stopProgress()
                }
            }
            
            self.total = result?.data?.total ?? 0
            
            if (result?.data?.results?.count ?? 0) == 0 { // if data empty
                return
            }
            
            if self.offSet == 0 { // initial call
                self.arrComics = result?.data?.results
            }
            else {
                self.arrComics?.append(contentsOf: (result?.data?.results)!)
            }
            
            DispatchQueue.main.async {
                
                self.tblComicList.reloadData()
            }
        }
    }
}

// MARK:- UITableViewDelegate, UITableViewDataSource
extension ComicListViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        self.arrComics?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let comicTableViewCell:ComicTableViewCell = self.tblComicList.dequeueReusableCell(withIdentifier: Identifiers.ComicTableViewCell, for: indexPath) as! ComicTableViewCell
        
        comicTableViewCell.setData(comicData: self.arrComics?[indexPath.row])
        
        if indexPath.row == (self.arrComics?.count ?? 0) - 1 { // last cell
            if self.total > (self.arrComics?.count ?? 0) { // check for all data fetched or not
                self.offSet += 20
                self.getComicList(isBegin: true)
            }
        }
        
        return comicTableViewCell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastSectionIndex = tableView.numberOfSections - 1
        let lastRowIndex = tableView.numberOfRows(inSection: lastSectionIndex) - 1
        if indexPath.section ==  lastSectionIndex && indexPath.row == lastRowIndex {
            let spinner = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
            spinner.startAnimating()
            spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))

            self.tblComicList.tableFooterView = spinner
            self.tblComicList.tableFooterView?.isHidden = false
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 244
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: Identifiers.Main, bundle: nil)
        let comicCharactersListViewController:ComicCharactersListViewController = storyboard.instantiateViewController(withIdentifier: Identifiers.ComicCharactersListViewController) as! ComicCharactersListViewController
        
        comicCharactersListViewController.comicId = String(self.arrComics?[indexPath.row].id ?? 0)
        
        self.navigationController?.pushViewController(comicCharactersListViewController, animated: true)
    }
}

// MARK:- UISearchBarDelegate
extension ComicListViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
        self.offSet = 0
        self.isSearch = true
        self.getComicList()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" { // if canceled or empty
            
            DispatchQueue.main.async {
                self.view.endEditing(true)
            }
            
            if self.isSearch { // if searched cancelled
                self.offSet = 0
                self.isSearch = false
                self.getComicList()
            }
        }
    }
}
