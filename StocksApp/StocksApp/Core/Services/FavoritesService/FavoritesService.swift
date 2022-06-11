//
//  FavoritesService.swift
//  StocksApp
//
//  Created by Abdurahim on 11.06.2022.
//

import Foundation

protocol FavoritesServiceProtocol {
    func save(id: String)
    func remove(id: String)
    func isFavorite(for id: String) -> Bool
}
