//
//  ChartsView.swift
//  StocksApp
//
//  Created by Abdurahim on 10.06.2022.
//

import Foundation
import UIKit
import Charts

final class ChartsContainterView: UIView {
    private var chartsModel: ChartsModel?
    private var buttons: [UIButton] = []
    
    private lazy var chartsView: LineChartView = {
        let chartView = LineChartView()
        chartView.translatesAutoresizingMaskIntoConstraints = false
        
        chartView.xAxis.enabled = true
        chartView.xAxis.labelPosition = .bottom
        chartView.xAxis.drawGridLinesEnabled = false
        chartView.xAxis.axisLineColor = .clear
        
        chartView.leftAxis.enabled = false
        chartView.rightAxis.enabled = false
        
        return chartView
    }()
    
    private lazy var buttonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var loader: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with isLoading: Bool) {
        loader.isHidden = !isLoading
        buttonsStackView.isHidden = isLoading
        isLoading ? loader.startAnimating() : loader.stopAnimating()
    }
    
    public func configure(with model: ChartsModel) {
        self.chartsModel = model
        addButtons(for: model)
        setCharts(with: model.periods.first)
    }
    
    private func setup() {
        setupViews()
        setupContraints()
    }
    
    private func setupViews() {
        addSubview(chartsView)
        addSubview(buttonsStackView)
        addSubview(loader)
    }
    
    private func setupContraints() {
        chartsView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: -10).isActive = true
        chartsView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 10).isActive = true
        chartsView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        chartsView.heightAnchor.constraint(equalTo: chartsView.widthAnchor, multiplier: 26/36).isActive = true
        
        buttonsStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        buttonsStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        buttonsStackView.topAnchor.constraint(equalTo: chartsView.bottomAnchor, constant: 40).isActive = true
        
        loader.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        loader.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    private func addButtons(for model: ChartsModel) {
        model.periods.enumerated().forEach { (index, period) in
            let button = UIButton()
            button.tag = index
            
            button.backgroundColor = UIColor(red: 240/255, green: 244/255, blue: 247/255, alpha: 1)
            
            button.setTitle(period.name, for: .normal)
            button.titleLabel?.font = .boldSystemFont(ofSize: 12)
            
            button.heightAnchor.constraint(equalToConstant: 44).isActive = true
            
            button.layer.cornerRadius = 12
            button.layer.cornerCurve = .continuous
            
            button.addTarget(self, action: #selector(periodButtonTapped), for: .touchUpInside)
            
            button.backgroundColor = period.name == "W" ? .black : UIColor(red: 240/255, green: 244/255, blue: 247/255, alpha: 1)
            button.setTitleColor(period.name == "W" ? .white : .black, for: .normal)
            
            buttonsStackView.addArrangedSubview(button)
            buttons.append(button)
        }
    }
    
    private func setCharts(with period: ChartsPeriod?) {
        guard let period = period else { return }
        
        var yValues = [ChartDataEntry]()
        for (index, value) in period.prices.enumerated() {
            let dataEntry = ChartDataEntry(x: Double(index + 1), y: value)
            yValues.append(dataEntry)
        }
        
        let lineDataSet = LineChartDataSet(entries: yValues, label: "")
        
        lineDataSet.drawCirclesEnabled = false
        lineDataSet.mode = .cubicBezier
        lineDataSet.setColor(.black)
        lineDataSet.lineWidth = 2
        
        
        let gradientColors = [UIColor.systemGray6.cgColor, UIColor.clear.cgColor] as CFArray
        let colorLocations:[CGFloat] = [1.0, 0.0]
        let gradient = CGGradient.init(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: gradientColors, locations: colorLocations)
        lineDataSet.fill = Fill.fillWithLinearGradient(gradient!, angle: 90.0)
        
        lineDataSet.drawFilledEnabled = true
        
        lineDataSet.drawHorizontalHighlightIndicatorEnabled = false
        lineDataSet.highlightColor = .black
        lineDataSet.highlightLineDashPhase = 0.5
        
        let data = LineChartData(dataSet: lineDataSet)
        data.setDrawValues(false)
        chartsView.data = data
        chartsView.animate(xAxisDuration: 0.3)
    }
    
    @objc
    private func periodButtonTapped(_ sender: UIButton!) {
        buttons.forEach {
            $0.backgroundColor = sender.tag == $0.tag ? .black : UIColor(red: 240/255, green: 244/255, blue: 247/255, alpha: 1)
            $0.setTitleColor(sender.tag == $0.tag ? .white : .black, for: .normal)
        }
        
        switch sender.tag {
        case 0:
            setCharts(with: chartsModel?.periods[0])
        case 1:
            setCharts(with: chartsModel?.periods[1])
        case 2:
            setCharts(with: chartsModel?.periods[2])
        case 3:
            setCharts(with: chartsModel?.periods[3])
        case 4:
            setCharts(with: chartsModel?.periods[4])
        default:
            break
        }
    }
}
