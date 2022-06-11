//
//  FileManagerFavoritesService.swift
//  StocksApp
//
//  Created by Abdurahim on 11.06.2022.
//

import Foundation

final class FavoritesLocalService: FavoritesServiceProtocol {
    private lazy var path: URL = {
        FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0].appendingPathComponent("Favorites")
    }()
    
    private lazy var favoriteIDs: [String] = {
        do {
            let data = try Data(contentsOf: path)
            return try JSONDecoder().decode([String].self, from: data)
        } catch {
            print("FileManager ReadError - ", error.localizedDescription)
        }
        
        return []
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
        do {
            let data = try JSONEncoder().encode(favoriteIDs)
            try data.write(to: path)
        } catch {
            print("FileManager WriteError - ", error.localizedDescription)
        }
    }
}
