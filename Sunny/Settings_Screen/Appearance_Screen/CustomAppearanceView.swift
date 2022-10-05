//
//  CustomAppearanceView.swift
//  Sunny
//
//  Created by Nikita Pishchugin on 22.09.2022.
//

import UIKit

class CustomAppearanceView: UIView {
    
    let mainView = UIView()
    
    let stackOne = UIStackView()
    let lightImage = UIImageView()
    let lightLabel = UILabel()
    let lightButton = UIButton()
    
    let stackTwo = UIStackView()
    let darkImage = UIImageView()
    let darkLabel = UILabel()
    let darkButton = UIButton()
    
    let stackThree = UIStackView()
    let systemImage = UIImageView()
    let systemLabel = UILabel()
    let systemButton = UIButton()
    
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
        mainView.addSubview(stackOne)
        mainView.addSubview(stackTwo)
        mainView.addSubview(stackThree)
        
        mainView.translateMask()
        stackOne.translateMask()
        stackTwo.translateMask()
        stackThree.translateMask()
        
        mainView.addCornerRadius()
//        mainView.backgroundColor = UIColor(named: CustomColors.colorLightGray)
        
        stackOne.axis = .vertical
        stackOne.distribution = .equalSpacing
        stackOne.spacing = 20
        
        stackTwo.axis = .vertical
        stackTwo.distribution = .equalSpacing
        stackTwo.spacing = 20
        
        stackThree.axis = .vertical
        stackThree.distribution = .equalSpacing
        stackThree.spacing = 20
        
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: self.topAnchor),
            mainView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            mainView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            stackTwo.centerXAnchor.constraint(equalTo: mainView.centerXAnchor),
            stackTwo.centerYAnchor.constraint(equalTo: mainView.centerYAnchor),
            stackTwo.widthAnchor.constraint(equalToConstant: 100),
            stackTwo.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 20),
            stackTwo.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -20),
            
            stackOne.centerYAnchor.constraint(equalTo: mainView.centerYAnchor),
            stackOne.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 20),
            stackOne.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -20),
            stackOne.trailingAnchor.constraint(equalTo: stackTwo.leadingAnchor, constant: -20),
            stackOne.widthAnchor.constraint(equalToConstant: 100),
            
            stackThree.centerYAnchor.constraint(equalTo: mainView.centerYAnchor),
            stackThree.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 20),
            stackThree.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -20),
            stackThree.leadingAnchor.constraint(equalTo: stackTwo.trailingAnchor, constant: 20),
            stackThree.widthAnchor.constraint(equalToConstant: 100)
        ])
        
        setUpStackOne()
        setUpStackTwo()
        setUpStackThree()
    }
    
    private func setUpStackOne() {
        lightImage.translateMask()
        lightLabel.translateMask()
        lightButton.translateMask()
        
        lightImage.image = UIImage(named: "LightMode")
        lightImage.contentMode = .scaleAspectFit
        
        lightLabel.text = "Light"
        lightLabel.textAlignment = .center
        lightLabel.font = UIFont(name: CustomFonts.loraMedium, size: 16)
        lightLabel.textColor = UIColor(named: CustomColors.colorDarkBlue1)
        
        lightButton.setImage(UIImage(systemName: "circle"), for: .normal)
        lightButton.tintColor = UIColor(named: CustomColors.colorDarkBlue1)
        
        stackOne.addArrangedSubview(lightImage)
        stackOne.addArrangedSubview(lightLabel)
        stackOne.addArrangedSubview(lightButton)
    }
    
    private func setUpStackTwo() {
        darkImage.translateMask()
        darkLabel.translateMask()
        darkButton.translateMask()
        
        darkImage.image = UIImage(named: "DarkMode")
        darkImage.contentMode = .scaleAspectFit
        
        darkLabel.text = "Dark"
        darkLabel.textAlignment = .center
        darkLabel.font = UIFont(name: CustomFonts.loraMedium, size: 16)
        darkLabel.textColor = UIColor(named: CustomColors.colorDarkBlue1)
        
        darkButton.setImage(UIImage(systemName: "circle"), for: .normal)
        darkButton.tintColor = UIColor(named: CustomColors.colorDarkBlue1)
        
        stackTwo.addArrangedSubview(darkImage)
        stackTwo.addArrangedSubview(darkLabel)
        stackTwo.addArrangedSubview(darkButton)
    }
    
    private func setUpStackThree() {
        systemImage.translateMask()
        systemLabel.translateMask()
        systemButton.translateMask()
        
        systemImage.image = UIImage(named: "SystemMode")
        systemImage.contentMode = .scaleAspectFit
        
        systemLabel.text = "System"
        systemLabel.textAlignment = .center
        systemLabel.font = UIFont(name: CustomFonts.loraMedium, size: 16)
        systemLabel.textColor = UIColor(named: CustomColors.colorDarkBlue1)
        
        systemButton.setImage(UIImage(systemName: "circle"), for: .normal)
        systemButton.tintColor = UIColor(named: CustomColors.colorDarkBlue1)
        
        stackThree.addArrangedSubview(systemImage)
        stackThree.addArrangedSubview(systemLabel)
        stackThree.addArrangedSubview(systemButton)
    }
}
