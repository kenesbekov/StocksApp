//
//  StockDetailView.swift
//  StocksApp
//
//  Created by Abdurahim on 09.06.2022.
//

import UIKit

final class StockDetailView: UIView {
    private var stock: Stock?
    
    private lazy var currentPriceLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 28)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var priceChangeLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 12)
        label.textColor = UIColor(red: 36/255, green: 178/255, blue: 93/255, alpha: 1)
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
    
    public func configure(with stock: Stock) {
        self.stock = stock
        configureStockAttributes()
    }
    
    private func configureStockAttributes() {
        guard let stock = stock else { return }
        
        currentPriceLabel.text = "$" + String(stock.currentPrice)
        
        if stock.priceChange > 0 {
            priceChangeLabel.text = "+$" + String(format: "%.2f", stock.priceChange) + " (" + String(format: "%.2f", stock.priceChangePercentage) + ")%"
        } else {
            priceChangeLabel.text = "-$" + String(format: "%.2f", -stock.priceChange) + " (" + String(format: "%.2f", stock.priceChangePercentage) + ")%"
        }
    }
}
