//
//  UserDefault.swift
//  MyNewsChannel
//
//  Created by Navi Vokavis on 1.11.22.
//

import Foundation

struct UserDefaultsModel {
    static var currentArrayKeys: String = "currentArrayKeys"
    
    static func saveArray(_ value: [TypeFor]) {
            UserDefaults.standard.set(try? PropertyListEncoder().encode(value), forKey: currentArrayKeys)
        }

    static func getArray() -> [TypeFor]? {
            var userData: [TypeFor]?
            if let data = UserDefaults.standard.value(forKey: currentArrayKeys) as? Data {
                userData = try? PropertyListDecoder().decode([TypeFor].self, from: data)
                return userData
            } else {
                return userData
            }
        }
        
}

