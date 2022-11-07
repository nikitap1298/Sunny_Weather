//
//  AppearanceVC.swift
//  Sunny
//
//  Created by Nikita Pishchugin on 22.09.2022.
//

import UIKit
import SPIndicator

// MARK: - Enum AppearanceType
enum AppearanceType {
    case light
    case dark
    case system
}

class AppearanceVC: UIViewController {
    
    // MARK: - Private Properties
    private let customAppearanceView = CustomAppearanceView()
    
    private var lightIsSelected: Bool = true
    private var darkIsSelected: Bool = false
    private var systemIsSelected: Bool = false
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = SettingsColors.backgroungWhite
        
        setUpSwipeGestureRecognizer()
        customNavigationBar()
        setUpUI()
        selectedButton()
    }
    
    // MARK: - Actions
    @objc private func didTapBackButton() {
        navigationController?.popViewControllerToRight()
    }
    
    @objc private func didTapHomeButton() {
        navigationController?.popToRootViewControllerToBottom()
    }
    
    @objc private func didSwipeRight(_ recognizer: UISwipeGestureRecognizer) {
        if recognizer.state == .ended {
            navigationController?.popViewControllerToRight()
        }
    }
    
    @objc private func didTapLightButton() {
        buttonsLogic(for: .light)
        showRestartIndicator()
    }
    
    @objc private func didTapDarkButton() {
        buttonsLogic(for: .dark)
        showRestartIndicator()
    }
    
    @objc private func didTapSystemButton() {
        buttonsLogic(for: .system)
        showRestartIndicator()
    }
    
    // MARK: - Private Functions
    private func setUpSwipeGestureRecognizer() {
        let swipeGestureRecognizer = UISwipeGestureRecognizer()
        swipeGestureRecognizer.addTarget(self, action: #selector(didSwipeRight(_ :)))
        swipeGestureRecognizer.direction = .right
        view.addGestureRecognizer(swipeGestureRecognizer)
    }
    
    private func setUpUI() {
        view.addSubview(customAppearanceView)
        
        customAppearanceView.translateMask()
        
        NSLayoutConstraint.activate([
            customAppearanceView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            customAppearanceView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            customAppearanceView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            customAppearanceView.heightAnchor.constraint(equalToConstant: 300)
        ])
        
        customAppearanceView.lightButton.addTarget(self, action: #selector(didTapLightButton), for: .touchUpInside)
        customAppearanceView.darkButton.addTarget(self, action: #selector(didTapDarkButton), for: .touchUpInside)
        customAppearanceView.systemButton.addTarget(self, action: #selector(didTapSystemButton), for: .touchUpInside)
    }
    
    private func buttonsLogic(for appearanceType: AppearanceType) {
        switch appearanceType {
        case .light:
            NotificationCenter.default.post(name: NotificationNames.lightMode, object: nil, userInfo: nil)
            
            customAppearanceView.lightButton.setImage(SFSymbols.circleFill, for: .normal)
            customAppearanceView.darkButton.setImage(SFSymbols.circle, for: .normal)
            customAppearanceView.systemButton.setImage(SFSymbols.circle, for: .normal)
            
            lightIsSelected = true
            darkIsSelected = false
            systemIsSelected = false
        case .dark:
            NotificationCenter.default.post(name: NotificationNames.darkMode, object: nil, userInfo: nil)
            
            customAppearanceView.lightButton.setImage(SFSymbols.circle, for: .normal)
            customAppearanceView.darkButton.setImage(SFSymbols.circleFill, for: .normal)
            customAppearanceView.systemButton.setImage(SFSymbols.circle, for: .normal)
            
            lightIsSelected = false
            darkIsSelected = true
            systemIsSelected = false
        case .system:
            NotificationCenter.default.post(name: NotificationNames.systemMode, object: nil, userInfo: nil)
            
            customAppearanceView.lightButton.setImage(SFSymbols.circle, for: .normal)
            customAppearanceView.darkButton.setImage(SFSymbols.circle, for: .normal)
            customAppearanceView.systemButton.setImage(SFSymbols.circleFill, for: .normal)
            
            lightIsSelected = false
            darkIsSelected = false
            systemIsSelected = true
        }
        
        UserDefaults.standard.set(lightIsSelected, forKey: UserDefaultsKeys.lightMode)
        UserDefaults.standard.set(darkIsSelected, forKey: UserDefaultsKeys.darkMode)
        UserDefaults.standard.set(systemIsSelected, forKey: UserDefaultsKeys.systemMode)
    }
    
    private func selectedButton() {
        
        let light = UserDefaults.standard.value(forKey: UserDefaultsKeys.lightMode) as? Bool
        let dark = UserDefaults.standard.value(forKey: UserDefaultsKeys.darkMode) as? Bool
        let system = UserDefaults.standard.value(forKey: UserDefaultsKeys.systemMode) as? Bool
        
        lightIsSelected = light ?? true
        darkIsSelected = dark ?? false
        systemIsSelected = system ?? false
        
        if lightIsSelected {
            customAppearanceView.lightButton.setImage(SFSymbols.circleFill, for: .normal)
        } else if darkIsSelected {
            customAppearanceView.darkButton.setImage(SFSymbols.circleFill, for: .normal)
        } else if systemIsSelected {
            customAppearanceView.systemButton.setImage(SFSymbols.circleFill, for: .normal)
        }
    }
    
    private func showRestartIndicator() {
        guard let indicatorImage = UIImages.refresh?.withTintColor(OtherUIColors.navigationItems ?? .gray, renderingMode: .alwaysOriginal) else { return }
        SPIndicator.present(title: "Restart the app",preset: .custom(indicatorImage), haptic: .success)
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
            .foregroundColor: OtherUIColors.navigationItems as Any,
            .font: UIFont(name: CustomFonts.nunitoBold, size: 26) ?? UIFont.systemFont(ofSize: 26)
        ]
        
        // Setup NavigationBar and remove bottom border
        navigationItem.standardAppearance = appearance
        
        // Disable back button
        navigationItem.setHidesBackButton(true, animated: true)
        
        // Custom left button
        let backButton = UIButton()
        backButton.customNavigationButton(UIImages.backLeft,
                                          OtherUIColors.navigationItems)
        let leftButton = UIBarButtonItem(customView: backButton)
        navigationItem.leftBarButtonItem = leftButton
        backButton.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
        
        // Custom right button
        let homeButton = UIButton()
        homeButton.customNavigationButton(UIImages.success,
                                          OtherUIColors.navigationItems)
        let rightButton = UIBarButtonItem(customView: homeButton)
        navigationItem.rightBarButtonItem = rightButton
        homeButton.addTarget(self, action: #selector(didTapHomeButton), for: .touchUpInside)
    }
}
