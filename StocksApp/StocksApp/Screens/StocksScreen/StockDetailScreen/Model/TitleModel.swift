//
//  TitleModel.swift
//  StocksApp
//
//  Created by Abdurahim on 10.06.2022.
//

import Foundation

protocol TitleModelProtocol {
    var symbol: String { get }
    var name: String { get }
    
    static func from(stockModel model: StockModelProtocol) -> TitleModel
}

struct TitleModel: TitleModelProtocol {
    var symbol: String
    var name: String
    
    static func from(stockModel model: StockModelProtocol) -> TitleModel {
        TitleModel(symbol: model.symbol, name: model.name)
    }
}
