//
//  StockCell.swift
//  StocksApp
//
//  Created by Abdurahim on 08.06.2022.
//

import UIKit

final class StockCell: UITableViewCell {
    
    private lazy var iconView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 12
        image.clipsToBounds = true
        image.image = UIImage(named: "YNDX")
        return image
    }()
    
    private lazy var symbolLabel: UILabel = {
        let label = UILabel()
        label.text = "YNDX"
        label.font = .boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Yandex, LLC"
        label.font = .boldSystemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var favoriteButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "favorite-off"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var currentPriceLabel: UILabel = {
        let label = UILabel()
        label.text = "4 764,6 ₽"
        label.font = .boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var priceChangeLabel: UILabel = {
        let label = UILabel()
        label.text = "+55 ₽ (1,15%)"
        label.font = .boldSystemFont(ofSize: 12)
        label.textColor = UIColor(red: 36/255, green: 178/255, blue: 93/255, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var infoContainterView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var priceContainterView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        setupContentView()
        setupContentViewConstraints()
        
        setupInfoContainerView()
        setupInfoContainterViewConstraints()
        
        setupPriceContainerView()
        setupPriceContainterViewConstraints()
    }
    
    private func setupContentView() {
        contentView.addSubview(iconView)
        contentView.addSubview(infoContainterView)
        contentView.addSubview(priceContainterView)
    }
    
    private func setupContentViewConstraints() {
        iconView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8).isActive = true
        iconView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
        iconView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8).isActive = true
        iconView.heightAnchor.constraint(equalToConstant: 52).isActive = true
        iconView.widthAnchor.constraint(equalToConstant: 52).isActive = true
        
        infoContainterView.leadingAnchor.constraint(equalTo: iconView.trailingAnchor, constant: 12).isActive = true
        infoContainterView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        infoContainterView.trailingAnchor.constraint(lessThanOrEqualTo: priceContainterView.leadingAnchor, constant: -20).isActive = true
        
        priceContainterView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12).isActive = true
        priceContainterView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
    }
    
    private func setupInfoContainerView() {
        infoContainterView.addSubview(symbolLabel)
        infoContainterView.addSubview(nameLabel)
        infoContainterView.addSubview(favoriteButton)
    }
    
    private func setupInfoContainterViewConstraints() {
        symbolLabel.leadingAnchor.constraint(equalTo: infoContainterView.leadingAnchor).isActive = true
        symbolLabel.topAnchor.constraint(equalTo: infoContainterView.topAnchor).isActive = true
        
        nameLabel.leadingAnchor.constraint(equalTo: symbolLabel.leadingAnchor).isActive = true
        nameLabel.topAnchor.constraint(equalTo: symbolLabel.bottomAnchor).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: infoContainterView.trailingAnchor).isActive = true
        nameLabel.bottomAnchor.constraint(equalTo: infoContainterView.bottomAnchor).isActive = true
        
        favoriteButton.leadingAnchor.constraint(equalTo: symbolLabel.trailingAnchor, constant: 6).isActive = true
        favoriteButton.trailingAnchor.constraint(equalTo: infoContainterView.trailingAnchor).isActive = true
        favoriteButton.centerYAnchor.constraint(equalTo: symbolLabel.centerYAnchor).isActive = true
        favoriteButton.heightAnchor.constraint(equalToConstant: 16).isActive = true
        favoriteButton.widthAnchor.constraint(equalToConstant: 16).isActive = true
    }
    
    private func setupPriceContainerView() {
        priceContainterView.addSubview(currentPriceLabel)
        priceContainterView.addSubview(priceChangeLabel)
    }
    
    private func setupPriceContainterViewConstraints() {
        currentPriceLabel.topAnchor.constraint(equalTo: priceContainterView.topAnchor).isActive = true
        currentPriceLabel.trailingAnchor.constraint(equalTo: priceContainterView.trailingAnchor, constant: -5).isActive = true
        
        priceChangeLabel.leadingAnchor.constraint(greaterThanOrEqualTo: priceContainterView.leadingAnchor).isActive = true
        priceChangeLabel.topAnchor.constraint(equalTo: currentPriceLabel.bottomAnchor).isActive = true
        priceChangeLabel.trailingAnchor.constraint(equalTo: priceContainterView.trailingAnchor).isActive = true
        priceChangeLabel.bottomAnchor.constraint(equalTo: priceContainterView.bottomAnchor).isActive = true
    }
}
