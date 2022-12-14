//
//  NowConditionView.swift
//  Sunny
//
//  Created by Nikita Pishchugin on 18.08.2022.
//

import UIKit

// MARK: - TodaySingleWeatherParameterTemplate
class TodaySingleWeatherParameterTemplate: UIView {
    
    let mainView = UIView()
    let parameterNameLabel = PaddingLabel(withInsets: 0, 0, 15, 0)
    let parameterValueLabel = UILabel()
    let parameterImage = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpUI()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    private func setUpUI() {
        self.addSubview(mainView)
        mainView.addSubview(parameterNameLabel)
        mainView.addSubview(parameterValueLabel)
        mainView.addSubview(parameterImage)
        
        mainView.translateMask()
        parameterNameLabel.translateMask()
        parameterValueLabel.translateMask()
        parameterImage.translateMask()
        
//        mainView.addShadow()
        mainView.backgroundColor = CustomColors.colorDarkBlue
        mainView.addCornerRadius()
        
        parameterNameLabel.textAlignment = .left
        parameterNameLabel.textColor = CustomColors.colorLightGray
        parameterNameLabel.font = UIFont(name: CustomFonts.loraMedium, size: 16)
        
        parameterValueLabel.textAlignment = .right
        parameterValueLabel.textColor = CustomColors.colorVanilla
        parameterValueLabel.font = UIFont(name: CustomFonts.loraSemiBold, size: 16)
        
        parameterImage.contentMode = .scaleAspectFit
        
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: self.topAnchor),
            mainView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            mainView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            parameterNameLabel.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 0),
            parameterNameLabel.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 0),
            parameterNameLabel.trailingAnchor.constraint(equalTo: mainView.centerXAnchor, constant: 0),
            parameterNameLabel.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: 0),
            
            parameterImage.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 10),
            parameterImage.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -10),
            parameterImage.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -10),
            parameterImage.widthAnchor.constraint(equalToConstant: 50),
            
            parameterValueLabel.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 0),
            parameterValueLabel.leadingAnchor.constraint(equalTo: mainView.centerXAnchor, constant: 0),
            parameterValueLabel.trailingAnchor.constraint(equalTo: parameterImage.leadingAnchor, constant: -10),
            parameterValueLabel.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: 0),
        ])
        
    }
}

// MARK: - TodayWeatherParameters
class TodayConditionView: UIView {
    
    private let buttonHeight: CGFloat = 45
    private let spacingForView: CGFloat = 5
    
    let mainView = UIView()
    
    let feelsLike = TodaySingleWeatherParameterTemplate()
    let rain = TodaySingleWeatherParameterTemplate()
    let clothes = TodaySingleWeatherParameterTemplate()
    let pressure = TodaySingleWeatherParameterTemplate()
    let humidity = TodaySingleWeatherParameterTemplate()
    let visibility = TodaySingleWeatherParameterTemplate()
    let windSpeed = TodaySingleWeatherParameterTemplate()
    let cloudCover = TodaySingleWeatherParameterTemplate()
    let uvIndex = TodaySingleWeatherParameterTemplate()
    
