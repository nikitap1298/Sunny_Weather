//
//  ViewController.swift
//  Sunny
//
//  Created by Nikita Pishchugin on 30.06.2022.
//

import UIKit
import CoreLocation
import Charts
import Alamofire
import SPIndicator
import Network

// MARK: - Enum DayButtonType
enum DayButtonType {
    case now
    case next7Days
}

class OnboardingVC: UIViewController, ChartViewDelegate {

    // MARK: - Private Properties
    private let internetMonitor = NWPathMonitor()
    private let internetQueue = DispatchQueue(label: "InternetConnectionMonitor")
    
    private let currentWeatherSpace = CurrentWeatherSpace()
    private let currentWeatherView = CurrentWeatherView()
    private let mainScrollView = MainScrollView()
    private let temperatureCollectionView = TemperatureCollectionView()
    private let daybuttons = DayButtons()
    private let todayConditionView = TodayConditionView()
    private let graphView = GraphView()
    private let weatherKitView = WeatherKitView()
    private let nextFiveDaysConditionView = NextSevenDaysConditionView()
    
    private let tokenManager = TokenManager()
    private var weatherManager = WeatherManager()
    private var addressManager = AddressManager()
    private let locationManager = CLLocationManager()
    
    private var addressModel = AddressModel()
    private var coordinateModel = CoordinateModel()
    private var currentWeatherModel = CurrentWeatherModel()
    private var hourlyForecastModel = HourlyForecastModel()
    private var dailyForecastModel = DailyForecastModel()
    private let hourlyConditionImage = HourlyConditionImage()
    private var conditionImageArray = [UIImage]()
    
    // Models
    private let converter = Converter()
    private let timeConverter = TimeConverter()
    private let timeModel = TimeModel()
    private let currentTemperatureModel = CurrentTemperatureModel()
    
    private var todayButtonPressed: Bool = true
    private var firstLaunch: Bool = true
    private var isCurrent: Bool = true
    
    private var latitude = 0.0
    private var longitude = 0.0
    
    // MARK: - Public Properties
    var locationTimer = Timer()
    var currentForecastTimer = Timer()
    var cityForecastTimer = Timer()
    
    // MARK: - Computed Properties
    
