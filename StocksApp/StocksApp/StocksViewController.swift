//
//  StocksViewController.swift
//  StocksApp
//
//  Created by Abdurahim on 08.06.2022.
//

import UIKit

final class StocksViewController: UIViewController {
    
    private var stocks: [Stock] = []
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.dataSource = self
        tableView.register(StockCell.self, forCellReuseIdentifier: StockCell.typeName)
        
        return tableView
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        getStocks()
    }
    
    private func setup() {
        setupView()
        setupSubviews()
    }
    
    private func setupView() {
        view.backgroundColor = .white
    }
    
    private func setupSubviews() {
        view.addSubview(tableView)
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    private func getStocks() {
        let client = Network()
        let service: StocksServiceProtocol = StocksService(client: client)
//        let service: StocksServiceProtocol = MockStocksService()
        
        service.getStocks { [weak self] result in
            switch result {
            case .success(let stocks):
                self?.stocks = stocks
                self?.tableView.reloadData()
            case .failure(let error):
                self?.showError(error.localizedDescription)
            }
        }
    }
    
    private func showError(_ message: String) {
        print(message)
    }
}

final class MockStocksService: StocksServiceProtocol {
    func getStocks(currency: String, count: String, completion: @escaping (Result<[Stock], NetworkError>) -> Void) {
        let stocks = [
            Stock(id: "", symbol: "", name: "", image: "", currentPrice: 0, priceChange: 0, priceChangePercentage: 0),
            Stock(id: "", symbol: "", name: "", image: "", currentPrice: 0, priceChange: 0, priceChangePercentage: 0),
            Stock(id: "", symbol: "", name: "", image: "", currentPrice: 0, priceChange: 0, priceChangePercentage: 0),Stock(id: "", symbol: "", name: "", image: "", currentPrice: 0, priceChange: 0, priceChangePercentage: 0),
            Stock(id: "", symbol: "", name: "", image: "", currentPrice: 0, priceChange: 0, priceChangePercentage: 0),
            Stock(id: "", symbol: "", name: "", image: "", currentPrice: 0, priceChange: 0, priceChangePercentage: 0),
            Stock(id: "", symbol: "", name: "", image: "", currentPrice: 0, priceChange: 0, priceChangePercentage: 0),
            Stock(id: "", symbol: "", name: "", image: "", currentPrice: 0, priceChange: 0, priceChangePercentage: 0)
        ]
        
        completion(.success(stocks))
    }
}

extension StocksViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StockCell.typeName, for: indexPath) as! StockCell
        
        cell.configure(with: stocks[indexPath.row])
            
        if indexPath.row % 2 == 0 {
            cell.layer.cornerRadius = 16
            cell.backgroundColor = UIColor(red: 240/255, green: 244/255, blue: 247/255, alpha: 1)
        } else {
            cell.backgroundColor = .clear
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stocks.count
    }
}

struct Stock: Decodable {
    let id: String
    let symbol: String
    let name: String
    let image: String
    let currentPrice: Double
    let priceChange: Double
    let priceChangePercentage: Double
    
    enum CodingKeys: String, CodingKey {
        case id, symbol, name, image
        case currentPrice = "current_price"
        case priceChange = "price_change_24h"
        case priceChangePercentage = "price_change_percentage_24h"
    }
}

extension NSObject {
    static var typeName: String {
        String(describing: self)
    }
}
