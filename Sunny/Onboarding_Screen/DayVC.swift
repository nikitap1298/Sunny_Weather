//
//  DayVC.swift
//  Sunny
//
//  Created by Nikita Pishchugin on 31.10.2022.
//

import UIKit

class DayVC: UIViewController {
    
    // MARK: - Public Properties
    var cellDate = ""
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customNavigationBar()
        navigationItem.title = cellDate
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        view.addGradient(OnboardingColors.backgroundTop,
                         OnboardingColors.backgroundBottom)
    }
    
    // MARK: - Actions
    @objc private func didTapBackButton() {
        navigationController?.popViewControllerToRight()
    }
    
}

// MARK: - DayVC
private extension DayVC {
    func customNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .clear
        navigationItem.title = "Day"
        appearance.titleTextAttributes = [
            .foregroundColor: CustomColors.colorVanilla as Any,
            .font: UIFont(name: CustomFonts.nunitoBold, size: 26) ?? UIFont.systemFont(ofSize: 26)
        ]
        
        // Setup NavigationBar and remove bottom border
        navigationItem.standardAppearance = appearance
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        // Disable Back button
        navigationItem.setHidesBackButton(true, animated: true)
        
        // Custom Left Button
        let backButton = UIButton()
        backButton.customNavigationButton(UIImages.backLeft,
                                          CustomColors.colorVanilla)
        let leftButton = UIBarButtonItem(customView: backButton)
        navigationItem.leftBarButtonItem = leftButton
        backButton.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
    }
}
