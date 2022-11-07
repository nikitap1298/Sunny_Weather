//
//  GraphView.swift
//  Sunny
//
//  Created by Nikita Pishchugin on 10.10.2022.
//

import UIKit
import Charts

class GraphView: UIView {
    
    let lineChartView = LineChartView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpUI()
    }
    
    private func setUpUI() {
        self.addSubview(lineChartView)
        
        lineChartView.translateMask()
        
        // Set Chart (Graph)
        lineChartView.rightAxis.enabled = false
        let yAxis = lineChartView.leftAxis
        yAxis.labelFont = UIFont(name: CustomFonts.loraMedium, size: 16) ?? .systemFont(ofSize: 16)
        yAxis.labelTextColor = OnboardingColors.graphText ?? .black
        yAxis.axisLineColor = CustomColors.colorGray ?? .systemGray
        yAxis.gridColor = CustomColors.colorGray ?? .systemGray
        yAxis.labelPosition = .outsideChart
        yAxis.labelXOffset = 0
        yAxis.setLabelCount(5, force: true)
        yAxis.valueFormatter = YAxisValueFormatter()
        
        let xAxis = lineChartView.xAxis
        xAxis.labelFont = UIFont(name: CustomFonts.loraMedium, size: 16) ?? .systemFont(ofSize: 16)
        xAxis.labelTextColor = OnboardingColors.graphText ?? .black
        xAxis.axisLineColor = CustomColors.colorGray ?? .systemGray
        xAxis.gridColor = CustomColors.colorGray ?? .systemGray
        xAxis.labelPosition = .bottom
        xAxis.yOffset = 10
        xAxis.valueFormatter = XAxisValueFormatter()
        
        // Color of charts label
        lineChartView.legend.textColor = OnboardingColors.graphText ?? .white
        lineChartView.scaleXEnabled = false
        lineChartView.scaleYEnabled = false
        lineChartView.isUserInteractionEnabled = false
        
        NSLayoutConstraint.activate([
            lineChartView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            lineChartView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            lineChartView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            lineChartView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)
        ])
    }
}
