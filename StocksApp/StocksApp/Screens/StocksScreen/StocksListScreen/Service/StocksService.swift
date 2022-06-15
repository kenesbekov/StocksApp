//
//  StocksService.swift
//  StocksApp
//
//  Created by Abdurahim on 09.06.2022.
//

import Foundation

protocol StocksServiceProtocol {
    func getStocks(currency: String, count: String, completion: @escaping (Result<[Stock], NetworkError>) -> Void)
    func getStocks(currency: String, completion: @escaping (Result<[Stock], NetworkError>) -> Void)
    func getStocks(completion: @escaping (Result<[Stock], NetworkError>) -> Void)
}

final class StocksService: StocksServiceProtocol {
    private let network: NetworkService
    
    init(network: NetworkService) {
        self.network = network
    }
    
    func getStocks(currency: String, count: String, completion: @escaping (Result<[Stock], NetworkError>) -> Void) {
        network.execute(with: StocksRouter.stocks(currency: currency, count: count), completion: completion)
    }
}

extension StocksServiceProtocol {
    func getStocks(currency: String, completion: @escaping (Result<[Stock], NetworkError>) -> Void) {
        getStocks(currency: currency, count: "100", completion: completion)
    }
    
    func getStocks(completion: @escaping (Result<[Stock], NetworkError>) -> Void) {
        getStocks(currency: "usd", completion: completion)
    }
}
