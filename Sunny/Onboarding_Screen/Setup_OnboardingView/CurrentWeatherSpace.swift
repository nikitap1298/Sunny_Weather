//
//  CurrentWeatherSpace.swift
//  Sunny
//
//  Created by Nikita Pishchugin on 18.09.2022.
//

import UIKit

class CurrentWeatherSpace: UIView {
    
    let mainView = UIView()
    
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
        mainView.translateMask()
        
        mainView.layer.cornerRadius = 25
        // Doesn't work :(
        mainView.layer.maskedCorners = [.layerMaxXMaxYCorner]
        
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: self.topAnchor),
            mainView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            mainView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
}
