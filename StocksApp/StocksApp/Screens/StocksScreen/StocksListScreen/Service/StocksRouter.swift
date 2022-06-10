//
//  StocksRouter.swift
//  StocksApp
//
//  Created by Abdurahim on 10.06.2022.
//

import Foundation

enum StocksRouter: Router {
    case stocks(currency: String, count: String)
    case charts(id: String, currency: String, days: Int, interval: String)
    
    var baseUrl: String {
        return "https://api.coingecko.com"
    }
    
    var path: String {
        switch self {
        case .stocks:
            return "/api/v3/coins/markets"
        case .charts(let id, _, _, _):
            return "/api/v3/coins/\(id)/market_chart"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .stocks, .charts:
            return .get
        }
    }
    
    var parameters: Parameters {
        switch self {
        case .stocks(let currency, let count):
            return ["vs_currency": currency, "per_page": count]
        case let .charts(_, currency, days, interval):
            return ["vs_currency": currency, "days": days, "interval": interval]
        }
    }
}
