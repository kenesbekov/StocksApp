//
//  ChartsService.swift
//  StocksApp
//
//  Created by Abdurahim on 10.06.2022.
//

fileprivate enum Constants {
    static let currency = "usd"
    static let isDaily = true
    static let days = Calendar.numberOfDaysBetween(from: Calendar.firstCryptoDay, to: .now)
}

import Foundation

protocol ChartsServiceProtocol {
    func getCharts(id: String, currency: String, days: Int, isDaily: Bool, completion: @escaping (Result<Charts, NetworkError>) -> Void)
    func getCharts(id: String, completion: @escaping (Result<Charts, NetworkError>) -> Void)
}

final class ChartsService: ChartsServiceProtocol {
    private let network: NetworkService
    
    init(network: NetworkService) {
        self.network = network
    }
    
    func getCharts(id: String, currency: String, days: Int, isDaily: Bool, completion: @escaping (Result<Charts, NetworkError>) -> Void) {
        network.execute(with: StocksRouter.charts(id: id, currency: currency, days: days, isDaily: isDaily), completion: completion)
    }
}

extension ChartsServiceProtocol {
    func getCharts(id: String, completion: @escaping (Result<Charts, NetworkError>) -> Void) {
        getCharts(id: id, currency: Constants.currency, days: Constants.days, isDaily: Constants.isDaily, completion: completion)
    }
}
