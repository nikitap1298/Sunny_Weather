//
//  DetailedForecastViewController.swift
//  Sunny
//
//  Created by Nikita Pishchugin on 21.08.2022.
//

import UIKit

class HourVC: UIViewController {
    
    // MARK: - Private Properties
    private let backButton: UIButton = {
        let backButton = UIButton()
        backButton.setImage(UIImage(named: CustomImages.backLeft), for: .normal)
        backButton.tintColor = UIColor(named: CustomColors.colorDarkBlue)
        backButton.translateMask()
        return backButton
    }()
    
    // Model
    private let converter = Converter()
    private let timeConverter = TimeConverter()
    private let gradientModel = GradientModel()
    
    private let mainScrollView = MainScrollView()
    private let hourConditionView = HourConditionView()
    
    private var hourConditionModel = HourConditionModel()
    private var conditionValueArray = [String]()
    
    // MARK: - Public Properties
    var hourlyForecastModel = HourlyForecastModel()
    var cellDate = ""
    var currentIndex = 0
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customNavigationBar()
        navigationItem.title = cellDate
        
        conditionValueArray = hourConditionModel.fillValueArray(data: hourlyForecastModel, currentIndex: currentIndex)
        
        setUpMainScrollView()
        setUpDetailedConditionView()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        gradientModel.getGradient(view,
                                  UIColor(named: CustomColors.colorBlue),
                                  UIColor(named: CustomColors.colorBlue1),
                                  CGPoint(x: 0, y: 0),
                                  CGPoint(x: 0.8, y: 1))
    }
    
    // MARK: - Actions
    @objc private func didTapBackButton() {
        navigationController?.popViewControllerToRight()
    }
    
    // MARK: - Private Functions
    private func setUpMainScrollView() {
        view.addSubview(mainScrollView.scrollView)
        
        mainScrollView.scrollView.isScrollEnabled = false
        mainScrollView.contentView.backgroundColor = .clear
        mainScrollView.contentViewHeightAnchor?.constant = Constraints.contentViewDetailedHeight
        
        NSLayoutConstraint.activate([
            mainScrollView.scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            mainScrollView.scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            mainScrollView.scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            mainScrollView.scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -1)
        ])
    }
    
    private func setUpDetailedConditionView() {
        mainScrollView.contentView.addSubview(hourConditionView.collectionView)
        
        NSLayoutConstraint.activate([
            hourConditionView.collectionView.topAnchor.constraint(equalTo: mainScrollView.contentView.topAnchor, constant: 20),
            hourConditionView.collectionView.leadingAnchor.constraint(equalTo: mainScrollView.contentView.leadingAnchor, constant: 5),
            hourConditionView.collectionView.trailingAnchor.constraint(equalTo: mainScrollView.contentView.trailingAnchor, constant: -5),
            hourConditionView.collectionView.heightAnchor.constraint(equalToConstant: view.frame.height / 2.5)
        ])
        
        hourConditionView.collectionView.delegate = self
        hourConditionView.collectionView.dataSource = self
    }
    
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension HourVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return hourConditionModel.parameterNameArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = hourConditionView.collectionView.dequeueReusableCell(withReuseIdentifier: DetailedConditionCell.reuseIdentifier, for: indexPath) as? DetailedConditionCell else {
            return UICollectionViewCell()
        }
        
        DispatchQueue.main.async { [weak self] in
            self?.gradientModel.getGradient(cell.stackView,
                                      UIColor(named: CustomColors.colorDarkBlue),
                                      UIColor(named: CustomColors.colorDarkBlue1),
                                      CGPoint(x: 0.0, y: 0.2),
                                      CGPoint(x: 1.0, y: 0.9))
        }
        cell.setUpParameterName(hourConditionModel.parameterNameArray[indexPath.row])
        cell.setUpParameterValue(conditionValueArray[indexPath.row])
        
        return cell
    }
    
    
}

// MARK: - DetailedForecastViewController
private extension HourVC {
    func customNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .clear
        navigationItem.title = "Day"
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor(named: CustomColors.colorVanilla) as Any,
            .font: UIFont(name: CustomFonts.nunitoBold, size: 26) ?? UIFont.systemFont(ofSize: 26)
        ]
        
        // Setup NavigationBar and remove bottom border
        navigationItem.standardAppearance = appearance
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        // Disable Back button
        navigationItem.setHidesBackButton(true, animated: true)
        
        // Custom Left Button
        let leftButton = UIBarButtonItem(customView: backButton)
        navigationItem.leftBarButtonItem = leftButton
        backButton.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
    }
}
