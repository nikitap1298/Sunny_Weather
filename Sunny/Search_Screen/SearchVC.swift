//
//  SearchViewController.swift
//  Sunny
//
//  Created by Nikita Pishchugin on 21.07.2022.
//

import UIKit
import CoreLocation
import SwipeCellKit
import SPIndicator

// MARK: - Protocols
protocol SearchVCDelegate: AnyObject {
    func didSendName(_ name: String)
}

// MARK: - View Controller
class SearchVC: UIViewController {
    
    // MARK: - Private Properties
    private var backButton: UIButton = {
        let backButton = UIButton()
        backButton.setImage(UIImage(named: CustomImages.backLeft), for: .normal)
        backButton.tintColor = UIColor(named: CustomColors.colorGray)
        backButton.translateMask()
        return backButton
    }()
    
    private let offSetValue: CGFloat = 20
    private let screenTitle: String = "Search"
    
    private let textView = TextView()
    private var textViewBottomAnchor: NSLayoutConstraint?
    private let searchCollectionView = SearchCollectionView()
    
    private var addressManager = AddressManager()
    private var weatherManager = WeatherManager()
    
    // Models
    private var addressModel = AddressModel()
    private var coordinateModel = CoordinateModel()
    private var currentWeatherModel = CurrentWeatherModel()
    private var cityModel = CityModel()
    private let weatherDescription = WeatherDescription()
    
    private var cityArray = [CityModel]()
    
    private let converter = Converter()
    
    private var isCurrent: Bool = true
    
    // MARK: - Public Properties
    weak var searchVCDelegate: SearchVCDelegate?
    
    var latitude = 0.0
    var longitude = 0.0
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(named: CustomColors.colorLightGreen)
        customNavigationBar()
        
        addressManager.addressManagerDelegate = self
        weatherManager.weatherManagerDelegate = self
        
        addressManager.fetchAddressFromCoord(latitude, longitude)
        
        setUpUI()
        registerForKeyboardNotifications()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        weatherManager.fetchCurrentWeather(self.lat, self.lon)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
    }
    
    // MARK: - Actions
    @objc private func didTapBackButton() {
        navigationController?.popViewControllerToRight()
    }
    
    @objc private func didTapCancelButton() {
        view.endEditing(true)
    }
    
    // MARK: - Private Functions
    private func setUpUI() {
        view.addSubview(textView.mainView)
        view.addSubview(searchCollectionView.collectionView)
        
        textView.searchTextField.delegate = self
        searchCollectionView.collectionView.delegate = self
        searchCollectionView.collectionView.dataSource = self
        
        textViewBottomAnchor = textView.mainView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -offSetValue)
        
        NSLayoutConstraint.activate([
            textView.mainView.heightAnchor.constraint(equalToConstant: 45),
            textView.mainView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            
            searchCollectionView.collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            searchCollectionView.collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            searchCollectionView.collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            searchCollectionView.collectionView.bottomAnchor.constraint(equalTo: textView.mainView.topAnchor, constant: -20)
        ])
        if UIDevice.modelName == "Simulator iPod touch (7th generation)" || UIDevice.modelName == "iPod touch (7th generation)" {
            NSLayoutConstraint.activate([
                textView.mainView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10)
            ])
        } else {
            NSLayoutConstraint.activate([
                textView.mainView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20)
            ])
        }
        
        guard let searchViewBottomAnchor = textViewBottomAnchor else {
            return
        }
        
        searchViewBottomAnchor.isActive = true
        
        textView.cancelButton.addTarget(self, action: #selector(didTapCancelButton), for: .touchUpInside)
    }
    
    private func registerForKeyboardNotifications() {
        let showNotification = UIResponder.keyboardWillShowNotification
        NotificationCenter.default.addObserver(forName: showNotification, object: nil, queue: .main) { [weak self] notification in
            if let keyBoardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                self?.textViewBottomAnchor?.constant = -(keyBoardSize.height + 10.0 )
                self?.backButton.tintColor = UIColor(named: CustomColors.colorVanilla)
                // Doesn't work corrently
                self?.title = ""
                UIView.animate(withDuration: 3.0) {
                    self?.view.layoutIfNeeded()
                }
            }
        }
        
        let hideNotification = UIResponder.keyboardWillHideNotification
        NotificationCenter.default.addObserver(forName: hideNotification, object: nil, queue: .main) { [weak self] _ in
            self?.view.removeBlur()
            self?.textViewBottomAnchor?.constant = -(self?.offSetValue ?? 20.0)
            self?.backButton.tintColor = UIColor(named: CustomColors.colorGray)
            self?.title = self?.screenTitle
            UIView.animate(withDuration: 3.0) {
                self?.view.layoutIfNeeded()
            }
        }
    }
    
}

