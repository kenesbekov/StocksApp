//
//  Assembly.swift
//  StocksApp
//
//  Created by Abdurahim on 09.06.2022.
//

import Foundation
import UIKit

final class Assembly {
    static let assembler: Assembly = .init()
    let favoritesService: FavoritesServiceProtocol = FavoritesLocalService()
    
    private init() {}
    
    private lazy var network: NetworkService = Network()
    private lazy var stocksService: StocksServiceProtocol = StocksService(network: network)
    private lazy var chartsService: ChartsServiceProtocol = ChartsService(network: network)
    
    private func stocksModule() -> UIViewController {
        let presenter = StocksPresenter(service: stocksService)
        let view = StocksViewController(presenter: presenter)
        presenter.view = view
        
        return view
    }
    
    public func detailModule(model: StockModelProtocol) -> UIViewController {
        let presenter = StockDetailPresenter(model: model, service: chartsService)
        let view = StockDetailViewController(presenter: presenter)
        presenter.view = view
        
        return view
    }
    
    public func favoritesModule() -> UIViewController {
        let presenter = StockFavoritesPresenter(service: stocksService)
        let view = StockFavoritesViewController(presenter: presenter)
        presenter.view = view
        
        return view
    }
    
    public func tabbarController() -> UIViewController {
        let tabbar = UITabBarController()
        
        let firstVC = UINavigationController(rootViewController: stocksModule())
        firstVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "stocks-bar"), tag: 0)
        
        let secondVC = UINavigationController(rootViewController: favoritesModule())
        secondVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "favorites-bar"), tag: 1)
        
        let thirdVC = UIViewController()
        thirdVC.view.backgroundColor = .white
        thirdVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "search-bar"), tag: 2)
        
        tabbar.viewControllers = [firstVC, secondVC, thirdVC]
        
        return tabbar
    }
}
