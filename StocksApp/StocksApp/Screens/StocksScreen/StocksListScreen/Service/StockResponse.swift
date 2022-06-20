//
//  StockResponse.swift
//  StocksApp
//
//  Created by Abdurahim on 10.06.2022.
//

import Foundation

struct Stock: Decodable {
    let id: String
    let symbol: String
    let name: String
    let image: URL
    let currentPrice: Double
    let priceChange: Double
    let priceChangePercentage: Double
    
    enum CodingKeys: String, CodingKey {
        case id, symbol, name, image
        case currentPrice = "current_price"
        case priceChange = "price_change_24h"
        case priceChangePercentage = "price_change_percentage_24h"
    }
}
