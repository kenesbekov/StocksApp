//
//  NSObject+Ext.swift
//  StocksApp
//
//  Created by Abdurahim on 10.06.2022.
//

import Foundation

extension NSObject {
    static var typeName: String {
        String(describing: self)
    }
}
