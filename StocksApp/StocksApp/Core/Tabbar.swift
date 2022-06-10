//
//  Tabbar.swift
//  StocksApp
//
//  Created by Abdurahim on 09.06.2022.
//

import Foundation
import UIKit

final class Tabbar {
    private init() {}
    
    static let shared: Tabbar = .init()
    
    public func tabbarController() -> UIViewController {
        let tabbar = UITabBarController()
        
        let firstVC = UINavigationController(rootViewController: StocksViewController())
        firstVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "stocks-bar"), tag: 0)
        
        let secondVC = UIViewController()
        secondVC.view.backgroundColor = .white
        secondVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "favorites-bar"), tag: 1)
        
        let thirdVC = UIViewController()
        thirdVC.view.backgroundColor = .white
        thirdVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "search-bar"), tag: 2)
        
        tabbar.viewControllers = [firstVC, secondVC, thirdVC]
        
        return tabbar
    }
}
