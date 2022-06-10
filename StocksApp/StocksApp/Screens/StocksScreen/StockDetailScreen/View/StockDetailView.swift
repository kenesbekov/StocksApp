//
//  StockDetailView.swift
//  StocksApp
//
//  Created by Abdurahim on 09.06.2022.
//

import UIKit

final class StockDetailView: UIView {
    private lazy var currentPriceLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 28)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var priceChangeLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with model: StockModelProtocol) {
        currentPriceLabel.text = model.currentPrice
        priceChangeLabel.text = model.priceChange
        priceChangeLabel.textColor = model.priceChangeColor
    }

    private func setup() {
        setupViews()
        setupContraints()
    }
    
    private func setupViews() {
        addSubview(currentPriceLabel)
        addSubview(priceChangeLabel)
    }
    
    private func setupContraints() {
        currentPriceLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        currentPriceLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 63).isActive = true
        
        priceChangeLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        priceChangeLabel.topAnchor.constraint(equalTo: currentPriceLabel.bottomAnchor, constant: 8).isActive = true
    }
}
