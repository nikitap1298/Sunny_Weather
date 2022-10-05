//
//  AboutReusableView.swift
//  Sunny
//
//  Created by Nikita Pishchugin on 11.08.2022.
//

import UIKit

class CustomAboutButtons: UIView {
    
    let buttonView = UIView()
    let titleLabel = PaddingLabel(withInsets: 0, 0, 15, 0)
    let textLabel = PaddingLabel(withInsets: 0, 0, 15, 0)
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
        buttonView.addSubview(textLabel)
        buttonView.addSubview(imageView)
        
        buttonView.translateMask()
        titleLabel.translateMask()
        textLabel.translateMask()
        imageView.translateMask()
        
        buttonView.backgroundColor = UIColor(named: CustomColors.colorVanilla)
        
        titleLabel.textAlignment = .left
        titleLabel.textColor = UIColor(named: CustomColors.colorGray)
        titleLabel.font = UIFont(name: CustomFonts.loraMedium, size: 20)
        
        textLabel.textAlignment = .right
        textLabel.textColor = UIColor(named: CustomColors.colorGray)
        textLabel.font = UIFont(name: CustomFonts.loraRegular, size: 20)
        
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
            titleLabel.widthAnchor.constraint(equalToConstant: 150),
            
            imageView.topAnchor.constraint(equalTo: buttonView.topAnchor, constant: 12),
            imageView.trailingAnchor.constraint(equalTo: buttonView.trailingAnchor, constant: -10),
            imageView.bottomAnchor.constraint(equalTo: buttonView.bottomAnchor, constant: -12),
            imageView.widthAnchor.constraint(equalToConstant: 50),
            
            textLabel.topAnchor.constraint(equalTo: buttonView.topAnchor, constant: 0),
            textLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 0),
            textLabel.trailingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 0),
            textLabel.bottomAnchor.constraint(equalTo: buttonView.bottomAnchor, constant: 0),
        ])
    }
}
