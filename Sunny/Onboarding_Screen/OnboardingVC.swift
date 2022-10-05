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
    private let gradientModel = GradientModel()
    private let currentViewModel = CurrentViewModel()
    
    private var todayButtonPressed: Bool = true
    private var firstLaunch: Bool = true
    private var isCurrent: Bool = true
    
    private var latitude = 0.0
    private var longitude = 0.0
    
    var time: Int? {
        didSet {
            print("Change")
            print(time ?? 0)
        }
    }
    
    // MARK: - Public Properties
    var locationTimer = Timer()
//    var tokenTimer = Timer()
    var currentForecastTimer = Timer()
    var cityForecastTimer = Timer()
    
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
        currentViewModel.fillView(currentWeatherView,
                              todayConditionView,
                              currentWeatherModel,
                              converter,
                              timeConverter)
        setUpGraph()
        temperatureCollectionView.collectionView.reloadData()
        nextFiveDaysConditionView.collectionView.reloadData()
        
        // Which city will be shown
        setUpCurrentTemperatureView()
        setUpMainScrollView()
        
        setUpTemperatureCollectionView()
        setUpDayButtons()
        
        if todayButtonPressed {
            setUpTodayConditionView()
        } else {
            setUpNextFiveDaysConditionView()
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
        daybuttons.todayButton.setTitleColor(UIColor(named: CustomColors.colorVanilla), for: .normal)
        daybuttons.nextTenDaysButton.setTitleColor(UIColor(named: CustomColors.colorDarkBlue1), for: .normal)
        mainScrollView.contentViewHeightAnchor?.constant = Constraints.contentViewTodayHeight
        todayButtonPressed = true
        nextFiveDaysConditionView.collectionView.removeFromSuperview()
        setUpTodayConditionView()
    }
    
    @objc private func didTapNextFiveDaysButton() {
        if dailyForecastModel.temperatureMin.count == 10 {
            daybuttons.todayButton.setTitleColor(UIColor(named: CustomColors.colorDarkBlue1), for: .normal)
            daybuttons.nextTenDaysButton.setTitleColor(UIColor(named: CustomColors.colorVanilla), for: .normal)
            mainScrollView.contentViewHeightAnchor?.constant = Constraints.contentViewNextTenDaysHeight
            todayButtonPressed = false
            todayConditionView.mainView.removeFromSuperview()
            setUpNextFiveDaysConditionView()
        } else {
            SPIndicator.present(title: "Error", message: "Try again later", preset: .error, haptic: .error)
        }
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
                DispatchQueue.main.async {
                    let viewController = NoInternetVC()
                    viewController.modalPresentationStyle = .overFullScreen
                    viewController.modalTransitionStyle = .coverVertical
                    self.present(viewController, animated: true)
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
    
    private func setUpTodayConditionView() {
        mainScrollView.contentView.addSubview(todayConditionView.mainView)
        
        NSLayoutConstraint.activate([
            todayConditionView.mainView.topAnchor.constraint(equalTo: daybuttons.stackView.bottomAnchor, constant: 20),
            todayConditionView.mainView.leadingAnchor.constraint(equalTo: mainScrollView.contentView.leadingAnchor, constant: 10),
            todayConditionView.mainView.trailingAnchor.constraint(equalTo: mainScrollView.contentView.trailingAnchor, constant: -10),
            todayConditionView.mainView.heightAnchor.constraint(equalToConstant: 645)
        ])
    }
    
    private func setUpNextFiveDaysConditionView() {
        mainScrollView.contentView.addSubview(nextFiveDaysConditionView.collectionView)
        
        NSLayoutConstraint.activate([
            nextFiveDaysConditionView.collectionView.topAnchor.constraint(equalTo: daybuttons.stackView.bottomAnchor, constant: 20),
            nextFiveDaysConditionView.collectionView.leadingAnchor.constraint(equalTo: mainScrollView.contentView.leadingAnchor, constant: 10),
            nextFiveDaysConditionView.collectionView.trailingAnchor.constraint(equalTo: mainScrollView.contentView.trailingAnchor, constant: -10),
        ])
    }
    
    private func setUpGradientForTodayConditionView() {
        
        let startPoint = CGPoint(x: 0, y: 0)
        let endPoint = CGPoint(x: 0.8, y: 1)
        
        let startPoint1 = CGPoint(x: 0.0, y: 0.2)
        let endPoint1 = CGPoint(x: 1.0, y: 0.9)
        
        gradientModel.getGradient(view,
                                  UIColor(named: UIColors.backgroundTop),
                                  UIColor(named: UIColors.backgroundBottom),
                                  startPoint,
                                  endPoint)
        
        gradientModel.getGradient(currentWeatherSpace.mainView,
                                  UIColor(named: UIColors.viewTop),
                                  UIColor(named: UIColors.viewBottom),
                                  startPoint,
                                  endPoint)

        for i in todayConditionView.parameterArray {
            gradientModel.getGradient(i.mainView,
                                      UIColor(named: UIColors.viewTop),
                                      UIColor(named: UIColors.viewBottom),
                                      startPoint1,
                                      endPoint1)
        }
    }
    
    private func setUpGraph() {
        var entries = [ChartDataEntry]()
        
        DispatchQueue.main.async {
    
            if self.hourlyForecastModel.temperatureApparent.count > 23 {
        
                for i in Ranges.next24Hours {
                    entries.append(ChartDataEntry(x: self.timeConverter.convertToSeconds(self.hourlyForecastModel.forecastStart[i]),
                                                  y: self.converter.convertTemperatureToDouble(self.hourlyForecastModel.temperatureApparent[i])))
                }
            }

            let set1 = LineChartDataSet(entries: entries, label: "Feels like in the next 24 hours")
            set1.drawCirclesEnabled = false
            set1.mode = .cubicBezier
            set1.lineWidth = 3
            set1.setColor(UIColor(named: CustomColors.colorDarkBlue1) ?? .blue)
            set1.fillColor = UIColor(named: CustomColors.colorDarkBlue1)?.withAlphaComponent(1.0) ?? .blue
            set1.drawFilledEnabled = true
            
            set1.drawHorizontalHighlightIndicatorEnabled = false
            set1.highlightColor = UIColor(named: CustomColors.colorRed) ?? .systemRed
            
            let data = LineChartData(dataSet: set1)
            data.setDrawValues(false)
            
            self.todayConditionView.lineChartView.data = data
            self.todayConditionView.lineChartView.delegate = self
        }
    }
    
}

// MARK: - WeatherManagerDelegate
extension OnboardingVC: WeatherManagerDelegate {
    
    func didUpdateCurrentWeather(_ weatherManager: WeatherManager, currentWeather: CurrentWeatherModel) {
        self.currentWeatherModel = currentWeather
        print("current")
        
        // Get Timezone
        timeModel.getTimezone(currentWeather.latitude, currentWeather.longitude) { i in
            self.time = i
//            print(self.time)
        }
        
        DispatchQueue.main.async { [weak self] in
            self?.currentViewModel.fillView(self?.currentWeatherView,
                                        self?.todayConditionView,
                                        currentWeather, self?.converter,
                                        self?.timeConverter)
        }
    }
    
    func didUpdateHourlyForecast(_ weatherManager: WeatherManager, hourlyForecast: HourlyForecastModel) {
        self.hourlyForecastModel = hourlyForecast
        print("hourly")
        
        // Add condition images into array
        conditionImageArray.removeAll()
        for (index, condition) in hourlyForecastModel.conditionCode.enumerated() {
            conditionImageArray.append(hourlyConditionImage.weatherIcon(condition, hourlyForecastModel.daylight[index]) ?? .checkmark)
        }
        temperatureCollectionView.collectionView.delegate = self
        temperatureCollectionView.collectionView.dataSource = self
        nextFiveDaysConditionView.collectionView.delegate = self
        nextFiveDaysConditionView.collectionView.dataSource = self
        temperatureCollectionView.collectionView.reloadData()
        nextFiveDaysConditionView.collectionView.reloadData()
        
        self.setUpGraph()
    }
    
    func didUpdateDailyForecast(_ weatherManager: WeatherManager, dailyForecast: DailyForecastModel) {
        self.dailyForecastModel = dailyForecast
        print("daily")
        
//        print(dailyForecast.maxUvIndex)
    }
    
}

// MARK: - AddressManagerDelegate
extension OnboardingVC: AddressManagerDelegate {
    
    func didGetCoordinate(_ addressManager: AddressManager, addressModel: AddressModel) {
        self.addressModel = addressModel

        weatherManager.fetchCurrentWeather(addressModel.latitude, addressModel.longitude)
        weatherManager.fetchHourlyForecast(addressModel.latitude, addressModel.longitude)
        weatherManager.fetchDailyForecast(addressModel.latitude, addressModel.longitude)
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.navigationItem.title = addressModel.name
            self.currentWeatherView.cityNameLabel.text = addressModel.name + ", " + addressModel.countryCode
        }
        
    }
    
    func didGetAddress(_ addressManager: AddressManager, coordinateModel: CoordinateModel) {
        self.coordinateModel = coordinateModel
        
        weatherManager.fetchCurrentWeather(coordinateModel.latitude, coordinateModel.longitude)
        weatherManager.fetchHourlyForecast(coordinateModel.latitude, coordinateModel.longitude)
        weatherManager.fetchDailyForecast(coordinateModel.latitude, coordinateModel.longitude)
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.navigationItem.title = coordinateModel.locality
            self.currentWeatherView.cityNameLabel.text = coordinateModel.locality + ", " + coordinateModel.countryCode
        }
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
            let time = timeConverter.convertToHoursMinutes(hourlyForecastModel.forecastStart[indexPath.row + 1])
            let temperature = converter.convertTemperature(hourlyForecastModel.temperature[indexPath.row + 1])
            
            DispatchQueue.main.async { [weak self] in
                self?.gradientModel.getGradient(cell.mainView,
                                                UIColor(named: UIColors.viewTop),
                                                UIColor(named: UIColors.viewBottom),
                                                CGPoint(x: 0.0, y: 0.2),
                                                CGPoint(x: 1.0, y: 0.9))
                cell.setUpCollectionCellValues(condImage: conditionImage, time: time, temperature: temperature)
            }
            return cell
        }
        
        // NextFiveDays ConditionView
        if collectionView == nextFiveDaysConditionView.collectionView {
            guard let cell = nextFiveDaysConditionView.collectionView.dequeueReusableCell(withReuseIdentifier: NextFiveDaysConditionCell.reuseIdentifier, for: indexPath) as? NextFiveDaysConditionCell else {
                return UICollectionViewCell()
            }
            
            let date = timeConverter.convertToDayNumber(dailyForecastModel.forecastStart[indexPath.row])
            let temperatureMin = converter.convertTemperature(dailyForecastModel.temperatureMin[indexPath.row])
            let temperatureMax = converter.convertTemperature(dailyForecastModel.temperatureMax[indexPath.row])
            let conditionImage = hourlyConditionImage.weatherIcon(dailyForecastModel.conditionCode[indexPath.row],
                                                                  true)
            
            DispatchQueue.main.async {
                guard let firstColor = UIColor(named: UIColors.viewTop),
                      let secondColor = UIColor(named: UIColors.viewBottom) else { return }
                
                let startPoint = CGPoint(x: 0.0, y: 0.2)
                let endPoint = CGPoint(x: 1.0, y: 0.9)
                
                if indexPath.row == 0 {
                    cell.setUpDate("Today")
                } else {
                    cell.setUpDate(date)
                }
                
                cell.mainView.addGradient(firstColor, secondColor, startPoint, endPoint)
                cell.setUpTemperatureLabel(temperatureMin, temperatureMax)
                cell.setUpConditionImage(conditionImage)
            }
            return cell
        }
        return UICollectionViewCell()
    }
    
    // Open HourVC after user tap cell
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let tappedCell = collectionView.cellForItem(at: indexPath) as? CustomTemperatureCollectionCell else {
            return
        }
        
        let viewController = HourVC()
        viewController.hourlyForecastModel = hourlyForecastModel
        viewController.cellDate = tappedCell.timeLabel.text ?? "Time"
        viewController.currentIndex = indexPath.row
        navigationController?.pushViewControllerFromRight(controller: viewController)
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
        let settingsButton = UIButton()
        settingsButton.customNavigationButton(UIImage(named: CustomImages.settings),
                                              UIColor(named: CustomColors.colorVanilla))
        let leftButton = UIBarButtonItem(customView: settingsButton)
        navigationItem.leftBarButtonItem = leftButton
        
        // Custom Right Button
        let searchButton = UIButton()
        searchButton.customNavigationButton(UIImage(named: CustomImages.search),
                                              UIColor(named: CustomColors.colorVanilla))
        let rightButton = UIBarButtonItem(customView: searchButton)
        navigationItem.rightBarButtonItem = rightButton
        
        settingsButton.addTarget(self, action: #selector(didTapSettingsButton), for: .touchUpInside)
        searchButton.addTarget(self, action: #selector(didTapSearchButton), for: .touchUpInside)
    }
}
