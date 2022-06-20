//
//  NetworkError.swift
//  StocksApp
//
//  Created by Abdurahim on 09.06.2022.
//

import Foundation

enum NetworkError: String, Error {
    case missingURL
    case missingRequest
    case taskError
    case responseError
    case dataError
    case decodeError
}
