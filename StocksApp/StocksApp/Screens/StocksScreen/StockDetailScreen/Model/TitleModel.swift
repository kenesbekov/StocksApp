//
//  TitleModel.swift
//  StocksApp
//
//  Created by Abdurahim on 10.06.2022.
//

import Foundation

struct TitleModel {
    let symbol: String
    let name: String
    
    static func from(stockModel model: StockModelProtocol) -> TitleModel {
        TitleModel(symbol: model.symbol, name: model.name)
    }
}
