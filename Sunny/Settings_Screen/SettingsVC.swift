//
//  SettingsViewController.swift
//  Sunny
//
//  Created by Nikita Pishchugin on 21.07.2022.
//

import UIKit
import MessageUI

class SettingsVC: UIViewController {
    
    // MARK: - Private Properties
    private let mainScrollView = MainScrollView()
    private let firstBlock = FirstBlock()
    private let secondBlock = SecondBlock()
    
    private var temperatureIsDefault = true
    private var speedIsDefault = true
    private var pressureIsDefault = true
    private var precipitationIsDefault = true
    private var distanсeIsDefault = true
    private var timeFormatIsDefault = true
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpSwipeGestureRecognizer()
        
        customNavigationBar()
        setUpScrollView()
        
        setUpBlocks()
        
        setUpUserDefaults()
    }
    
    // MARK: - Actions
    @objc private func didTapBackButton() {
        navigationController?.popViewControllerToLeft()
    }
    
    @objc private func didSwipeLeft(_ recognizer: UISwipeGestureRecognizer) {
        if recognizer.state == .ended {
            navigationController?.popViewControllerToLeft()
        }
    }
    
    @objc private func didTapTemperatureView() {
        if temperatureIsDefault == true {
            firstBlock.temperature.switchViewLeadingAnchor?.isActive = false
            firstBlock.temperature.switchViewTrailingAnhor?.isActive = true
            UIView.animate(withDuration: 0.3) { [weak self] in
                self?.firstBlock.temperature.valuesView.layoutIfNeeded()
                self?.temperatureIsDefault = false
                UserDefaults.standard.set(self?.temperatureIsDefault, forKey: UserDefaultsKeys.temperature)
            }
        } else {
            firstBlock.temperature.switchViewLeadingAnchor?.isActive = true
            firstBlock.temperature.switchViewTrailingAnhor?.isActive = false
            UIView.animate(withDuration: 0.3) { [weak self] in
                self?.firstBlock.temperature.valuesView.layoutIfNeeded()
                self?.temperatureIsDefault = true
                UserDefaults.standard.set(self?.temperatureIsDefault, forKey: UserDefaultsKeys.temperature)
            }
        }
    }
    
    @objc private func didTapSpeedView() {
        if speedIsDefault == true {
            firstBlock.speed.switchViewLeadingAnchor?.isActive = false
            firstBlock.speed.switchViewTrailingAnhor?.isActive = true
            UIView.animate(withDuration: 0.3) { [weak self] in
                self?.firstBlock.speed.valuesView.layoutIfNeeded()
                self?.speedIsDefault = false
                UserDefaults.standard.set(self?.speedIsDefault, forKey: UserDefaultsKeys.speed)
            }
        } else {
            firstBlock.speed.switchViewLeadingAnchor?.isActive = true
            firstBlock.speed.switchViewTrailingAnhor?.isActive = false
            UIView.animate(withDuration: 0.3) { [weak self] in
                self?.firstBlock.speed.valuesView.layoutIfNeeded()
                self?.speedIsDefault = true
                UserDefaults.standard.set(self?.speedIsDefault, forKey: UserDefaultsKeys.speed)
            }
        }
    }
    
    @objc private func didTapPressureView() {
        if pressureIsDefault == true {
            firstBlock.pressure.switchViewLeadingAnchor?.isActive = false
            firstBlock.pressure.switchViewTrailingAnhor?.isActive = true
            UIView.animate(withDuration: 0.3) { [weak self] in
                self?.firstBlock.pressure.valuesView.layoutIfNeeded()
                self?.pressureIsDefault = false
                UserDefaults.standard.set(self?.pressureIsDefault, forKey: UserDefaultsKeys.pressure)
            }
        } else {
            firstBlock.pressure.switchViewLeadingAnchor?.isActive = true
            firstBlock.pressure.switchViewTrailingAnhor?.isActive = false
            UIView.animate(withDuration: 0.3) { [weak self] in
                self?.firstBlock.pressure.valuesView.layoutIfNeeded()
                self?.pressureIsDefault = true
                UserDefaults.standard.set(self?.pressureIsDefault, forKey: UserDefaultsKeys.pressure)
            }
        }
    }
    
    @objc private func didTapPrecipitationView() {
        if precipitationIsDefault == true {
            firstBlock.precipitation.switchViewLeadingAnchor?.isActive = false
            firstBlock.precipitation.switchViewTrailingAnhor?.isActive = true
            UIView.animate(withDuration: 0.3) { [weak self] in
                self?.firstBlock.precipitation.valuesView.layoutIfNeeded()
                self?.precipitationIsDefault = false
                UserDefaults.standard.set(self?.precipitationIsDefault, forKey: UserDefaultsKeys.precipitation)
            }
        } else {
            firstBlock.precipitation.switchViewLeadingAnchor?.isActive = true
            firstBlock.precipitation.switchViewTrailingAnhor?.isActive = false
            UIView.animate(withDuration: 0.3) { [weak self] in
                self?.firstBlock.precipitation.valuesView.layoutIfNeeded()
                self?.precipitationIsDefault = true
                UserDefaults.standard.set(self?.precipitationIsDefault, forKey: UserDefaultsKeys.precipitation)
            }
        }
    }
    
    @objc private func didTapDistanсeView() {
        if distanсeIsDefault == true {
            firstBlock.distance.switchViewLeadingAnchor?.isActive = false
            firstBlock.distance.switchViewTrailingAnhor?.isActive = true
            UIView.animate(withDuration: 0.3) { [weak self] in
                self?.firstBlock.distance.valuesView.layoutIfNeeded()
                self?.distanсeIsDefault = false
                UserDefaults.standard.set(self?.distanсeIsDefault, forKey: UserDefaultsKeys.distance)
            }
        } else {
            firstBlock.distance.switchViewLeadingAnchor?.isActive = true
            firstBlock.distance.switchViewTrailingAnhor?.isActive = false
            UIView.animate(withDuration: 0.3) { [weak self] in
                self?.firstBlock.distance.valuesView.layoutIfNeeded()
                self?.distanсeIsDefault = true
                UserDefaults.standard.set(self?.distanсeIsDefault, forKey: UserDefaultsKeys.distance)
            }
        }
    }
    
    @objc private func didTapTimeFormatView() {
        if timeFormatIsDefault == true {
            firstBlock.timeFormat.switchViewLeadingAnchor?.isActive = false
            firstBlock.timeFormat.switchViewTrailingAnhor?.isActive = true
            UIView.animate(withDuration: 0.3) { [weak self] in
                self?.firstBlock.timeFormat.valuesView.layoutIfNeeded()
                self?.timeFormatIsDefault = false
                UserDefaults.standard.set(self?.timeFormatIsDefault, forKey: UserDefaultsKeys.timeFormat)
            }
        } else {
            firstBlock.timeFormat.switchViewLeadingAnchor?.isActive = true
            firstBlock.timeFormat.switchViewTrailingAnhor?.isActive = false
            UIView.animate(withDuration: 0.3) { [weak self] in
                self?.firstBlock.timeFormat.valuesView.layoutIfNeeded()
                self?.timeFormatIsDefault = true
                UserDefaults.standard.set(self?.timeFormatIsDefault, forKey: UserDefaultsKeys.timeFormat)
            }
        }
    }
    
    @objc private func didTapAppearanceButton() {
        let viewController = AppearanceVC()
        navigationController?.pushViewControllerFromRight(controller: viewController)
    }
    
    @objc private func didTapSubscribe() {
        print("Sent 0.99$")
    }
    
    @objc private func didTapAboutButton() {
        let viewController = AboutVC()
        navigationController?.pushViewControllerFromRight(controller: viewController)
    }
    
    @objc private func didTapRateUsView() {
        
    }
    
    @objc private func didTapContactButton() {
        sendEmail()
    }
    
    // MARK: - Private Functions
    
    private func setUpSwipeGestureRecognizer() {
        let swipeGestureRecognizer = UISwipeGestureRecognizer()
        swipeGestureRecognizer.addTarget(self, action: #selector(didSwipeLeft(_ :)))
        swipeGestureRecognizer.direction = .left
        mainScrollView.contentView.addGestureRecognizer(swipeGestureRecognizer)
    }
    
    private func setUpScrollView() {
        view.backgroundColor = SettingsColors.backgroungWhite
        
        view.addSubview(mainScrollView.scrollView)
        
        mainScrollView.contentViewHeightAnchor?.constant = 683
        
        NSLayoutConstraint.activate([
            mainScrollView.scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            mainScrollView.scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainScrollView.scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainScrollView.scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    private func setUpBlocks() {
        mainScrollView.contentView.addSubview(firstBlock)
        mainScrollView.contentView.addSubview(secondBlock)
        
        NSLayoutConstraint.activate([
            firstBlock.mainView.topAnchor.constraint(equalTo: mainScrollView.contentView.topAnchor, constant: 20),
            firstBlock.mainView.leadingAnchor.constraint(equalTo: mainScrollView.contentView.leadingAnchor, constant: 0),
            firstBlock.mainView.trailingAnchor.constraint(equalTo: mainScrollView.contentView.trailingAnchor, constant: 0),
            firstBlock.mainView.heightAnchor.constraint(equalToConstant: 307),
            
            secondBlock.mainView.topAnchor.constraint(equalTo: firstBlock.mainView.bottomAnchor, constant: 100),
            secondBlock.mainView.leadingAnchor.constraint(equalTo: mainScrollView.contentView.leadingAnchor, constant: 0),
            secondBlock.mainView.trailingAnchor.constraint(equalTo: mainScrollView.contentView.trailingAnchor, constant: 0),
            secondBlock.mainView.heightAnchor.constraint(equalToConstant: 256)
        ])
        
        setUpButtons()
    }
    
    private func setUpButtons() {
        firstBlock.temperature.settingsView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapTemperatureView)))
        firstBlock.speed.settingsView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapSpeedView)))
        firstBlock.pressure.settingsView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapPressureView)))
        firstBlock.precipitation.settingsView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapPrecipitationView)))
        firstBlock.distance.settingsView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapDistanсeView)))
        firstBlock.timeFormat.settingsView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapTimeFormatView)))
        
        secondBlock.appearance.buttonView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapAppearanceButton)))
        secondBlock.subscribe.buttonView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapSubscribe)))
        secondBlock.about.buttonView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapAboutButton)))
        secondBlock.rateUS.buttonView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapRateUsView)))
        secondBlock.contactUS.buttonView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapContactButton)))
    }
    
    private func setUpUserDefaults() {
        let temperatureUserDef = UserDefaults.standard.value(forKey: UserDefaultsKeys.temperature) as? Bool
        temperatureIsDefault = temperatureUserDef ?? true
        if temperatureIsDefault {
            firstBlock.temperature.switchViewLeadingAnchor?.isActive = true
            firstBlock.temperature.switchViewTrailingAnhor?.isActive = false
        } else {
            firstBlock.temperature.switchViewLeadingAnchor?.isActive = false
            firstBlock.temperature.switchViewTrailingAnhor?.isActive = true
        }
        
        let speedUserDef = UserDefaults.standard.value(forKey: UserDefaultsKeys.speed) as? Bool
        speedIsDefault = speedUserDef ?? true
        if speedIsDefault {
            firstBlock.speed.switchViewLeadingAnchor?.isActive = true
            firstBlock.speed.switchViewTrailingAnhor?.isActive = false
        } else {
            firstBlock.speed.switchViewLeadingAnchor?.isActive = false
            firstBlock.speed.switchViewTrailingAnhor?.isActive = true
        }
        
        let pressureUserDef = UserDefaults.standard.value(forKey: UserDefaultsKeys.pressure) as? Bool
        pressureIsDefault = pressureUserDef ?? true
        if pressureIsDefault {
            firstBlock.pressure.switchViewLeadingAnchor?.isActive = true
            firstBlock.pressure.switchViewTrailingAnhor?.isActive = false
        } else {
            firstBlock.pressure.switchViewLeadingAnchor?.isActive = false
            firstBlock.pressure.switchViewTrailingAnhor?.isActive = true
        }
        
        let precipitationUserDef = UserDefaults.standard.value(forKey: UserDefaultsKeys.precipitation) as? Bool
        precipitationIsDefault = precipitationUserDef ?? true
        if precipitationIsDefault {
            firstBlock.precipitation.switchViewLeadingAnchor?.isActive = true
            firstBlock.precipitation.switchViewTrailingAnhor?.isActive = false
        } else {
            firstBlock.precipitation.switchViewLeadingAnchor?.isActive = false
            firstBlock.precipitation.switchViewTrailingAnhor?.isActive = true
        }
        
        let distanceUserDef = UserDefaults.standard.value(forKey: UserDefaultsKeys.distance) as? Bool
        distanсeIsDefault = distanceUserDef ?? true
        if distanсeIsDefault {
            firstBlock.distance.switchViewLeadingAnchor?.isActive = true
            firstBlock.distance.switchViewTrailingAnhor?.isActive = false
        } else {
            firstBlock.distance.switchViewLeadingAnchor?.isActive = false
            firstBlock.distance.switchViewTrailingAnhor?.isActive = true
        }
        
        let timeFormatUserDef = UserDefaults.standard.value(forKey: UserDefaultsKeys.timeFormat) as? Bool
        timeFormatIsDefault = timeFormatUserDef ?? true
        if timeFormatIsDefault {
            firstBlock.timeFormat.switchViewLeadingAnchor?.isActive = true
            firstBlock.timeFormat.switchViewTrailingAnhor?.isActive = false
        } else {
            firstBlock.timeFormat.switchViewLeadingAnchor?.isActive = false
            firstBlock.timeFormat.switchViewTrailingAnhor?.isActive = true
        }
    }
    
}

