//
//  StockDetailsViewController.swift
//  StocksApp
//
//  Created by Abdurahim on 09.06.2022.
//

import UIKit

final class StockDetailsViewController: UIViewController {
    private var stock: Stock?
    
    private lazy var titleView: UIView = {
        let view = DetailTitleView()
        view.configure(with: stock!)
        return view
    }()
    
    public let stockDetailView = StockDetailView(frame: CGRect(
        x: 0,
        y: 0,
        width: UIScreen.main.bounds.width,
        height: UIScreen.main.bounds.height
    ))
    
    private lazy var backButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "back"), for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 20, height: 14)
        button.addTarget(self, action: #selector(backBattonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var favoriteButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "fav-detail"), for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    public func configure(with stock: Stock) {
        self.stock = stock
    }
    
    private func setup() {
        setupView()
        setupViews()
        setupContraints()
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        navigationItem.titleView = titleView
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: favoriteButton)
    }
    
    private func setupView() {
        view.backgroundColor = .white
    }
    
    private func setupViews() {
        stockDetailView.configure(with: stock!)
        view.addSubview(stockDetailView)
    }
    
    private func setupContraints() {
        stockDetailView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        stockDetailView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        stockDetailView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        stockDetailView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    @objc
    private func backBattonTapped() {
        navigationController?.popViewController(animated: true)
    }
}
