//
//  UIButtonExtension.swift
//  Sunny
//
//  Created by Nikita Pishchugin on 20.09.2022.
//

import UIKit

extension UIButton {
    
    // Template for button in NavigationController
    func customNavigationButton(_ image: UIImage?, _ tintColor: UIColor?) {
        self.setImage(image, for: .normal)
        self.tintColor = tintColor
        self.translateMask()
    }
}

