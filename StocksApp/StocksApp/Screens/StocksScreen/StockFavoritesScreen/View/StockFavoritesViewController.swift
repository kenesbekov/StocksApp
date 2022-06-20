//
//  StockFavoritesViewController.swift
//  StocksApp
//
//  Created by Abdurahim on 11.06.2022.
//

import UIKit

final class StockFavoritesViewController: UIViewController {
    private let presenter: StockFavoritesPresenterProtocol
    
    internal init(presenter: StockFavoritesPresenterProtocol) {
        self.presenter = presenter
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(StockCell.self, forCellReuseIdentifier: StockCell.typeName)
        
        return tableView
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    private func setup() {
        setupView()
        setupSubviews()
        setupNavigationBar()
        
        presenter.loadView()
    }
    
    private func setupView() {
        view.backgroundColor = .white
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "Favorites"
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupSubviews() {
        view.addSubview(tableView)
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    private func showError(_ message: String) {
        print(message)
    }
}

extension StockFavoritesViewController: StockFavoritesViewProtocol {
    func updateView() {
        tableView.reloadData()
    }
    
    func updateCell(for indexPath: IndexPath, isFavorite: Bool) {
        tableView.reloadRows(at: [indexPath], with: .none)
    }
    
    func updateView(withLoader isLoading: Bool) {
        print("Loader is - ", isLoading, " at ", Date())
    }
    
    func updateView(withError message: String) {
        print("Error - ", message)
    }
}

extension StockFavoritesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StockCell.typeName, for: indexPath) as! StockCell
        cell.selectionStyle = .none
        
        cell.configure(with: presenter.model(for: indexPath))
            
        if indexPath.row % 2 == 0 {
            cell.layer.cornerRadius = 16
            cell.backgroundColor = UIColor(red: 240/255, green: 244/255, blue: 247/255, alpha: 1)
        } else {
            cell.backgroundColor = .clear
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.favoritesCount
    }
}

extension StockFavoritesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let stockDetailVC = Assembly.assembler.detailModule(model: presenter.model(for: indexPath))
        navigationController?.pushViewController(stockDetailVC, animated: true)
    }
}

