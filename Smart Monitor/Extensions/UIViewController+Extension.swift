//
//  UIViewController+Extension.swift
//  Smart Monitor
//
//  Created by Dhanraj Kawade on 10/10/20.
//

import UIKit
import JGProgressHUD

// Common extension of UIViewController
extension UIViewController {
    
    static let hud = JGProgressHUD(style: .extraLight)
    
    /// Show progress bar
    /// - Parameter msg: message
    func showProgress(msg:String) {
        
        UIViewController.hud.textLabel.text = msg
        UIViewController.hud.show(in: self.view)
    }
    
    /// stop progress bar
    func stopProgress() {
        
        UIViewController.hud.dismiss()
    }
}
