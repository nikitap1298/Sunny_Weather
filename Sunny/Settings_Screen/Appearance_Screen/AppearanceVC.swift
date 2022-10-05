//
//  AppearanceVC.swift
//  Sunny
//
//  Created by Nikita Pishchugin on 22.09.2022.
//

import UIKit

// MARK: - Enum AppearanceType
enum AppearanceType {
    case light
    case dark
    case system
}

class AppearanceVC: UIViewController {
    
    // MARK: - Private Properties
    private let customAppearanceView = CustomAppearanceView()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(named: CustomColors.colorVanilla)
        
        customNavigationBar()
        
        setUpUI()
    }
    
    // MARK: - Actions
    @objc private func didTapBackButton() {
        navigationController?.popViewControllerToRight()
    }
    
    @objc private func didTapHomeButton() {
        navigationController?.popToRootViewControllerToBottom()
    }
    
    @objc private func didTapLightButton() {
        buttonsLogic(for: .light)
    }
    
    @objc private func didTapDarkButton() {
        buttonsLogic(for: .dark)
    }
    
    @objc private func didTapSystemButton() {
        buttonsLogic(for: .system)
    }
    
    // MARK: - Private Functions
    private func setUpUI() {
        view.addSubview(customAppearanceView)
        
        customAppearanceView.translateMask()
        
        NSLayoutConstraint.activate([
            customAppearanceView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            customAppearanceView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            customAppearanceView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            customAppearanceView.heightAnchor.constraint(equalToConstant: 340)
        ])
        
        customAppearanceView.lightButton.addTarget(self, action: #selector(didTapLightButton), for: .touchUpInside)
        customAppearanceView.darkButton.addTarget(self, action: #selector(didTapDarkButton), for: .touchUpInside)
        customAppearanceView.systemButton.addTarget(self, action: #selector(didTapSystemButton), for: .touchUpInside)
    }
    
    private func buttonsLogic(for appearanceType: AppearanceType) {
        switch appearanceType {
        case .light:
            NotificationCenter.default.post(name: .init(rawValue: NotificationWords.lightMode), object: nil, userInfo: nil)
            
            customAppearanceView.lightButton.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
            customAppearanceView.darkButton.setImage(UIImage(systemName: "circle"), for: .normal)
            customAppearanceView.systemButton.setImage(UIImage(systemName: "circle"), for: .normal)
        case .dark:
            NotificationCenter.default.post(name: .init(rawValue: NotificationWords.darkMode), object: nil, userInfo: nil)
            
            customAppearanceView.lightButton.setImage(UIImage(systemName: "circle"), for: .normal)
            customAppearanceView.darkButton.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
            customAppearanceView.systemButton.setImage(UIImage(systemName: "circle"), for: .normal)
        case .system:
            NotificationCenter.default.post(name: .init(rawValue: NotificationWords.systemMode), object: nil, userInfo: nil)
            
            customAppearanceView.lightButton.setImage(UIImage(systemName: "circle"), for: .normal)
            customAppearanceView.darkButton.setImage(UIImage(systemName: "circle"), for: .normal)
            customAppearanceView.systemButton.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
        }
    }
    
}

// MARK: - AboutVC
private extension AppearanceVC {
    func customNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .clear
        navigationItem.title = "Appearance"
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor(named: CustomColors.colorGray) as Any,
            .font: UIFont(name: CustomFonts.nunitoBold, size: 26) ?? UIFont.systemFont(ofSize: 26)
        ]
        
        // Setup NavigationBar and remove bottom border
        navigationItem.standardAppearance = appearance
        
        // Disable back button
        navigationItem.setHidesBackButton(true, animated: true)
        
        // Custom left button
        let backButton = UIButton()
        backButton.customNavigationButton(UIImage(named: CustomImages.backLeft),
                                          UIColor(named: CustomColors.colorGray))
        let leftButton = UIBarButtonItem(customView: backButton)
        navigationItem.leftBarButtonItem = leftButton
        backButton.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
        
        // Custom right button
        let homeButton = UIButton()
        homeButton.customNavigationButton(UIImage(named: CustomImages.success),
                                          UIColor(named: CustomColors.colorGray))
        let rightButton = UIBarButtonItem(customView: homeButton)
        navigationItem.rightBarButtonItem = rightButton
        homeButton.addTarget(self, action: #selector(didTapHomeButton), for: .touchUpInside)
    }
}
