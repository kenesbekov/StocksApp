//
//  ChartsService.swift
//  StocksApp
//
//  Created by Abdurahim on 10.06.2022.
//

import Foundation

protocol ChartsServiceProtocol {
    func getCharts(id: String, currency: String, days: Int, interval: String, completion: @escaping (Result<Charts, NetworkError>) -> Void)
    func getCharts(id: String, completion: @escaping (Result<Charts, NetworkError>) -> Void)
}

final class ChartsService: ChartsServiceProtocol {
    private let client: NetworkService
    
    init(client: NetworkService) {
        self.client = client
    }
    
    func getCharts(id: String, currency: String, days: Int, interval: String, completion: @escaping (Result<Charts, NetworkError>) -> Void) {
        client.execute(with: StocksRouter.charts(id: id, currency: currency, days: days, interval: interval), completion: completion)
    }
}

extension ChartsServiceProtocol {
    func getCharts(id: String, completion: @escaping (Result<Charts, NetworkError>) -> Void) {
        getCharts(id: id, currency: "usd", days: 60, interval: "daily", completion: completion)
    }
}
