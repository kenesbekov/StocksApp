//
//  ChartsModel.swift
//  StocksApp
//
//  Created by Abdurahim on 11.06.2022.
//

import Foundation

protocol ChartsModelProtocol {
    var periods: [ChartsPeriod] { get }
    
    static func build(from charts: Charts) -> ChartsModel
}

struct ChartsModel: ChartsModelProtocol {
    var periods: [ChartsPeriod]
    
    static func build(from charts: Charts) -> ChartsModel {
        let period = charts.prices.map { $0.price }
        
        return ChartsModel(periods: [ChartsPeriod(name: "W", prices: period.suffix(7)),
                                     ChartsPeriod(name: "M", prices: period.suffix(30)),
                                     ChartsPeriod(name: "6M", prices: period.suffix(180)),
                                     ChartsPeriod(name: "1Y", prices: period.suffix(365)),
                                     ChartsPeriod(name: "ALL", prices: period)])
    }
}

struct ChartsPeriod {
    let name: String
    let prices: [Double]
}
