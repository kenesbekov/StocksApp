//
//  ChartsService.swift
//  StocksApp
//
//  Created by Abdurahim on 10.06.2022.
//

import Foundation

protocol ChartsServiceProtocol {
    func getCharts(currency: String, count: String, completion: @escaping (Result<[Stock], NetworkError>) -> Void)
    func getCharts(currency: String, completion: @escaping (Result<[Stock], NetworkError>) -> Void)
    func getCharts(completion: @escaping (Result<[Stock], NetworkError>) -> Void)
}

final class ChartsService: ChartsServiceProtocol {
    private let client: NetworkService
    
    init(client: NetworkService) {
        self.client = client
    }
    
    func getCharts(currency: String, count: String, completion: @escaping (Result<[Stock], NetworkError>) -> Void) {
        client.execute(with: StocksRouter.stocks(currency: currency, count: count), completion: completion)
    }
}

extension ChartsServiceProtocol {
    func getCharts(currency: String, completion: @escaping (Result<[Stock], NetworkError>) -> Void) {
        getCharts(currency: currency, count: "100", completion: completion)
    }
    
    func getCharts(completion: @escaping (Result<[Stock], NetworkError>) -> Void) {
        getCharts(currency: "usd", completion: completion)
    }
}
