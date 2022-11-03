//
//  Extension.swift
//  MyNewsChannel
//
//  Created by Navi Vokavis on 18.10.22.
//

import UIKit

//MARK: - Create Custom NavigationController
extension UINavigationController {
    
    func setStatusBar(backgroundColor: UIColor) {
        let statusBarFrame: CGRect
        if #available(iOS 13.0, *) {
            statusBarFrame = view.window?.windowScene?.statusBarManager?.statusBarFrame ?? CGRect.zero
        } else {
            statusBarFrame = UIApplication.shared.statusBarFrame
        }
        let statusBarView = UIView(frame: statusBarFrame)
        statusBarView.backgroundColor = backgroundColor
        view.addSubview(statusBarView)
    }
 
    func setupNavigationController() {
        self.navigationBar.backgroundColor = .black
        self.navigationBar.barTintColor = .black
        self.navigationBar.barStyle = UIBarStyle.default
        self.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.setStatusBar(backgroundColor: .black)
        self.navigationBar.prefersLargeTitles = true
//        self.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
//        self.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 30)]
    }
    
    func setupNavigationMultilineTitle() {
        guard let navigationBar = self.navigationController?.navigationBar else { return }
        for sview in navigationBar.subviews {
            for ssview in sview.subviews {
                guard let label = ssview as? UILabel else { break }
                if label.text == self.title {
                    label.numberOfLines = 0
                    label.lineBreakMode = .byWordWrapping
                    label.sizeToFit()
                    UIView.animate(withDuration: 0.3, animations: {
                        navigationBar.frame.size.height = 57 + label.frame.height
                    })
                }
            }
        }
    }
    
}

extension UIViewController {
    
    //MARK: - Create Custom Navigation Bar
    func createCustomBarButton(imageName: String, selector: Selector) -> UIBarButtonItem {
        let customButton = UIButton(type: .system)
        customButton.setImage(
            UIImage(systemName: imageName)?.withRenderingMode(.alwaysTemplate),
            for: .normal
        )
        customButton.tintColor = .white
        customButton.imageView?.contentMode = .scaleAspectFit
        customButton.contentVerticalAlignment = .fill
        customButton.contentHorizontalAlignment = .fill
        customButton.addTarget(self, action: selector, for: .touchUpInside)
        
        let customBarButton = UIBarButtonItem(customView: customButton )
        
        return customBarButton
    }
  
}

//MARK: - Create alert controller --- Don't anable in this add
extension MainViewController {
    func presentSearchAlertController(withTitle title: String?, message: String?, style: UIAlertController.Style, completionHandler: @escaping (String) -> Void) {
        let aletrController = UIAlertController(title: title, message: message, preferredStyle: style)
        aletrController.addTextField()
        let search = UIAlertAction(title: "Search", style: .default) { action in
            let textField = aletrController.textFields?.first
            guard let keyWord = textField?.text else { return }
            if keyWord != "" {
                let key = keyWord.split(separator: " ").joined(separator: "%20")
                completionHandler(key)
            }
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        
        aletrController.addAction(search)
        aletrController.addAction(cancel)
        present(aletrController, animated: true)
    }
}


//MARK: - String extension

extension String {
    func localized(lang:String) ->String {
        
        let path = Bundle.main.path(forResource: lang, ofType: "lproj")
        let bundle = Bundle(path: path!)
        
        return NSLocalizedString(self, tableName: nil, bundle: bundle!, value: "", comment: "")
    }
    
}
