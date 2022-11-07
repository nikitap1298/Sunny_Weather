//
//  SceneDelegate.swift
//  Sunny
//
//  Created by Nikita Pishchugin on 30.06.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    private var onboarding = OnboardingVC()
    private var isLight: Bool = true
    private var isDark: Bool = false
    private var isSystem: Bool = false

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let _ = (scene as? UIWindowScene) else { return }
        
        // Appearance of the App
        setUpAppearance()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
        onboarding.locationTimer.invalidate()
        onboarding.cityForecastTimer.invalidate()
        onboarding.cityForecastTimer.invalidate()
    }
    
    private func setUpAppearance() {
        let light = UserDefaults.standard.value(forKey: UserDefaultsKeys.lightKey) as? Bool
        let dark = UserDefaults.standard.value(forKey: UserDefaultsKeys.darkKey) as? Bool
        let system = UserDefaults.standard.value(forKey: UserDefaultsKeys.systemKey) as? Bool
        
        isLight = light ?? true
        isDark = dark ?? false
        isSystem = system ?? false
        
//        print(isLight)
//        print(isDark)
//        print(isSystem)
        
        // Support only Light Mode
        NotificationCenter.default.addObserver(forName: NotificationNames.lightMode, object: nil, queue: .main) { [weak self] _ in
            guard let self = self else { return }
            self.isLight = true
            self.isDark = false
            self.isSystem = false
            UserDefaults.standard.set(self.isLight, forKey: UserDefaultsKeys.lightKey)
            UserDefaults.standard.set(self.isDark, forKey: UserDefaultsKeys.darkKey)
            UserDefaults.standard.set(self.isDark, forKey: UserDefaultsKeys.systemKey)
            
//            self.window?.overrideUserInterfaceStyle = .light
//            self.onboarding.loadView()
        }
        
        NotificationCenter.default.addObserver(forName: NotificationNames.darkMode, object: nil, queue: .main) { [weak self] _ in
            guard let self = self else { return }
            self.isLight = false
            self.isDark = true
            self.isSystem = false
            UserDefaults.standard.set(self.isLight, forKey: UserDefaultsKeys.lightKey)
            UserDefaults.standard.set(self.isDark, forKey: UserDefaultsKeys.darkKey)
            UserDefaults.standard.set(self.isDark, forKey: UserDefaultsKeys.systemKey)
            
//            self.window?.overrideUserInterfaceStyle = .dark
//            self.onboarding.loadView()
        }
        
        NotificationCenter.default.addObserver(forName: NotificationNames.systemMode, object: nil, queue: .main) { [weak self] _ in
            guard let self = self else { return }
            self.isLight = false
            self.isDark = false
            self.isSystem = true
            UserDefaults.standard.set(self.isLight, forKey: UserDefaultsKeys.lightKey)
            UserDefaults.standard.set(self.isDark, forKey: UserDefaultsKeys.darkKey)
            UserDefaults.standard.set(self.isSystem, forKey: UserDefaultsKeys.systemKey)
        }
        
        
        if isLight == true {
//            print("light")
            window?.overrideUserInterfaceStyle = .light
        } else if isDark == true {
//            print("dark")
            window?.overrideUserInterfaceStyle = .dark
        } else if isSystem == true {
//            print("system")
            window?.overrideUserInterfaceStyle = .unspecified
        }
    }

}

