//
//  SettingsReusableView.swift
//  Sunny
//
//  Created by Nikita Pishchugin on 11.08.2022.
//

import UIKit

// View for Temperature, Wind Speed, Pressure in SettingsVC
class CustomFirstBlockButtons: UIView {
    
    let settingsView = UIView()
    let settingsLabel = PaddingLabel(withInsets: 0, 0, 15, 0)
    let valuesView = UIView()
    let leftValueLabel = UILabel()
    let rightValueLabel = UILabel()
    let swithView = UIView()
    
    var swithViewLeadingAnchor: NSLayoutConstraint?
    var swithViewTrailingAnhor: NSLayoutConstraint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpUI()
    }
    
    private func setUpUI() {
        self.addSubview(settingsView)
        settingsView.addSubview(settingsLabel)
        settingsView.addSubview(valuesView)
        valuesView.addSubview(leftValueLabel)
        valuesView.addSubview(rightValueLabel)
        valuesView.addSubview(swithView)
        
        settingsView.translateMask()
        settingsLabel.translateMask()
        valuesView.translateMask()
        leftValueLabel.translateMask()
        rightValueLabel.translateMask()
        swithView.translateMask()
        
        settingsView.backgroundColor = UIColor(named: CustomColors.colorVanilla)
        
        settingsLabel.textAlignment = .left
        settingsLabel.textColor = UIColor(named: CustomColors.colorGray)
        settingsLabel.font = UIFont(name: CustomFonts.loraMedium, size: 20)
        
        valuesView.backgroundColor = UIColor(named: CustomColors.colorLightGray)
        valuesView.layer.cornerRadius = 10
        
        leftValueLabel.textAlignment = .center
        leftValueLabel.textColor = UIColor(named: CustomColors.colorGray)
        leftValueLabel.font = UIFont(name: CustomFonts.loraMedium, size: 17)
        
        rightValueLabel.textAlignment = .center
        rightValueLabel.textColor = UIColor(named: CustomColors.colorGray)
        rightValueLabel.font = UIFont(name: CustomFonts.loraMedium, size: 17)
        
        swithView.layer.cornerRadius = 10
        swithView.backgroundColor = UIColor(named: CustomColors.colorBlue1)?.withAlphaComponent(0.35)
        
        NSLayoutConstraint.activate([
            settingsView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            settingsView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            settingsView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            settingsView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
            
            settingsLabel.topAnchor.constraint(equalTo: settingsView.topAnchor, constant: 0),
            settingsLabel.leadingAnchor.constraint(equalTo: settingsView.leadingAnchor, constant: 0),
            settingsLabel.bottomAnchor.constraint(equalTo: settingsView.bottomAnchor, constant: 0),
            settingsLabel.widthAnchor.constraint(equalToConstant: 200),
            
            valuesView.topAnchor.constraint(equalTo: settingsView.topAnchor, constant: 10),
            valuesView.trailingAnchor.constraint(equalTo: settingsView.trailingAnchor, constant: -20),
            valuesView.bottomAnchor.constraint(equalTo: settingsView.bottomAnchor, constant: -10),
            valuesView.widthAnchor.constraint(equalToConstant: 132),
            
            leftValueLabel.topAnchor.constraint(equalTo: valuesView.topAnchor),
            leftValueLabel.leadingAnchor.constraint(equalTo: valuesView.leadingAnchor),
            leftValueLabel.bottomAnchor.constraint(equalTo: valuesView.bottomAnchor),
            leftValueLabel.widthAnchor.constraint(equalToConstant: 66),
            
            rightValueLabel.topAnchor.constraint(equalTo: valuesView.topAnchor),
            rightValueLabel.trailingAnchor.constraint(equalTo: valuesView.trailingAnchor),
            rightValueLabel.bottomAnchor.constraint(equalTo: valuesView.bottomAnchor),
            rightValueLabel.widthAnchor.constraint(equalToConstant: 66),
            
            swithView.topAnchor.constraint(equalTo: valuesView.topAnchor),
            swithView.bottomAnchor.constraint(equalTo: valuesView.bottomAnchor),
            swithView.widthAnchor.constraint(equalToConstant: 66)
        ])
        
        swithViewLeadingAnchor = swithView.leadingAnchor.constraint(equalTo: valuesView.leadingAnchor)
        swithViewTrailingAnhor = swithView.trailingAnchor.constraint(equalTo: valuesView.trailingAnchor)
        
        guard let swithViewLeadingAnchor = swithViewLeadingAnchor,
              let swithViewTrailingAnhor = swithViewTrailingAnhor else {
            return
        }
        
        swithViewLeadingAnchor.isActive = true
        swithViewTrailingAnhor.isActive = false
    }
}

// MARK: - ReusableCustomButton
// Common buttons in SettingsVC
class CustomSecondBlockButtons: UIView {
    
    let buttonView = UIView()
    let titleLabel = PaddingLabel(withInsets: 0, 0, 15, 0)
    let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpUI()
    }
    
    private func setUpUI() {
        self.addSubview(buttonView)
        buttonView.addSubview(titleLabel)
        buttonView.addSubview(imageView)
        
        buttonView.translateMask()
        titleLabel.translateMask()
        imageView.translateMask()
        
        buttonView.backgroundColor = UIColor(named: CustomColors.colorVanilla)
        
        titleLabel.textAlignment = .left
        titleLabel.textColor = UIColor(named: CustomColors.colorGray)
        titleLabel.font = UIFont(name: CustomFonts.loraMedium, size: 20)
        
        imageView.tintColor = UIColor(named: CustomColors.colorGray)
        imageView.contentMode = .scaleAspectFit
        
        NSLayoutConstraint.activate([
            buttonView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            buttonView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            buttonView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            buttonView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
            
            titleLabel.topAnchor.constraint(equalTo: buttonView.topAnchor, constant: 0),
            titleLabel.leadingAnchor.constraint(equalTo: buttonView.leadingAnchor, constant: 0),
            titleLabel.bottomAnchor.constraint(equalTo: buttonView.bottomAnchor, constant: 0),
            titleLabel.widthAnchor.constraint(equalToConstant: 200),
            
            imageView.topAnchor.constraint(equalTo: buttonView.topAnchor, constant: 12),
            imageView.trailingAnchor.constraint(equalTo: buttonView.trailingAnchor, constant: -10),
            imageView.bottomAnchor.constraint(equalTo: buttonView.bottomAnchor, constant: -12),
            imageView.widthAnchor.constraint(equalToConstant: 50)
        ])
    }
}
