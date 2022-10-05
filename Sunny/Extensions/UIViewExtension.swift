//
//  UIViewExtension.swift
//  Sunny
//
//  Created by Nikita Pishchugin on 25.07.2022.
//

import UIKit

extension UIView {
    
    // Add shadows
    func addShadow(shadowColor: UIColor = .black, offset: CGSize = .init(width: 10.0, height: 0.0), opacity: Float = 0.35, radius: CGFloat = 8) {
        layer.shadowColor = shadowColor.cgColor
        layer.shadowOffset = offset
        layer.shadowOpacity = opacity
        layer.shadowRadius = radius
    }
    
    // Corner radius
    func addCornerRadius() {
        layer.cornerRadius = 20
    }
    
    // Add Blur
    func addBlurView(style: UIBlurEffect.Style) {
        var blurEffectView = UIVisualEffectView()
        let blurEffect = UIBlurEffect(style: style)
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = bounds
        addSubview(blurEffectView)
    }
    
    // Remove Blur
    func removeBlur() {
        for view in self.subviews {
            if let view = view as? UIVisualEffectView {
                view.removeFromSuperview()
            }
        }
    }
    
    // Shake Animation
    func shake() {
        let animation = CABasicAnimation(keyPath: "transform.translation.x")
        animation.duration = 0.05
        animation.repeatCount = 4
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 20, y: self.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + 0, y: self.center.y))
        layer.add(animation, forKey: "shake")
    }
    
    // Gradient
    func addGradient(_ firstColor: UIColor,
                     _ secondColor: UIColor,
                     _ startPoint: CGPoint = CGPoint(x: 0, y: 0),
                     _ endPoint: CGPoint = CGPoint(x: 0.8, y: 1)) {
        
        // Создание гридиентновго слоя
        let gradient = CAGradientLayer()
        
        // Перечисляем цвета градиента
        gradient.colors = [firstColor.cgColor, secondColor.cgColor]
        
        // Задаем стартовую и конечную точки. (0 0) - левый верхний угол, а (1 1) - правый нижний
        gradient.startPoint = startPoint
        gradient.endPoint = endPoint
        
        gradient.locations = [0, 1]
        
        gradient.frame = bounds
        
        gradient.cornerRadius = layer.cornerRadius
        
        // Добавляем градиент к нашему вью
        layer.insertSublayer(gradient, at: 0)
    }
    
    func translateMask() {
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}

