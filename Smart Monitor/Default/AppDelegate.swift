//
//  AppDelegate.swift
//  Smart Monitor
//
//  Created by Dhanraj Kawade on 09/10/20.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().tintColor = Colors.white
        UINavigationBar.appearance().barTintColor = Colors.black
        UINavigationBar.appearance().backgroundColor = Colors.black
        UINavigationBar.appearance().titleTextAttributes = titleTextAttributes(with: .white, and: 17)
        
        return true
    }
}

// MARK: - Helper Methods
extension AppDelegate {
    func titleTextAttributes(with color: UIColor, and fontSize: CGFloat) -> [NSAttributedString.Key: Any]? {
        return [
            NSAttributedString.Key.foregroundColor: color,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: fontSize, weight: .semibold)
        ]
    }
}
