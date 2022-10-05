//
//  Gradient_Model.swift
//  Sunny
//
//  Created by Nikita Pishchugin on 26.08.2022.
//

import UIKit

struct GradientModel {
    
    func getGradient(_ view: UIView, _ firstColor: UIColor?, _ secondColor: UIColor?, _ startPoint: CGPoint?, _ endPoint: CGPoint?) {
        
        guard let firstColor = firstColor,
              let secondColor = secondColor,
              let startPoint = startPoint,
              let endPoint = endPoint else { return }

        
        view.addGradient(firstColor, secondColor, startPoint, endPoint)
    }
    
}
