//
//  Array+Ext.swift
//  StocksApp
//
//  Created by Abdurahim on 11.06.2022.
//

import Foundation

extension Array {
    public subscript(safe index: Int) -> Element? {
        guard index >= 0, index < endIndex else {
            return nil
        }
        
        return self[index]
    }
}
