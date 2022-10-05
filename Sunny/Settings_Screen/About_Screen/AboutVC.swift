//
//  AboutViewContoller.swift
//  Sunny
//
//  Created by Nikita Pishchugin on 22.07.2022.
//

import UIKit

class AboutVC: UIViewController {
    
    // MARK: - Private Properties
    private var sunImage: UIImageView = {
        let sunImage = UIImageView()
        sunImage.image = UIImage(named: WeatherImages.sun)
        sunImage.translateMask()
        return sunImage
    }()
    
    private var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.text = "Sunny"
        nameLabel.textAlignment = .center
        nameLabel.font = UIFont(name: CustomFonts.nunitoSemiBold, size: 40)
        nameLabel.textColor = UIColor(named: CustomColors.colorDarkYellow)
        nameLabel.translateMask()
        return nameLabel
    }()
    
    private var viewForButtons: UIView = {
        let viewForButtons = UIView()
        viewForButtons.backgroundColor = UIColor(named: CustomColors.colorGray)
        viewForButtons.translateMask()
        return viewForButtons
    }()
    
    private let developerButton = CustomAboutButtons()
    private let iconsButton = CustomAboutButtons()
    private let versionView = CustomAboutButtons()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(named: CustomColors.colorVanilla)
        
        customNavigationBar()
        setUpSunImage()
        setUpNameLabel()
        setUpViewForButtons()
        setUpDeveloperButton()
        setUpIconButton()
        setUpVersionView()
        
    }
    
    // MARK: - Actions
    @objc private func didTapBackButton() {
        navigationController?.popViewControllerToRight()
    }
    
    @objc private func didTapHomeButton() {
        navigationController?.popToRootViewControllerToBottom()
    }
    
    @objc private func didTapDeveloperButton() {
        if let url = URL(string: "https://github.com/nikitap1298") {
            UIApplication.shared.open(url)
        }
    }
    
    @objc private func didTapIconsButton() {
        if let url = URL(string: "https://www.flaticon.com") {
            UIApplication.shared.open(url)
        }
    }
    
    // MARK: - Private Functions
    private func setUpSunImage() {
        view.addSubview(sunImage)
        
        NSLayoutConstraint.activate([
            sunImage.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            sunImage.widthAnchor.constraint(equalToConstant: 120),
            sunImage.heightAnchor.constraint(equalToConstant: 120)
        ])
        
        if UIDevice.modelName == "Simulator iPod touch (7th generation)" || UIDevice.modelName == "iPod touch (7th generation)" {
            NSLayoutConstraint.activate([
                sunImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20)
            ])
        } else {
            NSLayoutConstraint.activate([
                sunImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 120)
            ])
        }
    }
    
    private func setUpNameLabel() {
        view.addSubview(nameLabel)
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: sunImage.bottomAnchor, constant: 40),
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            nameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            nameLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30),
        ])
    }
    
    private func setUpViewForButtons() {
        view.addSubview(viewForButtons)
        
        NSLayoutConstraint.activate([
            viewForButtons.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            viewForButtons.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            viewForButtons.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            viewForButtons.heightAnchor.constraint(equalToConstant: 153)
        ])
    }
    
    private func setUpDeveloperButton() {
        viewForButtons.addSubview(developerButton.buttonView)
        
        developerButton.titleLabel.text = "Developer:"
        if UIDevice.modelName == "Simulator iPod touch (7th generation)" || UIDevice.modelName == "iPod touch (7th generation)" {
            developerButton.textLabel.text = "Nikita P."
        } else {
            developerButton.textLabel.text = "Nikita Pishchugin"
        }
        developerButton.imageView.image = UIImage(named: CustomImages.link)
        
        NSLayoutConstraint.activate([
            developerButton.buttonView.topAnchor.constraint(equalTo: viewForButtons.topAnchor, constant: 0),
            developerButton.buttonView.leadingAnchor.constraint(equalTo: viewForButtons.leadingAnchor, constant: 0),
            developerButton.buttonView.trailingAnchor.constraint(equalTo: viewForButtons.trailingAnchor, constant: 0),
            developerButton.buttonView.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        developerButton.buttonView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapDeveloperButton)))
    }
    
    private func setUpIconButton() {
        viewForButtons.addSubview(iconsButton.buttonView)
        
        iconsButton.titleLabel.text = "Illustrations:"
        iconsButton.textLabel.text = "flaticon"
        iconsButton.imageView.image = UIImage(named: CustomImages.certificate)
        
        NSLayoutConstraint.activate([
            iconsButton.buttonView.topAnchor.constraint(equalTo: developerButton.buttonView.bottomAnchor, constant: 1),
            iconsButton.buttonView.leadingAnchor.constraint(equalTo: viewForButtons.leadingAnchor, constant: 0),
            iconsButton.buttonView.trailingAnchor.constraint(equalTo: viewForButtons.trailingAnchor, constant: 0),
            iconsButton.buttonView.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        iconsButton.buttonView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapIconsButton)))
    }
    
    private func setUpVersionView() {
        viewForButtons.addSubview(versionView.buttonView)
        
        versionView.titleLabel.text = "Version:"
        versionView.textLabel.text = UIApplication.appVersion
        versionView.imageView.image = UIImage(named: CustomImages.build)
        
        NSLayoutConstraint.activate([
            versionView.buttonView.topAnchor.constraint(equalTo: iconsButton.buttonView.bottomAnchor, constant: 1),
            versionView.buttonView.leadingAnchor.constraint(equalTo: viewForButtons.leadingAnchor, constant: 0),
            versionView.buttonView.trailingAnchor.constraint(equalTo: viewForButtons.trailingAnchor, constant: 0),
            versionView.buttonView.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
}

// MARK: - AboutVC
private extension AboutVC {
    func customNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .clear
        navigationItem.title = "About"
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

// Get app version
extension UIApplication {
    static var appVersion: String? {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
    }
}
