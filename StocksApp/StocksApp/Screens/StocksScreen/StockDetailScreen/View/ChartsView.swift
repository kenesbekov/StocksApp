//
//  ChartsView.swift
//  StocksApp
//
//  Created by Abdurahim on 10.06.2022.
//

import Foundation
import UIKit

final class ChartsView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        setupViews()
        setupContraints()
    }
    
    private func setupViews() {
        
    }
    
    private func setupContraints() {
        
    }
}