    // When timeZone gets a correct value, all elements change
    private var timeZone: Int? {
        didSet {
            currentTemperatureModel.fillView(currentWeatherView,
                                             todayConditionView,
                                             currentWeatherModel,
                                             converter,
                                             timeConverter,
                                             timeZone)
            setUpGraph()
            temperatureCollectionView.collectionView.reloadData()
            nextFiveDaysConditionView.collectionView.reloadData()
        }
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkInternetConnection()
        
        customNavigationBar()
        addressManager.addressManagerDelegate = self

        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        choosePlace()
        
        locationTimer = Timer.scheduledTimer(withTimeInterval: 180.0, repeats: true) { [weak self] _ in
            self?.locationManager.requestWhenInUseAuthorization()
            self?.locationManager.startUpdatingLocation()
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        weatherManager.weatherManagerDelegate = self
        locationManager.delegate = self
        
        // Reload all views
        currentTemperatureModel.fillView(currentWeatherView,
                                         todayConditionView,
                                         currentWeatherModel,
                                         converter,
                                         timeConverter,
                                         timeZone)
        
        temperatureCollectionView.collectionView.reloadData()
        nextFiveDaysConditionView.collectionView.reloadData()
        
        // Which city will be shown
        setUpCurrentTemperatureView()
        setUpMainScrollView()
        
        setUpTemperatureCollectionView()
        setUpDayButtons()
        
        if todayButtonPressed {
            setUpNowView()
        } else {
            setUpNextFiveDaysView()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        setUpGradientForTodayConditionView()
    }
    
    // MARK: - Actions
    @objc private func didTapSettingsButton() {
        let viewController = SettingsVC()
        navigationController?.pushViewControllerFromLeft(controller: viewController)
    }
    
    @objc private func didTapSearchButton() {
        let viewController = SearchVC()
        viewController.searchVCDelegate = self
        viewController.latitude = latitude
        viewController.longitude = longitude
        navigationController?.pushViewControllerFromRight(controller: viewController)
    }
    
    @objc private func didTapTodayButton() {
        dayButtonsLogic(for: .now)
    }
    
    @objc private func didTapNextFiveDaysButton() {
        dayButtonsLogic(for: .next7Days)
    }
    
    // MARK: - ChoosePlace Function
    private func choosePlace() {
        let isCurrentDef = UserDefaults.standard.value(forKey: UserDefaultsKeys.isCurrent) as? Bool
        isCurrent = isCurrentDef ?? true
        
        if isCurrent {
            DispatchQueue.global().asyncAfter(deadline: .now() + 1.0) { [weak self] in
                self?.addressManager.fetchAddressFromCoord(self?.latitude ?? 0.0, self?.longitude ?? 0.0)
            }
            currentForecastTimer = Timer.scheduledTimer(withTimeInterval: 600.0, repeats: true) { [weak self] _ in
//                print("1")
                self?.addressManager.fetchAddressFromCoord(self?.latitude ?? 0.0, self?.longitude ?? 0.0)
            }
        } else {
            guard let city = UserDefaults.standard.string(forKey: UserDefaultsKeys.city) else { return }
            addressManager.fetchCoordinatesFromAddress(city)
            cityForecastTimer = Timer.scheduledTimer(withTimeInterval: 600.0, repeats: true, block: { [weak self] _ in
//                print("2")
                self?.addressManager.fetchCoordinatesFromAddress(city)
            })
        }
    }
    
    // MARK: - Private Functions (UI)
    
    // Check internet connection
    private func checkInternetConnection() {
        internetMonitor.pathUpdateHandler = { pathHandler in
            if pathHandler.status == .satisfied {
                print("Internet connection is on")
            } else {
                DispatchQueue.main.async { [weak self] in
                    let viewController = NoInternetVC()
                    viewController.modalPresentationStyle = .overFullScreen
                    viewController.modalTransitionStyle = .coverVertical
                    self?.present(viewController, animated: true)
                }
            }
        }
        
        internetMonitor.start(queue: internetQueue)
    }
    
    // CurrentTemperatureView
    private func setUpCurrentTemperatureView() {
        view.addSubview(currentWeatherSpace.mainView)
        currentWeatherSpace.mainView.addSubview(currentWeatherView.mainView)
        
        NSLayoutConstraint.activate([
            currentWeatherSpace.mainView.topAnchor.constraint(equalTo: view.topAnchor, constant: -30),
            currentWeatherSpace.mainView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            currentWeatherSpace.mainView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            currentWeatherSpace.mainView.heightAnchor.constraint(equalToConstant: view.frame.height / 2.3),
            
            currentWeatherView.mainView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            currentWeatherView.mainView.leadingAnchor.constraint(equalTo: currentWeatherSpace.mainView.leadingAnchor, constant: 10),
            currentWeatherView.mainView.trailingAnchor.constraint(equalTo: currentWeatherSpace.mainView.trailingAnchor, constant: -10),
            currentWeatherView.mainView.bottomAnchor.constraint(equalTo: currentWeatherSpace.mainView.bottomAnchor, constant: 0)
        ])
    }
    
    // ScrollView
    private func setUpMainScrollView() {
        view.addSubview(mainScrollView.scrollView)
        
        NSLayoutConstraint.activate([
            mainScrollView.scrollView.topAnchor.constraint(equalTo: currentWeatherSpace.mainView.bottomAnchor, constant: 20),
            mainScrollView.scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            mainScrollView.scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            mainScrollView.scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
    }
    
    // CollectionView
    private func setUpTemperatureCollectionView() {
        mainScrollView.contentView.addSubview(temperatureCollectionView.collectionView)
        
        NSLayoutConstraint.activate([
            temperatureCollectionView.collectionView.topAnchor.constraint(equalTo: mainScrollView.contentView.topAnchor, constant: 0),
            temperatureCollectionView.collectionView.leadingAnchor.constraint(equalTo: mainScrollView.contentView.leadingAnchor, constant: 5),
            temperatureCollectionView.collectionView.trailingAnchor.constraint(equalTo: mainScrollView.contentView.trailingAnchor, constant: -5),
            temperatureCollectionView.collectionView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    private func setUpDayButtons() {
        mainScrollView.contentView.addSubview(daybuttons.stackView)
        
        NSLayoutConstraint.activate([
            daybuttons.stackView.topAnchor.constraint(equalTo: temperatureCollectionView.collectionView.safeAreaLayoutGuide.bottomAnchor, constant: 20),
            daybuttons.stackView.leadingAnchor.constraint(equalTo: mainScrollView.contentView.leadingAnchor, constant: 25),
            daybuttons.stackView.trailingAnchor.constraint(equalTo: mainScrollView.contentView.trailingAnchor, constant: -25),
            daybuttons.stackView.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        daybuttons.todayButton.addTarget(self, action: #selector(didTapTodayButton), for: .touchUpInside)
        daybuttons.nextTenDaysButton.addTarget(self, action: #selector(didTapNextFiveDaysButton), for: .touchUpInside)
    }
    
    private func setUpNowView() {
        mainScrollView.contentView.addSubview(todayConditionView.mainView)
        mainScrollView.contentView.addSubview(graphView.lineChartView)
        mainScrollView.contentView.addSubview(weatherKitView.horizontalStack)
        
        NSLayoutConstraint.activate([
            todayConditionView.mainView.topAnchor.constraint(equalTo: daybuttons.stackView.bottomAnchor, constant: 20),
            todayConditionView.mainView.leadingAnchor.constraint(equalTo: mainScrollView.contentView.leadingAnchor, constant: 10),
            todayConditionView.mainView.trailingAnchor.constraint(equalTo: mainScrollView.contentView.trailingAnchor, constant: -10),
            todayConditionView.mainView.heightAnchor.constraint(equalToConstant: 445),
            
            graphView.lineChartView.topAnchor.constraint(equalTo: todayConditionView.mainView.bottomAnchor, constant: 50),
            graphView.lineChartView.leadingAnchor.constraint(equalTo: mainScrollView.contentView.leadingAnchor, constant: 10),
            graphView.lineChartView.trailingAnchor.constraint(equalTo: mainScrollView.contentView.trailingAnchor, constant: -10),
            graphView.lineChartView.heightAnchor.constraint(equalToConstant: 250),
            
            weatherKitView.horizontalStack.topAnchor.constraint(equalTo: graphView.lineChartView.bottomAnchor, constant: 30),
            weatherKitView.horizontalStack.centerXAnchor.constraint(equalTo: mainScrollView.contentView.centerXAnchor, constant: 0)
        ])
    }
    
    private func setUpNextFiveDaysView() {
        mainScrollView.contentView.addSubview(nextFiveDaysConditionView.collectionView)
        
        NSLayoutConstraint.activate([
            nextFiveDaysConditionView.collectionView.topAnchor.constraint(equalTo: daybuttons.stackView.bottomAnchor, constant: 20),
            nextFiveDaysConditionView.collectionView.leadingAnchor.constraint(equalTo: mainScrollView.contentView.leadingAnchor, constant: 10),
            nextFiveDaysConditionView.collectionView.trailingAnchor.constraint(equalTo: mainScrollView.contentView.trailingAnchor, constant: -10),
        ])
    }
    
    private func dayButtonsLogic(for dayButtonType: DayButtonType) {
        switch dayButtonType {
        case .now:
            daybuttons.todayButton.setTitleColor(CustomColors.colorVanilla, for: .normal)
            daybuttons.nextTenDaysButton.setTitleColor(CustomColors.colorDarkBlue1, for: .normal)
            mainScrollView.contentViewHeightAnchor?.constant = Constraints.contentViewTodayHeight
            todayButtonPressed = true
            nextFiveDaysConditionView.collectionView.removeFromSuperview()
            setUpNowView()
        case .next7Days:
            if dailyForecastModel.temperatureMin.count > 0 {
                daybuttons.todayButton.setTitleColor(CustomColors.colorDarkBlue1, for: .normal)
                daybuttons.nextTenDaysButton.setTitleColor(CustomColors.colorVanilla, for: .normal)
                mainScrollView.contentViewHeightAnchor?.constant = Constraints.contentViewNextTenDaysHeight
                todayButtonPressed = false
                todayConditionView.mainView.removeFromSuperview()
                graphView.lineChartView.removeFromSuperview()
                weatherKitView.horizontalStack.removeFromSuperview()
                setUpNextFiveDaysView()
            } else {
                SPIndicator.present(title: "Error", message: "Try again later", preset: .error, haptic: .error)
            }
        }
    }
    
    private func setUpGradientForTodayConditionView() {
        
        let startPoint = CGPoint(x: 0.0, y: 0.2)
        let endPoint = CGPoint(x: 1.0, y: 0.9)
        
        view.addGradient(OnboardingColors.backgroundTop, OnboardingColors.backgroundBottom)
        
        currentWeatherSpace.mainView.addGradient(OnboardingColors.weatherBlocksTop,
                                                 OnboardingColors.weatherBlocksBottom)

        for i in todayConditionView.parameterArray {
            i.mainView.addGradient(OnboardingColors.weatherBlocksTop,
                                   OnboardingColors.weatherBlocksBottom,
                                   startPoint,
                                   endPoint)
        }
    }
    
    private func setUpGraph() {
        var entries = [ChartDataEntry]()
        
        DispatchQueue.main.async { [weak self] in
            
            guard let self = self else { return }
    
            if self.hourlyForecastModel.temperatureApparent.count > 23 {
        
                for i in Ranges.next24Hours {
                    entries.append(ChartDataEntry(x: self.timeConverter.convertToSeconds(self.hourlyForecastModel.forecastStart[i], self.timeZone),
                                                  y: self.hourlyForecastModel.temperatureApparent[i]))
                }
            }

            let set1 = LineChartDataSet(entries: entries, label: "Feels like in the next 24 hours")
            set1.drawCirclesEnabled = false
            set1.mode = .cubicBezier
            set1.lineWidth = 3
            set1.setColor(OnboardingColors.graphLine ?? .blue)
            set1.fillColor = OnboardingColors.graphSpace?.withAlphaComponent(1.0) ?? .blue
            set1.drawFilledEnabled = true
            
            set1.drawHorizontalHighlightIndicatorEnabled = false
            set1.highlightColor = CustomColors.colorRed ?? .systemRed
            
            let data = LineChartData(dataSet: set1)
            data.setDrawValues(false)
            
            self.graphView.lineChartView.data = data
            self.graphView.lineChartView.delegate = self
        }
    }
    
}

// MARK: - AddressManagerDelegate
extension OnboardingVC: AddressManagerDelegate {
    
    func didGetCoordinate(_ addressManager: AddressManager, addressModel: AddressModel) {
        self.addressModel = addressModel

        weatherManager.fetchCurrentWeather(addressModel.latitude, addressModel.longitude)
        weatherManager.fetchHourlyForecast(addressModel.latitude, addressModel.longitude)
        weatherManager.fetchDailyForecast(addressModel.latitude, addressModel.longitude)
        
        // Get Timezone
        timeModel.getTimezone(addressModel.latitude, addressModel.longitude) { timeZone in
            self.timeZone = timeZone
        }
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.navigationItem.title = addressModel.name
            
            if addressModel.name == "" && addressModel.countryCode == "" {
                self.currentWeatherView.cityNameLabel.text = addressModel.countryCode
            } else {
                self.currentWeatherView.cityNameLabel.text = addressModel.name + ", " + addressModel.countryCode
            }
        }
        
    }
    
    func didGetAddress(_ addressManager: AddressManager, coordinateModel: CoordinateModel) {
        self.coordinateModel = coordinateModel
        
        weatherManager.fetchCurrentWeather(coordinateModel.latitude, coordinateModel.longitude)
        weatherManager.fetchHourlyForecast(coordinateModel.latitude, coordinateModel.longitude)
        weatherManager.fetchDailyForecast(coordinateModel.latitude, coordinateModel.longitude)
        
        // Get Timezone
        timeModel.getTimezone(coordinateModel.latitude, coordinateModel.longitude) { timeZone in
            self.timeZone = timeZone
        }
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.navigationItem.title = coordinateModel.locality
            
            if coordinateModel.locality == "" && coordinateModel.countryCode == "" {
                self.currentWeatherView.cityNameLabel.text = coordinateModel.countryCode
            } else {
                self.currentWeatherView.cityNameLabel.text = coordinateModel.locality + ", " + coordinateModel.countryCode
            }
        }
    }
}

// MARK: - WeatherManagerDelegate
extension OnboardingVC: WeatherManagerDelegate {
    
    func didUpdateCurrentWeather(_ weatherManager: WeatherManager, currentWeather: CurrentWeatherModel) {
        self.currentWeatherModel = currentWeather
        
        DispatchQueue.main.async { [weak self] in
            self?.currentTemperatureModel.fillView(self?.currentWeatherView,
                                                   self?.todayConditionView,
                                                   currentWeather,
                                                   self?.converter,
                                                   self?.timeConverter,
                                                   self?.timeZone)
        }
    }
    
    func didUpdateHourlyForecast(_ weatherManager: WeatherManager, hourlyForecast: HourlyForecastModel) {
        self.hourlyForecastModel = hourlyForecast
        
        // Add condition images into array
        conditionImageArray.removeAll()
        for (index, condition) in hourlyForecastModel.conditionCode.enumerated() {
            conditionImageArray.append(hourlyConditionImage.weatherIcon(condition, hourlyForecastModel.daylight[index]) ?? .checkmark)
        }
        temperatureCollectionView.collectionView.delegate = self
        temperatureCollectionView.collectionView.dataSource = self
        temperatureCollectionView.collectionView.reloadData()
        
        self.setUpGraph()
    }
    
    func didUpdateDailyForecast(_ weatherManager: WeatherManager, dailyForecast: DailyForecastModel) {
        self.dailyForecastModel = dailyForecast
        
        nextFiveDaysConditionView.collectionView.delegate = self
        nextFiveDaysConditionView.collectionView.dataSource = self
        nextFiveDaysConditionView.collectionView.reloadData()
    }
}

// MARK: - CLLocationManagerDelegate
extension OnboardingVC: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationManager.stopUpdatingLocation()
        latitude = locations.last?.coordinate.latitude ?? 0.0
        longitude = locations.last?.coordinate.longitude ?? 0.0
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension OnboardingVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.temperatureCollectionView.collectionView {
            return hourlyForecastModel.temperature[Ranges.next24Hours].count
        } else if collectionView == self.nextFiveDaysConditionView.collectionView {
            return dailyForecastModel.temperatureMin[Ranges.next7Days].count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // Temperature CollectionView
        if collectionView == temperatureCollectionView.collectionView {
            guard let cell = temperatureCollectionView.collectionView.dequeueReusableCell(withReuseIdentifier: CustomTemperatureCollectionCell.reuseIdentifier, for: indexPath) as? CustomTemperatureCollectionCell else {
                return UICollectionViewCell()
            }
            
            let conditionImage = self.conditionImageArray[indexPath.row + 1]
            let time = timeConverter.convertToHoursMinutes(hourlyForecastModel.forecastStart[indexPath.row + 1], timeZone)
            let temperature = converter.convertTemperature(hourlyForecastModel.temperature[indexPath.row + 1])
            
            DispatchQueue.main.async { [weak self] in
                let startPoint = CGPoint(x: 0.0, y: 0.2)
                let endPoint = CGPoint(x: 1.0, y: 0.9)
                
                switch self?.traitCollection.userInterfaceStyle {
                case .light, .unspecified:
                    cell.mainView.addGradient(OnboardingColors.weatherBlocksTop,
                                              OnboardingColors.collectionBottom,
                                              startPoint,
                                              endPoint)
                case .dark:
                    cell.mainView.addGradient(OnboardingColors.weatherBlocksTop,
                                              OnboardingColors.collectionBottom1,
                                              startPoint,
                                              endPoint)
                case .none:
                    break
                case .some(_):
                    break
                }
                
                cell.setUpCollectionCellValues(condImage: conditionImage, time: time, temperature: temperature)
            }
            return cell
        }
        
        // NextSevenDays ConditionView
        if collectionView == nextFiveDaysConditionView.collectionView {
            guard let cell = nextFiveDaysConditionView.collectionView.dequeueReusableCell(withReuseIdentifier: NextSevenDaysConditionCell.reuseIdentifier, for: indexPath) as? NextSevenDaysConditionCell else {
                return UICollectionViewCell()
            }
            
            let date = timeConverter.convertToDayNumber(dailyForecastModel.forecastStart[indexPath.row], timeZone: timeZone)
            let temperatureMin = converter.convertTemperature(dailyForecastModel.temperatureMin[indexPath.row])
            let temperatureMax = converter.convertTemperature(dailyForecastModel.temperatureMax[indexPath.row])
            let conditionImage = hourlyConditionImage.weatherIcon(dailyForecastModel.conditionCode[indexPath.row],
                                                                  true)
            
            DispatchQueue.main.async { [weak self] in
                let startPoint = CGPoint(x: 0.0, y: 0.2)
                let endPoint = CGPoint(x: 1.0, y: 0.9)
                
                if indexPath.row == 0 {
                    cell.setUpDate("Today")
                } else {
                    cell.setUpDate(date)
                }
                
                switch self?.traitCollection.userInterfaceStyle {
                case .light, .unspecified:
                    cell.mainView.addGradient(OnboardingColors.weatherBlocksTop,
                                              OnboardingColors.collectionBottom,
                                              startPoint,
                                              endPoint)
                case .dark:
                    cell.mainView.addGradient(OnboardingColors.weatherBlocksTop,
                                              OnboardingColors.collectionBottom1,
                                              startPoint,
                                              endPoint)
                case .none:
                    break
                case .some(_):
                    break
                }
                
                cell.setUpTemperatureLabel(temperatureMin, temperatureMax)
                cell.setUpConditionImage(conditionImage)
            }
            return cell
        }
        return UICollectionViewCell()
    }
    
    // Open HourVC after user tap cell
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let tappedCell = collectionView.cellForItem(at: indexPath) as? CustomTemperatureCollectionCell  {
            let viewController = HourVC()
            viewController.hourlyForecastModel = hourlyForecastModel
            viewController.cellDate = tappedCell.timeLabel.text ?? "Time"
            viewController.currentIndex = indexPath.row
            navigationController?.pushViewControllerFromRight(controller: viewController)
        }
//        else if let tappedCell2 = collectionView.cellForItem(at: indexPath) as? NextSevenDaysConditionCell {
//            let viewController = DayVC()
//            viewController.cellDate = tappedCell2.dateLabel.text ?? "Day"
//            navigationController?.pushViewControllerFromRight(controller: viewController)
//        }
        
    }
    
}

// MARK: - SearchVCDelegate
extension OnboardingVC: SearchVCDelegate {
    
    func didSendName(_ name: String) {
        print(name)
        currentForecastTimer.invalidate()
//        isCurrent = false
        UserDefaults.standard.set(name, forKey: UserDefaultsKeys.city)
//        UserDefaults.standard.set(isCurrent, forKey: UserDefaultsKeys.isCurrent)
        addressManager.fetchCoordinatesFromAddress(name)
    }
}

// MARK: - OnboardingViewController
private extension OnboardingVC {
    func customNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .clear
        navigationItem.title = "Weather"
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
        let settingsButton = UIButton()
        settingsButton.customNavigationButton(UIImages.settings,
                                              CustomColors.colorVanilla)
        let leftButton = UIBarButtonItem(customView: settingsButton)
        navigationItem.leftBarButtonItem = leftButton
        
        // Custom Right Button
        let searchButton = UIButton()
        searchButton.customNavigationButton(UIImages.search,
                                            CustomColors.colorVanilla)
        let rightButton = UIBarButtonItem(customView: searchButton)
        navigationItem.rightBarButtonItem = rightButton
        
        settingsButton.addTarget(self, action: #selector(didTapSettingsButton), for: .touchUpInside)
        searchButton.addTarget(self, action: #selector(didTapSearchButton), for: .touchUpInside)
    }
}
