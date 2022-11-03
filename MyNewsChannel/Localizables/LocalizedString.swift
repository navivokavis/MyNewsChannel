//
//  LocalizedString.swift
//  MyNewsChannel
//
//  Created by Navi Vokavis on 1.11.22.
//

import UIKit

extension String {
    func localized(bundle: Bundle = .main, tableName: String = "Localizable") -> String {
        return NSLocalizedString(self, tableName: tableName, value: "**\(self)**", comment: "")
    }
}

class LocalizedString {
    
    struct NewsType {
//        static var ukraine = NewsType.getTitleFor(title: .choice1)
        static var ukraine: String{"Ukraine".localized()}
        static var war: String{"War".localized()}
        static var business: String{"Business".localized()}
        static var entertainment: String{"Entertainment".localized()}
        static var health: String{"Health".localized()}
        static var science: String{"Science".localized()}
        static var sports: String{"Sports".localized()}
        static var architecture: String{"Architecture".localized()}
        static var fashion: String{"Fashion".localized()}
        static var technology: String{"Technology".localized()}
        static var covid: String{"Covid-19".localized()} 
        
    }
    
    struct MainPage {
        static var title: String{"Top Rated News".localized()}
        static var newsWithCategory: String{"news".localized()}
    }
    
    struct UIMenu {
        static var titleMenu: String{"Change Category".localized()}
    }
    
    struct SearchPage {
        static var title: String{"Search".localized()}
    }
    
    struct SettingsPage {
        static var title: String{"Settings".localized()}
        static var inputTextLabel: String{"Add your category".localized()}
        static var inputTextField: String{"Input search keyword".localized()}
    }
    
    struct LanguagePicker {
        static var done: String{"Done".localized()}
    }
    
}
