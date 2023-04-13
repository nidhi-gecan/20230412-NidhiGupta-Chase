//
//  Utility.swift
//  20230412-NidhiGupta-Chase
//
//  Created by Nidhi Gupta on 12/04/23.
//

import Foundation

class Utility {
    
    static var lastSearchedCity: String{
        get {
            let userDefaults = UserDefaults.standard
            var city = ""
            if let value = userDefaults.value(forKey: "city") as? String {
                city = value
            }
            return city
        }
        set {
            let userDefault = UserDefaults.standard
            userDefault.set(newValue, forKey: "city")
        }

    }
}
