//
//  DetailTitleView.swift
//  StocksApp
//
//  Created by Abdurahim on 09.06.2022.
//

import UIKit

final class DetailTitleView: UIView {
    private lazy var symbolLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var nameLabel: UILabel = {
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
    
    func configure(with model: TitleModel) {
        symbolLabel.text = model.symbol
        nameLabel.text = model.name
    }

    private func setup() {
        setupViews()
        setupContraints()
    }
    
    private func setupViews() {
        addSubview(symbolLabel)
        addSubview(nameLabel)
    }
    
    private func setupContraints() {
        symbolLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        symbolLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        
        nameLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        nameLabel.topAnchor.constraint(equalTo: symbolLabel.bottomAnchor, constant: 4).isActive = true
    }

}
