//
//  FirstBlock.swift
//  Sunny
//
//  Created by Nikita Pishchugin on 17.09.2022.
//

import UIKit

class FirstBlock: UIView {
    
    private let buttonHeight: CGFloat = 50
    
    let mainView = UIView()
    
    let temperature = CustomFirstBlockButtons()
    let speed = CustomFirstBlockButtons()
    let pressure = CustomFirstBlockButtons()
    let precipitation = CustomFirstBlockButtons()
    let distance = CustomFirstBlockButtons()
    let timeFormat = CustomFirstBlockButtons()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpUI()
    }
    
    private func setUpUI() {
        self.addSubview(mainView)
        mainView.addSubview(temperature)
        mainView.addSubview(speed)
        mainView.addSubview(pressure)
        mainView.addSubview(precipitation)
        mainView.addSubview(distance)
        mainView.addSubview(timeFormat)
        
        self.translateMask()
        mainView.translateMask()
        temperature.translateMask()
        speed.translateMask()
        pressure.translateMask()
        precipitation.translateMask()
        distance.translateMask()
        timeFormat.translateMask()
        
        mainView.backgroundColor = SettingsColors.blockAndText
        
        temperature.settingsLabel.text = "Temperature"
        temperature.leftValueLabel.text = "ºC"
        temperature.rightValueLabel.text = "ºF"
        
        speed.settingsLabel.text = "Speed"
        speed.leftValueLabel.text = "m/s"
        speed.rightValueLabel.text = "yd/s"
        
        pressure.settingsLabel.text = "Pressure"
        pressure.leftValueLabel.text = "mmHg"
        pressure.rightValueLabel.text = "hPa"
        
        precipitation.settingsLabel.text = "Precipitation"
        precipitation.leftValueLabel.text = "mm"
        precipitation.rightValueLabel.text = "in"
        
        distance.settingsLabel.text = "Distanсe"
        distance.leftValueLabel.text = "km"
        distance.rightValueLabel.text = "ml"
        
        timeFormat.settingsLabel.text = "Time Format"
        timeFormat.leftValueLabel.text = "12-h"
        timeFormat.rightValueLabel.text = "24-h"
        
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: self.topAnchor),
            mainView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            mainView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            temperature.settingsView.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 1),
            temperature.settingsView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
            temperature.settingsView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor),
            temperature.heightAnchor.constraint(equalToConstant: buttonHeight),
            
            speed.settingsView.topAnchor.constraint(equalTo: temperature.settingsView.bottomAnchor, constant: 1),
            speed.settingsView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
            speed.settingsView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor),
            speed.heightAnchor.constraint(equalToConstant: buttonHeight),
            
            pressure.settingsView.topAnchor.constraint(equalTo: speed.settingsView.bottomAnchor, constant: 1),
            pressure.settingsView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
            pressure.settingsView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor),
            pressure.heightAnchor.constraint(equalToConstant: buttonHeight),
            
            precipitation.settingsView.topAnchor.constraint(equalTo: pressure.settingsView.bottomAnchor, constant: 1),
            precipitation.settingsView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
            precipitation.settingsView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor),
            precipitation.heightAnchor.constraint(equalToConstant: buttonHeight),
            
            distance.settingsView.topAnchor.constraint(equalTo: precipitation.settingsView.bottomAnchor, constant: 1),
            distance.settingsView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
            distance.settingsView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor),
            distance.heightAnchor.constraint(equalToConstant: buttonHeight),
            
            timeFormat.settingsView.topAnchor.constraint(equalTo: distance.settingsView.bottomAnchor, constant: 1),
            timeFormat.settingsView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
            timeFormat.settingsView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor),
            timeFormat.heightAnchor.constraint(equalToConstant: buttonHeight)
        ])
    }
    
}