// MARK: - UISearchTextFieldDelegate
extension SearchVC: UISearchTextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        isCurrent = false
        addressManager.fetchCoordinatesFromAddress(textField.text!)
        textField.text = ""
        textField.resignFirstResponder()
        searchCollectionView.collectionView.reloadData()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLenght = 20
        let currentString = (textField.text ?? "") as NSString
        let newString = currentString.replacingCharacters(in: range, with: string)
        return newString.count <= maxLenght
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textView.cancelButton.setTitleColor(UIColor(named: CustomColors.colorVanilla), for: .normal)
        view.addBlurView(style: .systemMaterialDark)
        view.bringSubviewToFront(self.textView.mainView)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        textView.cancelButton.setTitleColor(UIColor(named: CustomColors.colorGray), for: .normal)
        view.removeBlur()
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension SearchVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cityArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = searchCollectionView.collectionView.dequeueReusableCell(withReuseIdentifier: CustomSearchCollectionViewCell.reuseIdentifier, for: indexPath) as? CustomSearchCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.delegate = self
        cell.setUpCity(cityArray[indexPath.row].name)
        cell.setUpDescription(cityArray[indexPath.row].conditionDescription)
        cell.setUpTemperature(cityArray[indexPath.row].temperature)
        cell.setUpConditionImage(cityArray[indexPath.row].conditionImage)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let tappedCell = collectionView.cellForItem(at: indexPath) as? CustomSearchCollectionViewCell else {
            return
        }
        if indexPath.row == 0 {
            UserDefaults.standard.set(true, forKey: UserDefaultsKeys.isCurrent)
        } else {
            UserDefaults.standard.set(false, forKey: UserDefaultsKeys.isCurrent)
        }
        searchVCDelegate?.didSendName(tappedCell.cityLabel.text ?? "")
        navigationController?.popViewControllerToRight()
    }
        
}

// MARK: - SwipeCollectionViewCellDelegate
extension SearchVC: SwipeCollectionViewCellDelegate {
    
    func collectionView(_ collectionView: UICollectionView, editActionsForItemAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }
        
        // User can't delete first city
        if indexPath.row != 0 {
            
            let deleteAction = SwipeAction(style: .default, title: nil) { [weak self] action, indexPath in
                // handle action by updating model with deletion
                guard let self = self else { return }
                self.cityArray.remove(at: indexPath.row)
            }
            
            // For custom deleteAction
            let largeConfig = UIImage.SymbolConfiguration(pointSize: 15, weight: .bold, scale: .default)
            
            // customize the action appearance
            deleteAction.backgroundColor = .clear
            
            deleteAction.image =  UIImage(systemName: "trash", withConfiguration: largeConfig)?.withTintColor(UIColor(named: CustomColors.colorVanilla) ?? .white, renderingMode: .alwaysTemplate).addBackgroundCircle(.systemRed)
            deleteAction.font = UIFont(name: CustomFonts.loraMedium, size: 17.5)
            deleteAction.textColor = UIColor(named: CustomColors.colorGray)
            
            return [deleteAction]
            
        }
    
       return []
    }
    
    func collectionView(_ collectionView: UICollectionView, editActionsOptionsForItemAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        options.expansionStyle = .destructive
        options.transitionStyle = .border
        return options
    }
    
}

// MARK: - AddressManagerDelegate
extension SearchVC: AddressManagerDelegate {
    func didGetCoordinate(_ addressManager: AddressManager, addressModel: AddressModel) {
        self.addressModel = addressModel
        
        // Search doesn't work with Crimea's cities
        if addressModel.name != "" {
            weatherManager.fetchCurrentWeather(addressModel.latitude, addressModel.longitude)
        }
    }
    
    func didGetAddress(_ addressManager: AddressManager, coordinateModel: CoordinateModel) {
        self.coordinateModel = coordinateModel
        weatherManager.fetchCurrentWeather(coordinateModel.latitude, coordinateModel.longitude)
    }
    
    
}

// MARK: - WeatherManagerDelegate
extension SearchVC: WeatherManagerDelegate {
    
    func didUpdateCurrentWeather(_ weatherManager: WeatherManager, currentWeather: CurrentWeatherModel) {
        self.currentWeatherModel = currentWeather
        
        if isCurrent {
            cityModel.name = "\(coordinateModel.locality), \(coordinateModel.countryCode)"
        } else {
            cityModel.name = "\(addressModel.name), \(addressModel.countryCode)"
        }
        cityModel.conditionDescription = weatherDescription.condition(currentWeather.conditionCode) ?? ""
        cityModel.temperature = converter.convertTemperature(currentWeather.temperature)
        cityModel.conditionImage = currentWeather.weatherIcon
        
        cityArray.append(cityModel)
        
        searchCollectionView.collectionView.reloadData()
    }
    
    func didUpdateHourlyForecast(_ weatherManager: WeatherManager, hourlyForecast: HourlyForecastModel) {
        print("b")
    }
    
    func didUpdateDailyForecast(_ weatherManager: WeatherManager, dailyForecast: DailyForecastModel) {
        print("c")
    }
    
}

// MARK: - SearchViewController
private extension SearchVC {
    func customNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .clear
        navigationItem.title = screenTitle
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor(named: CustomColors.colorGray) as Any,
            .font: UIFont(name: CustomFonts.nunitoBold, size: 26) ?? UIFont.systemFont(ofSize: 26)
        ]
        
        // Setup NavigationBar and remove bottom border
        navigationItem.standardAppearance = appearance
        
        // Disable Back button
        navigationItem.setHidesBackButton(true, animated: true)
        
        // Custom Left Button
        let backButton = UIButton()
        backButton.customNavigationButton(UIImage(named: CustomImages.backLeft),
                                          UIColor(named: CustomColors.colorGray))
        let leftButton = UIBarButtonItem(customView: backButton)
        navigationItem.leftBarButtonItem = leftButton
        backButton.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
    }
}

