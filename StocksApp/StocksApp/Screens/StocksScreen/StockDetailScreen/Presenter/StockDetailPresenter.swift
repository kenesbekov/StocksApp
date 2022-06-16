//
//  StockDetailPresenter.swift
//  StocksApp
//
//  Created by Abdurahim on 10.06.2022.
//

import Foundation

protocol StockDetailViewProtocol: AnyObject {
    func updateView()
    func updateView(with model: ChartsModel)
    func updateView(withLoader isLoading: Bool)
    func updateView(withError message: String)
}

protocol StockDetailPresenterProtocol {
    var view: StockDetailViewProtocol? { get set }
    var titleModel: TitleModel { get }
    
    func loadView()
    func getModel() -> StockModelProtocol
}

final class StockDetailPresenter: StockDetailPresenterProtocol {
    private let service: ChartsServiceProtocol
    private let model: StockModelProtocol
    
    init(model: StockModelProtocol, service: ChartsServiceProtocol) {
        self.model = model
        self.service = service
    }
    
    weak var view: StockDetailViewProtocol?
    
    public lazy var titleModel: TitleModel = {
        .from(stockModel: model)
    }()
    
    public func loadView() {
        view?.updateView(withLoader: true)
        
        service.getCharts(id: model.id) { [weak self] result in
            self?.view?.updateView(withLoader: false)
            
            switch result {
            case .success(let charts):
                self?.view?.updateView(with: .build(from: charts))
            case .failure(let error):
                self?.view?.updateView(withError: error.localizedDescription)
            }
        }
    }
    
    func getModel() -> StockModelProtocol {
        return self.model
    }
}
