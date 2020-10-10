//
//  CharacterDetailsTableViewCell.swift
//  Smart Monitor
//
//  Created by Dhanraj Kawade on 10/10/20.
//

import UIKit

/// Class to display listing of character details
class CharacterDetailsTableViewCell: UITableViewCell {

    // MARK:- IB Outlet
    @IBOutlet weak var viwBack: UIView!
    @IBOutlet weak var lblInfo: UILabel!
    @IBOutlet weak var imgViwNext: UIImageView!
    
    // MARK:- Configure cell

    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.viwBack.layer.cornerRadius = 10.0
        self.viwBack.addShadow(offset: CGSize(width: 1.0, height: 1.0), color: Colors.red, radius: 5, opacity: 0.3)
    }

    // MARK:- IB Outlet
    
    /// Set Character details data
    /// - Parameter info: information
    func setData(info:String?) {
        
        self.lblInfo.text = info
    }
}
