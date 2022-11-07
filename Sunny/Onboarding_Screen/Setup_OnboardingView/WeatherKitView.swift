//
//  WeatherKitView.swift
//  Sunny
//
//  Created by Nikita Pishchugin on 23.10.2022.
//

import UIKit

class WeatherKitView: UIView {
    
    let horizontalStack = UIStackView()
    let appleImage = UIImageView()
    let weatherKitLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpUI()
    }
    
    @objc private func didTapWeatherKit() {
        if let url = URL(string: "https://weatherkit.apple.com/legal-attribution.html") {
            UIApplication.shared.open(url)
        }
    }
    
    private func setUpUI() {
        self.addSubview(horizontalStack)
        
        horizontalStack.translateMask()
        
        horizontalStack.axis = .horizontal
        horizontalStack.distribution = .fillProportionally
        horizontalStack.spacing = 5
        
        NSLayoutConstraint.activate([
            horizontalStack.topAnchor.constraint(equalTo: self.topAnchor),
            horizontalStack.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            horizontalStack.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            horizontalStack.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        addContentToStackView()
    }
    
    private func addContentToStackView() {
        appleImage.translateMask()
        weatherKitLabel.translateMask()
        
        appleImage.image = UIImage(systemName: "applelogo")
        appleImage.tintColor = OnboardingColors.weatherKitText
        appleImage.contentMode = .scaleAspectFit
        
        weatherKitLabel.text = "Weather"
        weatherKitLabel.textColor = OnboardingColors.weatherKitText
        weatherKitLabel.font = UIFont.systemFont(ofSize: 16)
        weatherKitLabel.isUserInteractionEnabled = true
        
        horizontalStack.addArrangedSubview(appleImage)
        horizontalStack.addArrangedSubview(weatherKitLabel)
        
        weatherKitLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapWeatherKit)))
    }
}
