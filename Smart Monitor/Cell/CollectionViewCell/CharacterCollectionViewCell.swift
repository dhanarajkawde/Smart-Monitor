//
//  CharacterCollectionViewCell.swift
//  Smart Monitor
//
//  Created by Dhanraj Kawade on 10/10/20.
//

import UIKit

// class to show charaters related to selected comic
class CharacterCollectionViewCell: UICollectionViewCell {

    // MARK:- IB Outlet
    @IBOutlet weak var viwBack: UIView!
    @IBOutlet weak var imgViwCharacter: UIImageView!
    @IBOutlet weak var viwName: UIView!
    @IBOutlet weak var lblName: UILabel!
    
    // MARK:- Configure cell
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.imgViwCharacter.layer.cornerRadius = 10
        self.viwName.layer.cornerRadius = 10
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        self.imgViwCharacter.image = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.viwBack.layer.cornerRadius = 10.0
        self.viwBack.addShadow(offset: CGSize(width: 1.0, height: 1.0), color: Colors.red, radius: 5, opacity: 0.4)
    }

    // MARK:- Custom Method
    
    /// Set character data
    /// - Parameter characterData: characterData description
    func setData(characterData:CharacterResult?) {
        
        self.lblName.text = characterData?.name ?? ""
        self.imgViwCharacter.download(image: characterData?.thumbnail?.url)
    }
}
