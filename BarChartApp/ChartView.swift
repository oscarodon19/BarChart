//
//  ChartView.swift
//  BarChartApp
//
//  Created by Oscar Odon on 19/03/2021.
//

import UIKit

class ChartView: UIView {
    private var viewModel = ChartViewModel()
    private var tapRecognizer: UITapGestureRecognizer!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleBarTap))
        addGestureRecognizer(tapRecognizer)
    }
    
    deinit {
        removeGestureRecognizer(tapRecognizer)
    }
    
    func setData(_ dataPoints: [Double]) {
        backgroundColor = .clear
        
        viewModel.dataPoints = dataPoints
        clearViews()
        
        guard viewModel.maxY > 0.0 else { return }
        
        createChart()
    }
    
    private func clearViews() {
        subviews.forEach { (view) in
            view.removeFromSuperview()
        }
    }
    
    private func createChart() {
        var lastBar: UIView?
        
        viewModel.dataPoints.enumerated().forEach { (index, dataPoint) in
            let barView = createBarView(barNumber: index, barValue: dataPoint)
            
            if let lastBar = lastBar {
                let gapView = createGapView(lastBar: lastBar)
                barView.leftAnchor.constraint(equalTo: gapView.rightAnchor).isActive = true
            } else {
                barView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
            }
            
            if index == viewModel.dataPoints.count - 1 {
                barView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
            }
            
            barView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
            
            barView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: CGFloat(dataPoint / viewModel.maxY)).isActive = true
            
            lastBar = barView
        }
    }
    
    private func createBarView(barNumber: Int, barValue: Double) -> UIView {
        let barView = UIView()
        addSubview(barView)
        barView.translatesAutoresizingMaskIntoConstraints = false
        
        barView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: viewModel.barWidthPctOfTotal).isActive = true
        barView.tag = barNumber + 1000
        barView.backgroundColor = viewModel.barColor
        barView.layer.cornerRadius = viewModel.barCornerRadius
        
        return barView
    }
    
    private func createGapView(lastBar: UIView) -> UIView {
        let gapView = UIView()
        addSubview(gapView)
        gapView.translatesAutoresizingMaskIntoConstraints = false
        
        gapView.heightAnchor.constraint(equalToConstant: 1.0).isActive = true
        gapView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        gapView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: viewModel.barGapPctOfTotal).isActive = true
        gapView.leftAnchor.constraint(equalTo: lastBar.rightAnchor).isActive = true
        
        return gapView
    }
    
    @objc private func handleBarTap() {
        if let hitView = tapRecognizer.view {
            let location = tapRecognizer.location(in: self)
            if let barViewTapped = hitView.hitTest(location, with: nil) {
                for barView in subviews where barView.tag >= 1000 {
                    barView.backgroundColor = barView.tag == barViewTapped.tag ? viewModel.barColor.withAlphaComponent(0.4) : viewModel.barColor
                }
            }
        }
    }
}
