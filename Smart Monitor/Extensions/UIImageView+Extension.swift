//
//  UIImageView+Extension.swift
//  Smart Monitor
//
//  Created by Dhanraj Kawade on 10/10/20.
//

import UIKit
import Kingfisher

// Common extension of UIImageView
extension UIImageView {
    
    /// Download Image
    /// - Parameter url: url to download
    func download(image url: URL?) {
        guard let url = url else { return }
        kf.indicatorType = .activity
        kf.setImage(with: url, placeholder: nil)
    }
}
