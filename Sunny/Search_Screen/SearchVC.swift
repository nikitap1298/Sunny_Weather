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
import MapKit

// MARK: - Protocols
protocol SearchVCDelegate: AnyObject {
    func didSendName(_ name: String)
}

// MARK: - View Controller
class SearchVC: UIViewController {
    
    // MARK: - Private Properties
    private var backButton: UIButton = {
        let backButton = UIButton()
        backButton.setImage(UIImages.backLeft, for: .normal)
        backButton.tintColor = CustomColors.colorGray
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
    
    // City Search
    private let cityAutoComplete = CityAutoComplete()
    private let autoCompleteTableView = AutoCompleteView()
    
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
        
        view.backgroundColor = SearchColors.background
        customNavigationBar()
        setUpSwipeGestureRecognizer()
        
        addressManager.addressManagerDelegate = self
        weatherManager.weatherManagerDelegate = self
        
        addressManager.fetchAddressFromCoord(latitude, longitude)
        
        cityAutoComplete.searchCompleter.delegate = self
        cityAutoComplete.searchCompleter.region = MKCoordinateRegion(.world)
        cityAutoComplete.searchCompleter.resultTypes = MKLocalSearchCompleter.ResultType([.address])
        
        setUpUI()
        registerForKeyboardNotifications()
    }
    
    // MARK: - Actions
    @objc private func didTapBackButton() {
        navigationController?.popViewControllerToRight()
    }
    
    @objc private func didSwipeRight(_ recognizer: UISwipeGestureRecognizer) {
        if recognizer.state == .ended {
            navigationController?.popViewControllerToRight()
        }
    }
    
    @objc private func didTapCancelButton(_ sender: UISwipeGestureRecognizer) {
        textView.searchTextField.text = ""
        view.endEditing(true)
    }
    
