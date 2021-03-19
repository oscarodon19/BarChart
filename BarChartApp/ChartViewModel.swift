//
//  ChartViewModel.swift
//  BarChartApp
//
//  Created by Oscar Odon on 19/03/2021.
//

import UIKit

internal struct ChartViewModel {
    var dataPoints = [Double]()
    
    var barColor = UIColor.systemPurple
    
    var maxY: Double { dataPoints.sorted(by: >).first ?? 0 }
    
    var barGapPctOfTotal: CGFloat { CGFloat(0.2) / CGFloat(dataPoints.count - 1) }
    
    var barWidthPctOfTotal: CGFloat { CGFloat(0.8) / CGFloat(dataPoints.count) }
    
    var barCornerRadius: CGFloat { CGFloat(50 / dataPoints.count) }
}
