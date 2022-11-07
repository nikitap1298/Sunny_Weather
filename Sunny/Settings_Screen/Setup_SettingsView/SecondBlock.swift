//
//  SecondBlock.swift
//  Sunny
//
//  Created by Nikita Pishchugin on 17.09.2022.
//

import UIKit

class SecondBlock: UIView {
    
    private let buttonHeight: CGFloat = 50
    
    let mainView = UIView()
    
    let appearance = CustomSecondBlockButtons()
    let subscribe = CustomSecondBlockButtons()
    let about = CustomSecondBlockButtons()
    let rateUS = CustomSecondBlockButtons()
    let contactUS = CustomSecondBlockButtons()
    
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
        mainView.addSubview(appearance)
        mainView.addSubview(subscribe)
        mainView.addSubview(about)
        mainView.addSubview(rateUS)
        mainView.addSubview(contactUS)
        
        self.translateMask()
        mainView.translateMask()
        appearance.translateMask()
        subscribe.translateMask()
        about.translateMask()
        rateUS.translateMask()
        contactUS.translateMask()
        
        mainView.backgroundColor = SettingsColors.blockAndText
        
        appearance.titleLabel.text = "Appearance"
        appearance.imageView.image = UIImages.iphone
        
        subscribe.titleLabel.text = "Subscribe"
        subscribe.imageView.image = UIImages.buy
        
        about.titleLabel.text = "About"
        about.imageView.image = UIImages.info
        
        rateUS.titleLabel.text = "Rate Us"
        rateUS.imageView.image = UIImages.like
        
        contactUS.titleLabel.text = "Contact Us"
        contactUS.imageView.image = UIImages.mail_3
        
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: self.topAnchor),
            mainView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            mainView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            appearance.buttonView.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 1),
            appearance.buttonView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
            appearance.buttonView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor),
            appearance.buttonView.heightAnchor.constraint(equalToConstant: buttonHeight),
            
            subscribe.buttonView.topAnchor.constraint(equalTo: appearance.bottomAnchor, constant: 1),
            subscribe.buttonView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
            subscribe.buttonView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor),
            subscribe.buttonView.heightAnchor.constraint(equalToConstant: buttonHeight),
            
            about.buttonView.topAnchor.constraint(equalTo: subscribe.bottomAnchor, constant: 1),
            about.buttonView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
            about.buttonView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor),
            about.buttonView.heightAnchor.constraint(equalToConstant: buttonHeight),
            
            rateUS.buttonView.topAnchor.constraint(equalTo: about.bottomAnchor, constant: 1),
            rateUS.buttonView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
            rateUS.buttonView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor),
            rateUS.buttonView.heightAnchor.constraint(equalToConstant: buttonHeight),
            
            contactUS.buttonView.topAnchor.constraint(equalTo: rateUS.bottomAnchor, constant: 1),
            contactUS.buttonView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
            contactUS.buttonView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor),
            contactUS.buttonView.heightAnchor.constraint(equalToConstant: buttonHeight)
        ])
    }
}
