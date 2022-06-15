//
//  FavoritesUpdateService.swift
//  StocksApp
//
//  Created by Abdurahim on 11.06.2022.
//

import Foundation

@objc protocol FavoritesUpdateServiceProtocol {
    func setFavorite(notification: Notification)
}

extension FavoritesUpdateServiceProtocol {
    func startObservingFavoriteNotifications() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(setFavorite),
                                               name: NSNotification.Name.favorites,
                                               object: nil)
    }
}
