//
//  ViewController.swift
//  BarChartApp
//
//  Created by Oscar Odon on 19/03/2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var chartView: ChartView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBAction func segmentSelected(_ sender: UISegmentedControl) {
        let numSegments = (sender.selectedSegmentIndex + 1) * 4
        let dataPoints = getDatapoints(for: numSegments)
        chartView.setData(dataPoints)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let startingNumOfSegments = (segmentedControl.selectedSegmentIndex + 1) * 4
        let datapoints = getDatapoints(for: startingNumOfSegments)
        chartView.setData(datapoints)
    }
    
    private func getDatapoints(for numberOfSegments: Int) -> [Double] {
        var dataPoints = [Double]()
        
        for _ in 0 ..< numberOfSegments {
            dataPoints.append(Double.random(in: 20.0...100.0))
        }
        
        return dataPoints
    }
}

