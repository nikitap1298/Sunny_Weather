//
//  CityAutoComplete.swift
//  Sunny
//
//  Created by Nikita Pishchugin on 02.11.2022.
//

import UIKit
import MapKit

class CityAutoComplete {
    
    // MARK: - Public Properties
    let searchCompleter = MKLocalSearchCompleter()
    let searchRequest = MKLocalSearch.Request()
    
    private var placeSet = Set<String>()
    var placeArray = [String]()
    
    // MARK: - Public Functions
    func getCityList(results: [MKLocalSearchCompletion]) -> [(city: String, country: String)] {
        
        var searchResults: [(city: String, country: String)] = []
        
        placeSet.removeAll()
        placeArray.removeAll()
        
        for result in results {
            let titleComponents = result.title.components(separatedBy: ", ")
            let subtitleComponents = result.subtitle.components(separatedBy: ", ")
            buildCityTypeA(titleComponents, subtitleComponents) { place in
                if place.city != "" && place.country != ""{
                    searchResults.append(place)
                }
            }
        }
        return searchResults
    }
    
    func getPlaces(tableView: UITableView) {
        let search = MKLocalSearch(request: searchRequest)
        
        search.start(completionHandler: { response, error in
            guard let response = response else { return }
            
            for item in response.mapItems {
                guard let place = item.placemark.title else { return }
                self.placeSet.insert(place)
                
                // Remove dublicates
                self.placeArray = Array(self.placeSet)
                tableView.reloadData()
            }
        })
    }
    
    // MARK: - Private Functions
    private func buildCityTypeA(_ title: [String],_ subtitle: [String], _ completion: @escaping ((city: String, country: String)) -> Void) {
        
        var city: String = ""
        var country: String = ""
        
        if title.count >= 0 && subtitle.count >= 1 {
            city = title.first ?? ""
            switch subtitle.count {
            case 1:
                country = subtitle.first ?? ""
            case 2:
                country = subtitle.last ?? ""
            case 3:
                country = subtitle.last ?? ""
            case 4:
                country = subtitle[2]
            default:
                break
            }
        }
        completion((city, country))
    }
    
    
}
