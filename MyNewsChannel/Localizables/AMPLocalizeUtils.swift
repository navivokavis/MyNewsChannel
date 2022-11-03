//
//  AMPLocalizeUtils.swift
//  MyNewsChannel
//
//  Created by Navi Vokavis on 2.11.22.
//

import UIKit

class AMPLocalizeUtils: NSObject {

    static let defaultLocalizer = AMPLocalizeUtils()
    var appbundle = Bundle.main
    
    func setSelectedLanguage(lang: String) {
        guard let langPath = Bundle.main.path(forResource: lang, ofType: "lproj") else {
            appbundle = Bundle.main
            return
        }
        appbundle = Bundle(path: langPath)!
    }
    
    func stringForKey(key: String) -> String {
        return appbundle.localizedString(forKey: key, value: "", table: nil)
    }
}
