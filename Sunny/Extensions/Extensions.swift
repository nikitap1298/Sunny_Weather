//
//  StringExtension.swift
//  Sunny
//
//  Created by Nikita Pishchugin on 16.08.2022.
//

import UIKit

// First letter in a sentense is Capital
extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}

// MARK: - Int
extension Int {
    
    // Int to Double
    func toDouble() -> Double {
        Double(self)
    }
    
    // Int to String
    func toString() -> String {
        String(self)
    }
}

// MARK: - Double
extension Double {
    
    // Double to Int
    func toInt() -> Int {
        Int(self)
    }
    
    // Double to String
    func toString() -> String {
        String(self)
    }
}

// MARK: - Set
extension Set {
    
    func item(at index: Int) -> Element {
        return self[self.index(startIndex, offsetBy: index)]
    }
}
