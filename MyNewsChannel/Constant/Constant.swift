//
//  Constant.swift
//  MyNewsChannel
//
//  Created by Navi Vokavis on 19.10.22.
//

import UIKit

class APIProperty {
    static var shared = APIProperty()
    let apiKey = "&apiKey=7e19dda7c07f4af18ada19f113022fcd"
    // use 2 first symbols of system language in url request
    var topHeadlinesURL = URL(string: "https://newsapi.org/v2/top-headlines?language=\(Locale.preferredLanguages[0].prefix(2))&apiKey=7e19dda7c07f4af18ada19f113022fcd")
//    var topHeadlinesURL = URL(string: "https://newsapi.org/v2/top-headlines?language=\(symbolsOfLanguage)&apiKey=7e19dda7c07f4af18ada19f113022fcd")
    var forSearchLink = "https://newsapi.org/v2/everything?q="
}

let defaultLocalizer = AMPLocalizeUtils.defaultLocalizer
