//
//  StockFavoritesPresenter.swift
//  StocksApp
//
//  Created by Abdurahim on 11.06.2022.
//

import Foundation

protocol StockFavoritesViewProtocol: AnyObject {
    func updateView()
    func updateCell(for indexPath: IndexPath, isFavorite: Bool)
    func updateView(withLoader isLoading: Bool)
    func updateView(withError message: String)
}

protocol StockFavoritesPresenterProtocol {
    var view: StockFavoritesViewProtocol? { get set }
    var favoritesCount: Int { get }
    
    func loadView()
    func model(for indexPath: IndexPath) -> StockModelProtocol
}

final class StockFavoritesPresenter: StockFavoritesPresenterProtocol {
    private let service: StocksServiceProtocol
    private var favoriteStocks: [StockModelProtocol] = []
    
    var favoritesCount: Int {
        favoriteStocks.count
    }
    
    init(service: StocksServiceProtocol) {
        self.service = service
    }
    
    weak var view: StockFavoritesViewProtocol?
    
    func loadView() {
        view?.updateView(withLoader: true)
        
        service.getStocks { [weak self] result in
            self?.view?.updateView(withLoader: false)
            
            switch result {
            case .success(let favoriteStocks):
                self?.favoriteStocks = favoriteStocks.map { StockModel(stock: $0) }.filter { $0.isFavorite }
                self?.view?.updateView()
            case .failure(let error):
                self?.view?.updateView(withError: error.localizedDescription)
            }
        }
    }
    
    func model(for indexPath: IndexPath) -> StockModelProtocol {
        favoriteStocks[indexPath.row]
    }
}
