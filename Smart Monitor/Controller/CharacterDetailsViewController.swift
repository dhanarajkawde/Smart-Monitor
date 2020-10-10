//
//  CharacterDetailsViewController.swift
//  Smart Monitor
//
//  Created by Dhanraj Kawade on 09/10/20.
//

import UIKit

/// Class to display character details
class CharacterDetailsViewController: UIViewController {

    // MARK:- IB Outlets
    @IBOutlet weak var imgViwTop: UIImageView!
    @IBOutlet weak var tblInfo: UITableView!
    
    // MARK:- Variavle Declaration
    var objCharacter:CharacterResult?
    
    // MARK:- View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tblInfo.register(UINib(nibName: Identifiers.CharacterDetailsTableViewCell, bundle: .main), forCellReuseIdentifier: Identifiers.CharacterDetailsTableViewCell)
        self.imgViwTop.download(image: self.objCharacter?.thumbnail?.url)
        
        tblInfo.tableHeaderView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 0.0, height: Double.leastNormalMagnitude))
        self.title = self.objCharacter?.name
    }
}

// MARK:- UITableViewDelegate, UITableViewDataSource
extension CharacterDetailsViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 7
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 { // name
            return 1
        }
        else if section == 1 { // Description
            return 1
        }
        else if section == 2 { // Comics
            return self.objCharacter?.comics?.items?.count ?? 0
        }
        else if section == 3 { // Series
            return self.objCharacter?.series?.items?.count ?? 0
        }
        else if section == 4 { // Stories
            return self.objCharacter?.stories?.items?.count ?? 0
        }
        else if section == 5 { // Events
            return self.objCharacter?.events?.items?.count ?? 0
        }
        else { // Other
            return self.objCharacter?.urls?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let characterDetailsTableViewCell:CharacterDetailsTableViewCell = self.tblInfo.dequeueReusableCell(withIdentifier: Identifiers.CharacterDetailsTableViewCell, for: indexPath) as! CharacterDetailsTableViewCell
        
        if indexPath.section == 0 { // Name
            
            characterDetailsTableViewCell.setData(info: self.objCharacter?.name ?? "")
            characterDetailsTableViewCell.imgViwNext.isHidden = true
        }
        else if indexPath.section == 1 { // Description
            characterDetailsTableViewCell.setData(info: self.objCharacter?.description ?? "")
            characterDetailsTableViewCell.imgViwNext.isHidden = true
        }
        else if indexPath.section == 2 { // Comics
            characterDetailsTableViewCell.setData(info: self.objCharacter?.comics?.items?[indexPath.row].name ?? "")
            characterDetailsTableViewCell.imgViwNext.isHidden = true
        }
        else if indexPath.section == 3 { // Series
            characterDetailsTableViewCell.setData(info: self.objCharacter?.series?.items?[indexPath.row].name ?? "")
            characterDetailsTableViewCell.imgViwNext.isHidden = true
        }
        else if indexPath.section == 4 { // Stories
            characterDetailsTableViewCell.setData(info: self.objCharacter?.stories?.items?[indexPath.row].name ?? "")
            characterDetailsTableViewCell.imgViwNext.isHidden = true
        }
        else if indexPath.section == 5 { // Events
            characterDetailsTableViewCell.setData(info: self.objCharacter?.events?.items?[indexPath.row].name ?? "")
            characterDetailsTableViewCell.imgViwNext.isHidden = true
        }
        else { // Other
            characterDetailsTableViewCell.setData(info: self.objCharacter?.urls?[indexPath.row].type?.capitalized ?? "")
            characterDetailsTableViewCell.imgViwNext.isHidden = false
        }
        
        return characterDetailsTableViewCell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let viw = UIView(frame: CGRect(x: 0, y: 0, width: self.tblInfo.frame.size.width, height: 40))
        viw.backgroundColor = UIColor.white
        let lbl = UILabel(frame: CGRect(x: 15, y: 20, width: self.tblInfo.frame.size.width, height: 20))
        lbl.font = UIFont.boldSystemFont(ofSize: 16)
        viw.addSubview(lbl)
        
        if section == 0 {
            lbl.text = Localizable.Name
        }
        else if section == 1 {
            lbl.text = Localizable.Description
        }
        else if section == 2 {
            lbl.text = Localizable.Comics
        }
        else if section == 3 {
            lbl.text = Localizable.Series
        }
        else if section == 4 {
            lbl.text = Localizable.Stories
        }
        else if section == 5 {
            lbl.text = Localizable.Events
        }
        else {
            lbl.text = Localizable.Other
        }
        
        return viw
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 40
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 6 { // Other
            guard let url = URL(string: self.objCharacter?.urls?[indexPath.row].url ?? "") else { return }
            UIApplication.shared.open(url)
        }
    }
}