// MARK: - Extensions
private extension SettingsVC {
    func customNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = SettingsColors.backgroungWhite
        navigationItem.title = "Settings"
        appearance.titleTextAttributes = [
            .foregroundColor: OtherUIColors.navigationItems as Any,
            .font: UIFont(name: CustomFonts.nunitoBold, size: 26) ?? UIFont.systemFont(ofSize: 26)
        ]
        
        // Setup NavigationBar and remove bottom border
        navigationItem.standardAppearance = appearance
        
        // Disable Back button
        navigationItem.setHidesBackButton(true, animated: true)
        
        // Custom Right Button
        let backButton = UIButton()
        backButton.customNavigationButton(UIImages.backRight,
                                          OtherUIColors.navigationItems)
        let rightButton = UIBarButtonItem(customView: backButton)
        navigationItem.rightBarButtonItem = rightButton
        backButton.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
    }
}

extension SettingsVC: MFMailComposeViewControllerDelegate {
    
    func sendEmail() {
        if MFMailComposeViewController.canSendMail() {
            let mailTemplate = """
                        <p>Write here your feedback or ideas how to improve the app.</br>
                        If you experienced any issues while using the app, you can write here too.</p></br>
                        <br>Sunny App version: \(UIApplication.appVersion ?? "Something went wrong. Please write app version by yourself.")</br>
                        Current iOS version: \(UIDevice.current.systemVersion)</br>
                        Device model: \(UIDevice.modelName)</br>
            """
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setSubject("Sunny App / Feedback")
            mail.setToRecipients(["nikpishchugin@gmail.com"])
            mail.setMessageBody(mailTemplate, isHTML: true)
            present(mail, animated: true)
        } else {
            print("Error sending email")
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
}
