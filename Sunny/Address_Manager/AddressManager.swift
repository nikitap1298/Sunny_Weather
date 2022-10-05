//
//  AddressManager.swift
//  Sunny
//
//  Created by Nikita Pishchugin on 08.09.2022.
//

import UIKit
import Alamofire
import CoreLocation

protocol AddressManagerDelegate: AnyObject {
    func didGetCoordinate(_ addressManager: AddressManager, addressModel: AddressModel)
    func didGetAddress(_ addressManager: AddressManager, coordinateModel: CoordinateModel)
}

struct AddressManager {
    
    private var tokenManager = TokenManager()
    
    private let addressURL = "https://maps-api.apple.com/v1/geocode?q="
    private let coordinatesURL = "https://maps-api.apple.com/v1/reverseGeocode?loc="
    
    weak var addressManagerDelegate: AddressManagerDelegate?
    
    // MARK: - Coordinates
    func fetchCoordinatesFromAddress(_ address: String) {
        tokenManager.generateToken { token in
            // City search using different languages
            let originalURL = addressURL + address.replacingOccurrences(of: " ", with: "%")
            let editedURL = originalURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? originalURL
            
            AF.request(editedURL,
                       headers: [.authorization(bearerToken: token)]).responseDecodable(of: AddressData.self) { response in
                guard let data = response.data else { return }
                if let address = self.parseAddressJSON(data) {
                    self.addressManagerDelegate?.didGetCoordinate(self, addressModel: address)
                }
            }
        }
    }
    
    private func parseAddressJSON(_ addressData: Data) -> AddressModel? {
        do {
            let address = try JSONDecoder().decode(AddressData.self, from: addressData)
            
            let latitude = address.results.first?.coordinate.latitude ?? 0.0
            let longitude = address.results.first?.coordinate.longitude ?? 0.0
            let country = address.results.first?.country ?? ""
            let countryCode = address.results.first?.countryCode ?? ""
            let name = address.results.first?.name ?? ""
            
            let addressData = AddressModel(latitude: latitude,
                                           longitude: longitude,
                                           country: country,
                                           countryCode: countryCode,
                                           name: name)
            return addressData
        } catch {
            print("Error parsing address: \(error.localizedDescription)")
            return nil
        }
    }
    
    // MARK: - Address
    func fetchAddressFromCoord(_ lat: CLLocationDegrees, _ long: CLLocationDegrees) {
        tokenManager.generateToken { token in
            AF.request(coordinatesURL + "\(lat)" + "%2C" + "\(long)",
                       headers: [.authorization(bearerToken: token)]).responseDecodable(of: CoordinateData.self) { response in
                guard let data = response.data else { return }
                if let coordinates = self.parseCoordinatesJSON(data) {
                    self.addressManagerDelegate?.didGetAddress(self, coordinateModel: coordinates)
                }
    //            print(response.request?.headers)
            }
        }
    }
    
    private func parseCoordinatesJSON(_ coordinateData: Data) -> CoordinateModel? {
        do {
            let coordinates = try JSONDecoder().decode(CoordinateData.self, from: coordinateData)
            
            let latitude = coordinates.сoordinateResult.first?.coordinate.latitude ?? 0.0
            let longitude = coordinates.сoordinateResult.first?.coordinate.longitude ?? 0.0
            let country = coordinates.сoordinateResult.first?.country ?? ""
            let countryCode = coordinates.сoordinateResult.first?.countryCode ?? ""
            let locality = coordinates.сoordinateResult.first?.structuredAddress?.locality ?? ""
            
            let coordinatesData = CoordinateModel(latitude: latitude,
                                                  longitude: longitude,
                                                  country: country,
                                                  countryCode: countryCode,
                                                  locality: locality)
            return coordinatesData
        } catch {
            print("Error parsing coordinates: \(error.localizedDescription)")
            return nil
        }
    }
    
}