    // MARK: - Private Functions
    private func setUpSwipeGestureRecognizer() {
        let swipeGestureRecognizer = UISwipeGestureRecognizer()
        swipeGestureRecognizer.addTarget(self, action: #selector(didSwipeRight(_ :)))
        swipeGestureRecognizer.direction = .right
        view.addGestureRecognizer(swipeGestureRecognizer)
    }
    
    private func setUpUI() {
        view.addSubview(textView.mainView)
        view.addSubview(searchCollectionView.collectionView)
        
        textView.searchTextField.delegate = self
        searchCollectionView.collectionView.delegate = self
        searchCollectionView.collectionView.dataSource = self
        
        autoCompleteTableView.tableView.delegate = self
        autoCompleteTableView.tableView.dataSource = self
        
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
    
    private func setUpAutoCompleteTableView() {
        view.addSubview(autoCompleteTableView.tableView)
        
        NSLayoutConstraint.activate([
            autoCompleteTableView.tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            autoCompleteTableView.tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            autoCompleteTableView.tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            autoCompleteTableView.tableView.bottomAnchor.constraint(equalTo: textView.mainView.topAnchor, constant: -20)
        ])
        
        // Register custom cell
        autoCompleteTableView.tableView.register(CustomAutoCompleteCell.self, forCellReuseIdentifier: CustomAutoCompleteCell.identifier)
    }
    
    private func registerForKeyboardNotifications() {
        let showNotification = UIResponder.keyboardWillShowNotification
        NotificationCenter.default.addObserver(forName: showNotification, object: nil, queue: .main) { [weak self] notification in
            guard let keyBoardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
                return
            }
            self?.textViewBottomAnchor?.constant = -(keyBoardSize.height + 10.0 )
            self?.navigationController?.setNavigationBarHidden(true, animated: true)
            
            UIView.animate(withDuration: 0) {
                self?.view.layoutIfNeeded()
            } completion: { _ in
                self?.setUpAutoCompleteTableView()
            }
            
        }
        
        let hideNotification = UIResponder.keyboardWillHideNotification
        NotificationCenter.default.addObserver(forName: hideNotification, object: nil, queue: .main) { [weak self] _ in
            self?.view.removeBlur()
            self?.textViewBottomAnchor?.constant = -(self?.offSetValue ?? 20.0)
            self?.navigationController?.setNavigationBarHidden(false, animated: true)
            
            self?.autoCompleteTableView.tableView.removeFromSuperview()
            
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
        
        cityAutoComplete.searchCompleter.queryFragment = textField.text ?? ""
        // Table does not update without this line!
        autoCompleteTableView.tableView.reloadData()
//        textField.text = ""
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch traitCollection.userInterfaceStyle {
        case .light:
            view.addBlurView(style: .systemUltraThinMaterialDark)
        default:
            view.addBlurView(style: .systemThinMaterialDark)
        }
        view.bringSubviewToFront(self.textView.mainView)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        textView.searchTextField.text = ""
        view.removeBlur()
        cityAutoComplete.placeArray.removeAll()
        autoCompleteTableView.tableView.reloadData()
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension SearchVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityAutoComplete.placeArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomAutoCompleteCell.identifier, for: indexPath) as? CustomAutoCompleteCell else {
            return UITableViewCell()
        }
        cell.fillPlaceLabel(cityAutoComplete.placeArray[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let tappedCell = tableView.cellForRow(at: indexPath) as? CustomAutoCompleteCell else {
            return
        }
        view.endEditing(true)
        let place = tappedCell.placeLabel.text ?? ""
        addressManager.fetchCoordinatesFromAddress(place)
        autoCompleteTableView.tableView.removeFromSuperview()
        searchCollectionView.collectionView.reloadData()
    }
}

// MARK: - MKLocalSearchCompleterDelegate
extension SearchVC: MKLocalSearchCompleterDelegate {
    
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        let searchResults = cityAutoComplete.getCityList(results: completer.results)
        
        for i in 0..<searchResults.count {
            
            // Next 4 lines of code help to format street etc. into the city and country
            cityAutoComplete.searchRequest.naturalLanguageQuery = "\(searchResults[i].city), \(searchResults[i].country)"
            cityAutoComplete.searchRequest.region = MKCoordinateRegion.init(.world)
            cityAutoComplete.searchRequest.resultTypes = MKLocalSearch.ResultType.address
            cityAutoComplete.getPlaces(tableView: autoCompleteTableView.tableView)
        }
    }
    
    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        print(error.localizedDescription)
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
        let startPoint = CGPoint(x: 0.0, y: 0.0)
        let endPoint = CGPoint(x: 1.0, y: 0.9)
        
        DispatchQueue.main.async { [weak self] in
            switch self?.traitCollection.userInterfaceStyle {
            case .light, .unspecified:
                cell.mainView.addGradient(SearchColors.collectionTop,
                                          SearchColors.collectionBottom,
                                          startPoint,
                                          endPoint)
            case .dark:
                cell.mainView.addGradient(SearchColors.collectionTop,
                                          SearchColors.collectionBottom1,
                                          startPoint,
                                          endPoint)
            case .none:
                break
            case .some(_):
                break
            }
        }
        
        cell.delegate = self
        cell.setUpCity(self.cityArray[indexPath.row].name)
        cell.setUpDescription(self.cityArray[indexPath.row].conditionDescription)
        cell.setUpTemperature(self.cityArray[indexPath.row].temperature)
        cell.setUpConditionImage(self.cityArray[indexPath.row].conditionImage)
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
            
            deleteAction.image =  UIImage(systemName: "trash", withConfiguration: largeConfig)?.withTintColor(CustomColors.colorVanilla ?? .white, renderingMode: .alwaysTemplate).addBackgroundCircle(.systemRed)
            deleteAction.font = UIFont(name: CustomFonts.loraMedium, size: 17.5)
            deleteAction.textColor = CustomColors.colorGray
            
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
        cityModel.temperature = converter.convertTemperature(currentWeather.temperature ?? 0.0)
        cityModel.conditionImage = currentWeather.weatherIcon
        
        cityArray.append(cityModel)
        
        searchCollectionView.collectionView.reloadData()
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
            .foregroundColor: OtherUIColors.navigationItems as Any,
            .font: UIFont(name: CustomFonts.nunitoBold, size: 26) ?? UIFont.systemFont(ofSize: 26)
        ]
        
        // Setup NavigationBar and remove bottom border
        navigationItem.standardAppearance = appearance
        
        // Disable Back button
        navigationItem.setHidesBackButton(true, animated: true)
        
        // Custom Left Button
        let backButton = UIButton()
        backButton.customNavigationButton(UIImages.backLeft,
                                          OtherUIColors.navigationItems)
        let leftButton = UIBarButtonItem(customView: backButton)
        navigationItem.leftBarButtonItem = leftButton
        backButton.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
    }
}

