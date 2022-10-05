//
//  LocationAlertModel.swift
//  Sunny
//
//  Created by Nikita Pishchugin on 31.08.2022.
//

import UIKit

// Unused
struct LocationAlertModel {
   func openSettings() -> UIAlertController {
        let alertController = UIAlertController (title: "Location services are not enabled", message: "Go to Settings?", preferredStyle: .alert)
        
        let settingsAction = UIAlertAction(title: "Settings", style: .default) { _ in
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                return
            }
            
            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                    print("Settings opened: \(success)")
                })
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(settingsAction)
        alertController.addAction(cancelAction)
        return alertController
    }
}

