//
//  UserDefaultsFavoritesService.swift
//  StocksApp
//
//  Created by Abdurahim on 11.06.2022.
//

import Foundation

// just as an example, not for using
final class FavoritesService: FavoritesServiceProtocol {
    private let key = "favorite_key"
    private lazy var favoriteIDs: [String] = {
        guard let data = UserDefaults.standard.object(forKey: key) as? Data,
              let ids = try? JSONDecoder().decode([String].self, from: data) else {
                return []
            }
        
        return ids
    }()
    
    func save(id: String) {
        favoriteIDs.append(id)
        updateRepo()
    }
    
    func remove(id: String) {
        if let index = favoriteIDs.firstIndex(where: { $0 == id }) {
            favoriteIDs.remove(at: index)
        }
        updateRepo()
    }
    
    func isFavorite(for id: String) -> Bool {
        favoriteIDs.contains(id)
    }
    
    private func updateRepo() {
        guard let data = try? JSONEncoder().encode(favoriteIDs) else {
            return
        }
        UserDefaults.standard.set(data, forKey: key)
    }
}