    // To apply gradient for each parameter
    var parameterArray = [TodaySingleWeatherParameterTemplate]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpUI()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews();
        self.mainView.layoutIfNeeded()
    }
    
    private func setUpUI() {
        self.addSubview(mainView)
        mainView.addSubview(feelsLike.mainView)
        mainView.addSubview(rain.mainView)
        mainView.addSubview(clothes.mainView)
        mainView.addSubview(pressure.mainView)
        mainView.addSubview(humidity.mainView)
        mainView.addSubview(visibility.mainView)
        mainView.addSubview(windSpeed.mainView)
        mainView.addSubview(cloudCover.mainView)
        mainView.addSubview(uvIndex.mainView)
        
        mainView.translateMask()
        
        mainView.backgroundColor = .clear
        
        feelsLike.parameterNameLabel.text = "Feels like"
        feelsLike.parameterImage.image = ConditionImages.thermometerHot
        
        rain.parameterNameLabel.text = "Precipitation"
        rain.parameterImage.image = ConditionImages.rainfall
        
        clothes.parameterNameLabel.text = "Clothes"
        clothes.parameterImage.image =  Clothes.hoodie
        
        pressure.parameterNameLabel.text = "Pressure"
        pressure.parameterImage.image = ConditionImages.pressure
        
        humidity.parameterNameLabel.text = "Humidity"
        humidity.parameterImage.image = ConditionImages.humidity
        
        visibility.parameterNameLabel.text = "Visibility"
        visibility.parameterImage.image = ConditionImages.visibility
        
        windSpeed.parameterNameLabel.text = "Wind"
        windSpeed.parameterImage.image = ConditionImages.windDirection
        
        cloudCover.parameterNameLabel.text = "Cloud cover"
        cloudCover.parameterImage.image = ConditionImages.cloud
        
        uvIndex.parameterNameLabel.text = "UV index"
        uvIndex.parameterImage.image = ConditionImages.uvGreen
        
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: self.topAnchor),
            mainView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            mainView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            feelsLike.mainView.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 0),
            feelsLike.mainView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 0),
            feelsLike.mainView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: 0),
            feelsLike.mainView.heightAnchor.constraint(equalToConstant: buttonHeight),
            
            rain.mainView.topAnchor.constraint(equalTo: feelsLike.mainView.bottomAnchor, constant: spacingForView),
            rain.mainView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 0),
            rain.mainView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: 0),
            rain.mainView.heightAnchor.constraint(equalToConstant: buttonHeight),
            
            clothes.mainView.topAnchor.constraint(equalTo: rain.mainView.bottomAnchor, constant: spacingForView),
            clothes.mainView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 0),
            clothes.mainView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: 0),
            clothes.mainView.heightAnchor.constraint(equalToConstant: buttonHeight),
            
            pressure.mainView.topAnchor.constraint(equalTo: clothes.mainView.bottomAnchor, constant: spacingForView),
            pressure.mainView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 0),
            pressure.mainView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: 0),
            pressure.mainView.heightAnchor.constraint(equalToConstant: buttonHeight),
            
            humidity.mainView.topAnchor.constraint(equalTo: pressure.mainView.bottomAnchor, constant: spacingForView),
            humidity.mainView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 0),
            humidity.mainView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: 0),
            humidity.mainView.heightAnchor.constraint(equalToConstant: buttonHeight),
            
            visibility.mainView.topAnchor.constraint(equalTo: humidity.mainView.bottomAnchor, constant: spacingForView),
            visibility.mainView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 0),
            visibility.mainView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: 0),
            visibility.mainView.heightAnchor.constraint(equalToConstant: buttonHeight),
            
            windSpeed.mainView.topAnchor.constraint(equalTo: visibility.mainView.bottomAnchor, constant: spacingForView),
            windSpeed.mainView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 0),
            windSpeed.mainView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: 0),
            windSpeed.mainView.heightAnchor.constraint(equalToConstant: buttonHeight),
            
            cloudCover.mainView.topAnchor.constraint(equalTo: windSpeed.mainView.bottomAnchor, constant: spacingForView),
            cloudCover.mainView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 0),
            cloudCover.mainView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: 0),
            cloudCover.mainView.heightAnchor.constraint(equalToConstant: buttonHeight),
            
            uvIndex.mainView.topAnchor.constraint(equalTo: cloudCover.mainView.bottomAnchor, constant: spacingForView),
            uvIndex.mainView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 0),
            uvIndex.mainView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: 0),
            uvIndex.mainView.heightAnchor.constraint(equalToConstant: buttonHeight)
        ])
        
        parameterArray.append(feelsLike)
        parameterArray.append(rain)
        parameterArray.append(clothes)
        parameterArray.append(pressure)
        parameterArray.append(humidity)
        parameterArray.append(visibility)
        parameterArray.append(windSpeed)
        parameterArray.append(cloudCover)
        parameterArray.append(uvIndex)
    }
}
