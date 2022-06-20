//
//  NSNotificationName+Ext.swift
//  StocksApp
//
//  Created by Abdurahim on 11.06.2022.
//

import Foundation

extension NSNotification.Name {
    static let favorites = NSNotification.Name("Update.Favorite.Stocks")
}

extension Notification {
    var stockID: String? {
        guard let userInfo = userInfo,
              let id = userInfo["id"] as? String else { return nil }
        
        return id
    }
}
