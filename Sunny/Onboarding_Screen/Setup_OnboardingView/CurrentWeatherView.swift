//
//  CurrentWeatherView.swift
//  Sunny
//
//  Created by Nikita Pishchugin on 26.08.2022.
//

import UIKit

class CurrentWeatherView: UIView {
    
    let mainView = UIView()
    let dateLabel = UILabel()
    let temperatureLabel = UILabel()
    let temperatureImage = UIImageView()
    let descriptionLabel = UILabel()
    let cityView = UIView()
    let cityImage = UIImageView()
    let cityNameLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpUI()
    }
    
    private func setUpUI() {
        
        self.addSubview(mainView)
        mainView.addSubview(dateLabel)
        mainView.addSubview(temperatureLabel)
        mainView.addSubview(temperatureImage)
        mainView.addSubview(descriptionLabel)
        mainView.addSubview(cityView)
        cityView.addSubview(cityImage)
        cityView.addSubview(cityNameLabel)
        
        mainView.translateMask()
        dateLabel.translateMask()
        temperatureLabel.translateMask()
        temperatureImage.translateMask()
        descriptionLabel.translateMask()
        cityView.translateMask()
        cityImage.translateMask()
        cityNameLabel.translateMask()
        
        mainView.backgroundColor = .clear
        
        dateLabel.textAlignment = .left
        dateLabel.textColor = CustomColors.colorRed
        dateLabel.font = UIFont(name: CustomFonts.loraMedium, size: 16)
        
        temperatureLabel.textAlignment = .left
        temperatureLabel.textColor = CustomColors.colorVanilla
        temperatureLabel.font = UIFont(name: CustomFonts.loraBold, size: 45)
        
        temperatureImage.contentMode = .scaleAspectFit
        
        descriptionLabel.textAlignment = .center
        descriptionLabel.textColor = CustomColors.colorVanilla
        descriptionLabel.font = UIFont(name: CustomFonts.loraMedium, size: 16)
        
        cityImage.image = UIImages.location_2
        cityImage.tintColor = CustomColors.colorVanilla
        
        cityNameLabel.textAlignment = .left
        cityNameLabel.text = "City"
        cityNameLabel.textColor = CustomColors.colorVanilla
        cityNameLabel.font = UIFont(name: CustomFonts.loraMedium, size: 16)
        
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: self.topAnchor),
            mainView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            mainView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            temperatureLabel.centerYAnchor.constraint(equalTo: mainView.centerYAnchor),
            temperatureLabel.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 15),
            temperatureLabel.trailingAnchor.constraint(equalTo: mainView.centerXAnchor, constant: 0),
            temperatureLabel.heightAnchor.constraint(equalToConstant: 50),
            
            temperatureImage.centerYAnchor.constraint(equalTo: temperatureLabel.topAnchor),
            temperatureImage.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -40),
            temperatureImage.widthAnchor.constraint(equalToConstant: 70),
            temperatureImage.heightAnchor.constraint(equalToConstant: 70),
            
            descriptionLabel.centerXAnchor.constraint(equalTo: temperatureImage.centerXAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: temperatureImage.bottomAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: 0),
            descriptionLabel.bottomAnchor.constraint(equalTo: cityView.topAnchor, constant: 0),

            dateLabel.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 10),
            dateLabel.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 15),
            dateLabel.trailingAnchor.constraint(equalTo: mainView.centerXAnchor, constant: 0),
            dateLabel.bottomAnchor.constraint(equalTo: temperatureLabel.topAnchor, constant: -30),

            cityView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 15),
            cityView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -15),
            cityView.topAnchor.constraint(equalTo: temperatureLabel.bottomAnchor, constant: 30),
            cityView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -10),

            cityImage.leadingAnchor.constraint(equalTo: cityView.leadingAnchor, constant: 0),
            cityImage.centerYAnchor.constraint(equalTo: cityView.centerYAnchor),
            cityImage.widthAnchor.constraint(equalToConstant: 15),
            cityImage.heightAnchor.constraint(equalToConstant: 15),

            cityNameLabel.centerYAnchor.constraint(equalTo: cityView.centerYAnchor),
            cityNameLabel.leadingAnchor.constraint(equalTo: cityImage.trailingAnchor, constant: 15),
            cityNameLabel.trailingAnchor.constraint(equalTo: cityView.trailingAnchor, constant: 0)
        ])
    }
}
