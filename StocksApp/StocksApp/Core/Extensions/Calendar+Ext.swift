//
//  Calendar+Ext.swift
//  StocksApp
//
//  Created by Abdurahim on 16.06.2022.
//

import Foundation

extension Calendar {
    static let firstCryptoDay = Calendar.current.date(from: DateComponents(year: 2009, month: 1, day: 3))!
    
    static func numberOfDaysBetween(from fromDate: Date, to toDate: Date) -> Int {
        let fromDate = Calendar.current.startOfDay(for: fromDate)
        let toDate = Calendar.current.startOfDay(for: toDate)

        return Calendar.current.dateComponents([.day], from: fromDate, to: toDate).day!
    }
}
