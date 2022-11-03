//
//  Variables.swift
//  MyNewsChannel
//
//  Created by Navi Vokavis on 28.10.22.
//

import UIKit

//arrays for category Menu
var arrayWithTypes: [TypeFor] = []

var arrayWithUserSettings: [UserDefaultsModel] = []

var symbolsOfLanguage: String = "ru" {
    didSet {
        APIProperty.shared.topHeadlinesURL = URL(string: "https://newsapi.org/v2/top-headlines?language=\(symbolsOfLanguage)&apiKey=7e19dda7c07f4af18ada19f113022fcd")
    }
}

//var arrayWithDeletedTypes: [TypeFor] = []
