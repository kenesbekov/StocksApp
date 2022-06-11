//
//  StockDetailViewController.swift
//  StocksApp
//
//  Created by Abdurahim on 09.06.2022.
//

import UIKit

final class StockDetailViewController: UIViewController {
    private let presenter: StockDetailPresenterProtocol
    
    init(presenter: StockDetailPresenterProtocol) {
        self.presenter = presenter
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var titleView: UIView = {
        let view = DetailTitleView()
        view.configure(with: presenter.titleModel)
        return view
    }()
    
    private lazy var stockDetailView = StockDetailView(frame: CGRect(
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
        button.setImage(UIImage(named: "favorite-on"), for: .selected)
        button.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        button.isSelected = self.presenter.getModel().isFavorite
        button.addTarget(self, action: #selector(favoriteButtonTapped), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    @objc
    private func backBattonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc
    private func favoriteButtonTapped(_ sender: UIButton!) {
        sender.isSelected.toggle()
        presenter.getModel().setFavorite()
    }
    
    private func setup() {
        setupView()
        setupViews()
        setupContraints()
        setupNavigationBar()
        
        presenter.loadView()
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
        stockDetailView.configure(with: presenter.getModel())
        view.addSubview(stockDetailView)
    }
    
    private func setupContraints() {
        stockDetailView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        stockDetailView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        stockDetailView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        stockDetailView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}

extension StockDetailViewController: StockDetailViewProtocol {
    func updateView() {
        
    }
    
    func updateView(withLoader isLoading: Bool) {
        print("Loader is - ", isLoading, " at ", Date())
    }
    
    func updateView(withError message: String) {
        print("Error - ", message)
    }
    
}
