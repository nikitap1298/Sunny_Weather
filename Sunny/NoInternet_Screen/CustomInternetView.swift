//
//  CustomInternetView.swift
//  Sunny
//
//  Created by Nikita Pishchugin on 20.09.2022.
//

import UIKit

class CustomIntentetView: UIView {
    
    let stackView = UIStackView()
    let imageView = UIImageView()
    let textLabelFirst = UILabel()
    let textLabelSecond = UILabel()
    let goToDeviceSettingsButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpUI()
    }
    
    private func setUpUI() {
        self.addSubview(stackView)
        
        stackView.translateMask()
        
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
        
        setUpStackView()
    }
    
    private func setUpStackView() {
        imageView.translateMask()
        textLabelFirst.translateMask()
        textLabelSecond.translateMask()
        goToDeviceSettingsButton.translateMask()
        
        imageView.image = UIImage(systemName: "wifi.slash")
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = UIColor(named: CustomColors.colorGray)
        
        textLabelFirst.text = "Weather Unavailable"
        textLabelFirst.textAlignment = .center
        textLabelFirst.textColor = UIColor(named: CustomColors.colorVanilla)
        textLabelFirst.font = UIFont(name: CustomFonts.nunitoBold, size: 22)
        
        textLabelSecond.text = "The Sunny app isn't connected to the internet. To view weather, check your connection, then restart the app."
        textLabelSecond.textAlignment = .center
        textLabelSecond.numberOfLines = 3
        textLabelSecond.lineBreakMode = .byWordWrapping
        textLabelSecond.textColor = UIColor(named: CustomColors.colorGray)
        textLabelSecond.font = UIFont(name: CustomFonts.loraMedium, size: 15)
        
        goToDeviceSettingsButton.setTitle("Go to Settings", for: .normal)
        goToDeviceSettingsButton.tintColor = UIColor(named: CustomColors.colorVanilla)
        goToDeviceSettingsButton.titleLabel?.font = UIFont(name: CustomFonts.loraMedium, size: 15)
        
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(textLabelFirst)
        stackView.addArrangedSubview(textLabelSecond)
        stackView.addArrangedSubview(goToDeviceSettingsButton)
    }
}
