//
//  ViewController.swift
//  BarChartApp
//
//  Created by Oscar Odon on 19/03/2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var chartView: ChartView!
    
    @IBAction func segmentSelected(_ sender: UISegmentedControl) {
        let numSegments = (sender.selectedSegmentIndex + 1) * 4
                
                var dataPoints = [Double]()
                
                for _ in 0..<numSegments {
                    dataPoints.append(Double.random(in: 20.0...100.0))
                }
                
                chartView.setData(dataPoints)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

