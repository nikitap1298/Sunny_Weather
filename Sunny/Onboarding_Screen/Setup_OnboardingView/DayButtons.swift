//
//  OnboardingReusableView.swift
//  Sunny
//
//  Created by Nikita Pishchugin on 15.08.2022.
//

import UIKit

// MARK: - DayButtons
class DayButtons: UIView {
    
    let stackView = UIStackView()
    let todayButton = UIButton()
    let nextTenDaysButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpUI()
    }
    
    private func setUpUI() {
        self.addSubview(stackView)
        
        stackView.translateMask()
        
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 100
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        addButtonsToStackView()
    }
    
    private func addButtonsToStackView() {
        todayButton.translateMask()
        nextTenDaysButton.translateMask()
        
        todayButton.setTitle("Now", for: .normal)
        todayButton.contentHorizontalAlignment = .center
        todayButton.setTitleColor(CustomColors.colorVanilla, for: .normal)
//        todayButton.backgroundColor = .white
        todayButton.titleLabel?.font = UIFont(name: CustomFonts.loraSemiBold, size: 16)
        stackView.addArrangedSubview(todayButton)
        
        nextTenDaysButton.setTitle("Next 7 Days", for: .normal)
        nextTenDaysButton.contentHorizontalAlignment = .center
        nextTenDaysButton.setTitleColor(CustomColors.colorDarkBlue1, for: .normal)
//        nexFiveDaysButton.backgroundColor = .white
        nextTenDaysButton.titleLabel?.font = UIFont(name: CustomFonts.loraSemiBold, size: 16)
        stackView.addArrangedSubview(nextTenDaysButton)
    }
}
