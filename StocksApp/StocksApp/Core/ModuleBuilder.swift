//
//  Tabbar.swift
//  StocksApp
//
//  Created by Abdurahim on 09.06.2022.
//

import Foundation
import UIKit

final class ModuleBuilder {
    private init() {}
    
    static let shared: ModuleBuilder = .init()
    
    private lazy var network: NetworkService = {
        Network()
    }()
    
    private func networkService() -> NetworkService {
        network
    }
    
    private func stocksService() -> StocksServiceProtocol {
        StocksService(client: network)
    }
    
    private func stocksModule() -> UIViewController {
        let presenter = StocksPresenter(service: stocksService())
        let view = StocksViewController(presenter: presenter)
        presenter.view = view
        
        return view
    }
    
    public func tabbarController() -> UIViewController {
        let tabbar = UITabBarController()
        
        let firstVC = UINavigationController(rootViewController: stocksModule())
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

class MockService: StocksServiceProtocol {
    func getStocks(currency: String, count: String, completion: @escaping (Result<[Stock], NetworkError>) -> Void) {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            completion(.failure(.taskError))
        }
    }
}
