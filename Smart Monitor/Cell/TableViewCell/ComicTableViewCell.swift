//
//  ComicTableViewCell.swift
//  Smart Monitor
//
//  Created by Dhanraj Kawade on 10/10/20.
//

import UIKit

/// Class to display comic listing data
class ComicTableViewCell: UITableViewCell {

    // MARK:- IB Outlet
    @IBOutlet weak var viwBack: UIView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var imgViwComic: UIImageView!
    
    // MARK:- Configire Cell
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.imgViwComic.layer.cornerRadius = 10
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.imgViwComic.image = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.viwBack.layer.cornerRadius = 10.0
        self.viwBack.addShadow(offset: CGSize(width: 1.0, height: 1.0), color: Colors.red, radius: 10, opacity: 0.4)
    }

    // MARK:- Custom Methods
    
    /// Set data of comic
    /// - Parameter comicData: comic data
    func setData(comicData:ComicResult?) {
        
        self.lblName.text = comicData?.title ?? ""
        self.lblDescription.text = comicData?.description ?? ""
        self.imgViwComic.download(image: comicData?.thumbnail?.url)
    }
}
