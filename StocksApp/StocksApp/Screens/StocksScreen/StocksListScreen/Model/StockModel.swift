//
//  StockModel.swift
//  StocksApp
//
//  Created by Abdurahim on 10.06.2022.
//

import Foundation
import UIKit

protocol StockModelProtocol {
    var id: String { get }
    var symbol: String { get }
    var name: String { get }
    var image: URL { get }
    var currentPrice: String { get }
    var priceChange: String { get }
    var priceChangeColor: UIColor { get }
    
    var isFavorite: Bool { get set }
    
    func setFavorite()
}

final class StockModel: StockModelProtocol {
    private let stock: Stock
    private let favoritesService: FavoritesServiceProtocol
    
    init(stock: Stock) {
        self.stock = stock
        favoritesService = ModuleBuilder.shared.favoritesService
        isFavorite = favoritesService.isFavorite(for: id)
    }
    
    var id: String {
        stock.id
    }
    
    var symbol: String {
        stock.symbol
    }
    
    var name: String {
        stock.name
    }
    
    var image: URL {
        stock.image
    }
    
    var currentPrice: String {
        "$" + String(stock.currentPrice)
    }
    
    var priceChange: String {
        if stock.priceChange >= 0 {
            return "+$" + String(format: "%.2f", stock.priceChange) + " (" + String(format: "%.2f", stock.priceChangePercentage) + ")%"
        } else {
            return "-$" + String(format: "%.2f", -stock.priceChange) + " (" + String(format: "%.2f", stock.priceChangePercentage) + ")%"
        }
    }
    
    var priceChangeColor: UIColor {
        stock.priceChange >= 0 ? .systemGreen : .systemRed
    }
    
    var isFavorite: Bool = false
    
    func setFavorite() {
        isFavorite.toggle()
        
        if isFavorite {
            favoritesService.save(id: id)
        } else {
            favoritesService.remove(id: id)
        }
    }
}
