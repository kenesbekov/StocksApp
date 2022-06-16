//
//  ChartsService.swift
//  StocksApp
//
//  Created by Abdurahim on 10.06.2022.
//

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
        let allDays = Calendar.numberOfDaysBetween(from: Calendar.firstCryptoDay, to: .now)
        getCharts(id: id, currency: "usd", days: allDays, isDaily: true, completion: completion)
    }
}
